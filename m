Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E664CE1
	for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814980; cv=none; b=QenL/lGMOyZxNw1gnTIEjF2+uyxeYJDzpeh5cPlKXDsxLediShk1BzuBAAxpcgeCqAduBYKtwteKyXkgEZf83FRBFoE6TlNeP/yw9VQTkbrkFmrcFKeK9fmCS8U1HzSoAm+15KXufKq4zj4N/KyOI+9ppy1s2EdkeIYi8o42GfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814980; c=relaxed/simple;
	bh=9E9Mm1HUrBSC34QY5qjUm6nKWfEs8EDhBnP3Z7GzAHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VOdETYc11A19vQerGmUGjKh9ylEETZ25rU8kD6hiH3riBW/IqSouJv62AuQUsAmn+ipDvkppMxdJ7FUcNMbQQrE9j7+tjs36I0X58bwqCNSysR2bWyGrXTXPa8Zuh8Jn8tLrHcYjRV1V2y2LqgX5HwpneHFFwXxaSMfGM8NShqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WctUnj5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WctUnj5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C65C433F1;
	Tue, 19 Mar 2024 02:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710814979;
	bh=9E9Mm1HUrBSC34QY5qjUm6nKWfEs8EDhBnP3Z7GzAHQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WctUnj5NTfNGhERrZWKCpj0ubA4ajr2YTSBjJnZUAFzEmtQQRavcduhLwEj23rotS
	 i0iSOMpRhKOUfSNpyG8lv/PaQV5H5DnIQkVGWgULuYI4AOIwSfWJmXzp3OzTuxs4dc
	 +b3XB9ei6fVLMCK8fqQHw7cR6V5Lo7OMF0vbfGoXXYC8WcpKlJTbGK4f+rM/uLSwpW
	 h2++MYIkRQImeOlgbJ0RnAmaZMgE5khBkEYin2apWm1nWen2ewD/ILzPiwKeXRJW0k
	 weMW101IpPJ3c8wSFOaSnMPzWnbuIBVbXFvndAALiASrkUgqSx3fUJ/YzkTQuLaf1J
	 VhwbPsaauceow==
Message-ID: <f4f1cfac-8520-47a1-ad18-b9922aa0545d@kernel.org>
Date: Tue, 19 Mar 2024 10:22:54 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [bug report]WARNING: CPU: 22 PID: 44011 at
 fs/iomap/iter.c:51 iomap_iter+0x32b observed with blktests zbd/010
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
References: <CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com>
 <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
 <CAHj4cs874FivTdmw=VMJwTzzLFZWb4OKqvNGRN0R0O+Oiv4aYA@mail.gmail.com>
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
 <msec3wnqtvlsnfsw34uyrircyco3j3y7yb4gj75ofz5gnn57mg@qzcq5eumjwy5>
 <CAHj4cs-DC7QQH1W3KSzXS8ERMPW-6XQ9-w_Mzr1zEGF7ZZ=K3w@mail.gmail.com>
 <d6vi6aq44c4a7ekhck6zxxy4woa5q7v5bnvn5qmad7nqk7egms@ptc72tum4bks>
 <gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/18 13:47, Shinichiro Kawasaki via Linux-f2fs-devel wrote:
