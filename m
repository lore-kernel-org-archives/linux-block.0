Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508158;
	b=IpbkFBjZ4EmlHfq/61pc/fX5SkCt4YavKX6p0me22BHEJcOPYCMvr/pId5N7wZzWkyjN
	 7/wVNtEDEvmFoXkwczoXyg6IWJws8gdmvizHTipzvl2jVUJ1WeQs8sdMCQ/8Pl9LX24FM
	 0FYQr8pwDbWG5dLTNSon9jJAXfOlICZHDYkG33kRhtA4nQPJnthCzWe94scAazfmVC+6w
	 LSZSysj/uH91G3Z+nwLTfmqEzLdEt/iGgnqv5K6gCx7XQF1JTrD2a0VDFOIF2H2vjgxxy
	 38Do+A2WXOQg1FGHpzLESzCWpQ26ezqNVTvHydrWr0S3hoaqsu8aNQFBktkhAvhhflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508158;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QOastqu2BmVRKtcvvU54Amw/e3Z/6O/qENM3+GMfnLg=;
	b=vRKmDxzeaSAG1IJZOwFA+5g9SwLbZXuOSKWxMV36iYBImA2GVvue4lJqmlu0m4rXeH67
	 H0iNkZ004IDj/HM1c4Dj/LqM7vJKPQUWQLHmtHQ933PtgIPgXmZ8kCn4HS1FO1hrOb7HF
	 6cTpgc58Uxg1XMw3QT8H+1u9bTmpBoYsbMIql3yCDA5+3AQr8lDM9pqp0qPEAx7IZZB8M
	 6DnvpMSJB1GcSLXS1DiMLURBAuj2bfPZ8HdRFNPx/1508W8vhceDcyZZdjrUmxg0cgBzP
	 HYkxvsynjai0wITu8kx/6yWbqOtx73uhOjfDTom1AVKRISeepSJbG01tMOfFtdlyWLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MPanbWEh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A9606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MPanbWEh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9310D1F000CF;
	Tue, 24 Nov 2026 08:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795508158;
	bh=QOastqu2BmVRKtcvvU54Amw/e3Z/6O/qENM3+GMfnLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MPanbWEhjhKWrBWM8KejFwZczSw9tpKb89YG5kM6dpbbrgGvQ0niOBOdSeprHoDu7
	 YdW6s3zUdyXC28vh3RSB8COq697Ybn3wpWHDhREZ9a+GBUOT3ZZv1fYK89NtKMkr0t
	 tlOZPTdoIEb26KYmxeOScbtzcqTD1PFkfayox6YaSnpXElAofo2e0Bqobf9ixaDYBn
	 bSU4wmRTVuvMLzkBJ8H++QGPOsIyJHlwvqpBhm8BqES5YYUiCIzdV7zVSscshGw/qW
	 AOLpN/BK5tuudEQnvXKyWyCSAiCQdnXra64CbBVpRpzbUBQkv0gSnGK/Tkq00sYLCe
	 XnE5DW6aChTSA==
Message-ID: <8162b3e0-bac7-41cc-bac5-11a947242d26@kernel.org>
Date: Tue, 24 Nov 2026 17:15:55 +0900
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: don't wait for all RCU callbacks when freeing
 zone write plugs
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20261124-feat-blk-zoned-rcu-barrier-v2-1-6d2212a48c5c@linux.dev>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261124-feat-blk-zoned-rcu-barrier-v2-1-6d2212a48c5c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 16:04, Qiliang Yuan wrote:
> Zone write plugs are allocated from a per-disk mempool and freed with
> call_rcu(). Before destroying the mempool, which happens every time a
> zoned disk is released, disk_destroy_zone_wplugs_hash_table() calls
> rcu_barrier() so that no zone write plug is still waiting to be returned
> to it.
> 
> rcu_barrier() waits for the RCU callbacks queued on every CPU by anyone,
> which usually takes a grace period or more, even when the disk had no
> zone write plug left to free. Removing many zoned disks, such as the SMR
> drives of a storage node taken offline, pays this once per disk.
> 
> Count the zone write plugs of the disk that wait for their RCU callback,
> and wait only for that count to drop to zero.
> 
> Removing 32 zoned null_blk or scsi_debug devices, base and patched
> kernels alternating over 2 rounds of 3 runs, median of the 6 runs and
> range in parentheses; "with plugs" leaves four partially written zones,
> and so four zone write plugs, on each null_blk device:
> 
>   devices                      before (ms)      after (ms)   change
>   null_blk                   820 (805-885)   438 (424-454)     -47%
>   null_blk, with plugs       876 (852-883)   844 (805-877)      -4%
>   scsi_debug, host-managed   958 (945-991)   642 (630-652)     -33%
> 
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> V1 -> V2:
> - Keep the original comment above the wait (Damien Le Moal)
> - Add Reviewed-by (Damien Le Moal)
> 
> v1: https://lore.kernel.org/r/20261121-feat-blk-zoned-rcu-barrier-v1-1-766875b525be@linux.dev
> ---
>  block/blk-zoned.c      | 10 ++++++++--
>  include/linux/blkdev.h |  1 +
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 4c58892961912..463c93db467b0 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -18,6 +18,7 @@
>  #include <linux/mempool.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> +#include <linux/wait_bit.h>
>  
>  #include <trace/events/block.h>
>  
> @@ -724,8 +725,11 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
>  {
>  	struct blk_zone_wplug *zwplug =
>  		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
> +	struct gendisk *disk = zwplug->disk;
>  
> -	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
> +	mempool_free(zwplug, disk->zone_wplugs_pool);
> +	if (atomic_dec_and_test(&disk->nr_zone_wplugs_freeing))
> +		wake_up_var(&disk->nr_zone_wplugs_freeing);
>  }
>  
>  static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
> @@ -745,6 +749,7 @@ static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
>  	atomic_dec(&disk->nr_zone_wplugs);
>  	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
>  
> +	atomic_inc(&disk->nr_zone_wplugs_freeing);
>  	call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
>  }
>  
> @@ -2149,7 +2154,8 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
>  	 * Wait for the zone write plugs to be RCU-freed before destroying the
>  	 * mempool.
>  	 */
> -	rcu_barrier();
> +	wait_var_event(&disk->nr_zone_wplugs_freeing,
> +		       !atomic_read_acquire(&disk->nr_zone_wplugs_freeing));
>  	mempool_destroy(disk->zone_wplugs_pool);
>  	disk->zone_wplugs_pool = NULL;
>  }
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 215753171cef0..b3b356f832267 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -204,6 +204,7 @@ struct gendisk {
>  	u8 __rcu		*zones_state;
>  	unsigned int		zone_wplugs_hash_bits;
>  	atomic_t		nr_zone_wplugs;
> +	atomic_t		nr_zone_wplugs_freeing;
>  	spinlock_t		zone_wplugs_hash_lock;
>  	struct mempool		*zone_wplugs_pool;
>  	struct hlist_head	*zone_wplugs_hash;
> 
> ---
> base-commit: 5f22fb20497f4983094131f00a734362300d22d2
> change-id: 20261120-feat-blk-zoned-rcu-barrier-cb9044e67ab3
> 
> Best regards,


-- 
Damien Le Moal
Western Digital Research
