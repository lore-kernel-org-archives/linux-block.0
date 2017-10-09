Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48189 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdJITEL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2017 15:04:11 -0400
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v99J4ACi021897
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Mon, 9 Oct 2017 19:04:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v99J49AD014030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Mon, 9 Oct 2017 19:04:10 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v99J49up032082
        for <linux-block@vger.kernel.org>; Mon, 9 Oct 2017 19:04:09 GMT
Date: Mon, 9 Oct 2017 12:02:34 -0600
From: Liu Bo <bo.li.liu@oracle.com>
To: linux-block@vger.kernel.org
Subject: Re: [PATCH] Btrfs: avoid losing data raid profile when deleting a
 device
Message-ID: <20171009180234.GA16478@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
Reply-To: bo.li.liu@oracle.com
References: <20171009173809.11982-1-bo.li.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171009173809.11982-1-bo.li.liu@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Please ignore this, I put the wrong ML.

Thanks,

-liubo

On Mon, Oct 09, 2017 at 11:38:09AM -0600, Liu Bo wrote:
> We've avoided data losing raid profile when doing balance, but it
> turns out that deleting a device could also result in the same
> problem.
> 
> This fixes the problem by creating an empty data chunk before
> relocating the data chunk.
> 
> Metadata/System chunk are supposed to have non-zero bytes all the time
> so their raid profile is persistent.
> 
> Reported-by: James Alandt <James.Alandt@wdc.com>
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> ---
>  fs/btrfs/volumes.c | 87 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 68 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4a72c45..3f48bcd 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -144,6 +144,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>  			     u64 logical, u64 *length,
>  			     struct btrfs_bio **bbio_ret,
>  			     int mirror_num, int need_raid_map);
> +static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
> +				      u64 chunk_offset);
>  
>  DEFINE_MUTEX(uuid_mutex);
>  static LIST_HEAD(fs_uuids);
> @@ -3476,7 +3478,6 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  	u32 count_meta = 0;
>  	u32 count_sys = 0;
>  	int chunk_reserved = 0;
> -	u64 bytes_used = 0;
>  
>  	/* step one make some room on all the devices */
>  	devices = &fs_info->fs_devices->devices;
> @@ -3635,28 +3636,22 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  			goto loop;
>  		}
>  
> -		ASSERT(fs_info->data_sinfo);
> -		spin_lock(&fs_info->data_sinfo->lock);
> -		bytes_used = fs_info->data_sinfo->bytes_used;
> -		spin_unlock(&fs_info->data_sinfo->lock);
> -
> -		if ((chunk_type & BTRFS_BLOCK_GROUP_DATA) &&
> -		    !chunk_reserved && !bytes_used) {
> -			trans = btrfs_start_transaction(chunk_root, 0);
> -			if (IS_ERR(trans)) {
> -				mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> -				ret = PTR_ERR(trans);
> -				goto error;
> -			}
> -
> -			ret = btrfs_force_chunk_alloc(trans, fs_info,
> -						      BTRFS_BLOCK_GROUP_DATA);
> -			btrfs_end_transaction(trans);
> +		if (!chunk_reserved) {
> +			/*
> +			 * We may be relocating the only data chunk we have,
> +			 * which could potentially end up with losing data's
> +			 * raid profile, so lets allocate an empty one in
> +			 * advance.
> +			 */
> +			ret = btrfs_may_alloc_data_chunk(fs_info,
> +							 found_key.offset);
>  			if (ret < 0) {
>  				mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +				ret = PTR_ERR(trans);
>  				goto error;
> +			} else if (ret == 1) {
> +				chunk_reserved = 1;
>  			}
> -			chunk_reserved = 1;
>  		}
>  
>  		ret = btrfs_relocate_chunk(fs_info, found_key.offset);
> @@ -4327,6 +4322,48 @@ int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
>  }
>  
>  /*
> + * return 1 : allocate a data chunk successfully,
> + * return <0: errors during allocating a data chunk,
> + * return 0 : no need to allocate a data chunk.
> + */
> +static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
> +				      u64 chunk_offset)
> +{
> +	struct btrfs_block_group_cache *cache;
> +	u64 bytes_used;
> +	u64 chunk_type;
> +
> +	cache = btrfs_lookup_block_group(fs_info, chunk_offset);
> +	ASSERT(cache);
> +	chunk_type = cache->flags;
> +	btrfs_put_block_group(cache);
> +
> +	if (chunk_type & BTRFS_BLOCK_GROUP_DATA) {
> +		spin_lock(&fs_info->data_sinfo->lock);
> +		bytes_used = fs_info->data_sinfo->bytes_used;
> +		spin_unlock(&fs_info->data_sinfo->lock);
> +
> +		if (!bytes_used) {
> +			struct btrfs_trans_handle *trans;
> +			int ret;
> +
> +			trans =	btrfs_join_transaction(fs_info->tree_root);
> +			if (IS_ERR(trans))
> +				return PTR_ERR(trans);
> +
> +			ret = btrfs_force_chunk_alloc(trans, fs_info,
> +						      BTRFS_BLOCK_GROUP_DATA);
> +			btrfs_end_transaction(trans);
> +			if (ret < 0)
> +				return ret;
> +
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
>   * shrinking a device means finding all of the device extents past
>   * the new size, and then following the back refs to the chunks.
>   * The chunk relocation code actually frees the device extent
> @@ -4419,6 +4456,18 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>  		chunk_offset = btrfs_dev_extent_chunk_offset(l, dev_extent);
>  		btrfs_release_path(path);
>  
> +		/*
> +		 * We may be relocating the only data chunk we have,
> +		 * which could potentially end up with losing data's
> +		 * raid profile, so lets allocate an empty one in
> +		 * advance.
> +		 */
> +		ret = btrfs_may_alloc_data_chunk(fs_info, chunk_offset);
> +		if (ret < 0) {
> +			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
> +			goto done;
> +		}
> +
>  		ret = btrfs_relocate_chunk(fs_info, chunk_offset);
>  		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
>  		if (ret && ret != -ENOSPC)
> -- 
> 2.9.4
> 