> I confirmed that the trigger commit is dbf8e63f48af as Yi reported. I took a
> look in the commit, but it looks fine to me. So I thought the cause is not
> in the commit diff.
> 
> I found the WARN is printed when the f2fs is set up with multiple devices,
> and read requests are mapped to the very first block of the second device in the
> direct read path. In this case, f2fs_map_blocks() and f2fs_map_blocks_cached()
> modify map->m_pblk as the physical block address from each block device. It
> becomes zero when it is mapped to the first block of the device. However,
> f2fs_iomap_begin() assumes that map->m_pblk is the physical block address of the
> whole f2fs, across the all block devices. It compares map->m_pblk against
> NULL_ADDR == 0, then go into the unexpected branch and sets the invalid
> iomap->length. The WARN catches the invalid iomap->length.
> 
> This WARN is printed even for non-zoned block devices, by following steps.
> 
>   - Create two (non-zoned) null_blk devices memory backed with 128MB size each:
>     nullb0 and nullb1.
>   # mkfs.f2fs /dev/nullb0 -c /dev/nullb1
>   # mount -t f2fs /dev/nullb0 "${mount_dir}"
>   # dd if=/dev/zero of="${mount_dir}/test.dat" bs=1M count=192
>   # dd if="${mount_dir}/test.dat" of=/dev/null bs=1M count=192 iflag=direct
> 
> I created a fix candidate patch [1]. It modifies f2fs_iomap_begin() to handle
> map->m_pblk as the physical block address from each device start, not the
> address of whole f2fs. I confirmed it avoids the WARN.
> 
> But I'm not so sure if the fix is good enough. map->m_pblk has dual meanings.
> Sometimes it holds the physical block address of each device, and sometimes
> the address of the whole f2fs. I'm not sure what is the condition for
> map->m_pblk to have which meaning. I guess F2FS_GET_BLOCK_DIO flag is the
> condition, but f2fs_map_blocks_cached() does not ensure it.
> 
> Also, I noticed that map->m_pblk is referred to in other functions below, and
> not sure if they need the similar change as I did for f2fs_iomap_begin().
> 
>    f2fs_fiemap()
>    f2fs_read_single_page()
>    f2fs_bmap()
>    check_swap_activate()
> 
> I would like to hear advices from f2fs experts for the fix.
> 
> 
> [1]
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 26e317696b33..5232223a69e5 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1569,6 +1569,7 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
>   		int bidx = f2fs_target_device_index(sbi, map->m_pblk);
>   		struct f2fs_dev_info *dev = &sbi->devs[bidx];
>   
> +		map->m_multidev_dio = true;
>   		map->m_bdev = dev->bdev;
>   		map->m_pblk -= dev->start_blk;
>   		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
> @@ -4211,9 +4212,11 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			    unsigned int flags, struct iomap *iomap,
>   			    struct iomap *srcmap)
>   {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct f2fs_map_blocks map = {};
>   	pgoff_t next_pgofs = 0;
> -	int err;
> +	block_t pblk;
> +	int err, i;
>   
>   	map.m_lblk = bytes_to_blks(inode, offset);
>   	map.m_len = bytes_to_blks(inode, offset + length - 1) - map.m_lblk + 1;
> @@ -4239,12 +4242,17 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	 * We should never see delalloc or compressed extents here based on
>   	 * prior flushing and checks.
>   	 */
> -	if (WARN_ON_ONCE(map.m_pblk == NEW_ADDR))
> +	pblk = map.m_pblk;
> +	if (map.m_multidev_dio && map.m_flags & F2FS_MAP_MAPPED)
> +		for (i = 0; i < sbi->s_ndevs; i++)
> +			if (FDEV(i).bdev == map.m_bdev)
> +				pblk += FDEV(i).start_blk;
> +	if (WARN_ON_ONCE(pblk == NEW_ADDR))
>   		return -EINVAL;
> -	if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
> +	if (WARN_ON_ONCE(pblk == COMPRESS_ADDR))
>   		return -EINVAL;

Shoudn't we check NEW_ADDR and COMPRESS_ADDR before multiple-device
block address conversion?

>   
> -	if (map.m_pblk != NULL_ADDR) {
> +	if (pblk != NULL_ADDR) {

How to distinguish NULL_ADDR and valid blkaddr 0? I guess it should
check F2FS_MAP_MAPPED flag first?

Thanks,

>   		iomap->length = blks_to_bytes(inode, map.m_len);
>   		iomap->type = IOMAP_MAPPED;
>   		iomap->flags |= IOMAP_F_MERGED;
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
