Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C140DFA7;
	Tue,  5 May 2026 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975025; cv=none; b=Q50quF/sOruMiCrBRMk3MNLGoxccLTqr9tR4EB0YBdt5TC9rHtS1KK+DjDIrlSnkZ/TTGkc3gK6LBnrldJoAFybKd3SFMiOMD2HGMVihdwq2LyuK1S2PD2SMX1OVdAEwr1uLGzCte2+jtizb+eVV+wdAc1NCSZa2xzY7jSwpVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975025; c=relaxed/simple;
	bh=XeyT3VU+VHVGz8Q9A/bDrZidm3ayTO/eXhuKW9a4wVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rp4rDSR+REjBdrTgFuCjxYX5hf+swSf9fwkwUJd8Bw/jNcu14Gg5KozmL2DKQF8VDHDiglwiT0DCxpg3qECe3k7zfTw3hSUb6ftmv7lNFHuji2Onnbhyenl/HbsjsyxsEyGXnhs3RYCR6OayiajbvN+hWCSzMEmXib20BeCqwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EJ60BEox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EJ60BEox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9F4C2BCB4;
	Tue,  5 May 2026 09:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777975024;
	bh=XeyT3VU+VHVGz8Q9A/bDrZidm3ayTO/eXhuKW9a4wVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJ60BEoxi7LY1sqZ6UdaoupMxy5JucBb1uIdEx05oQWOrHgsgMV35RlAcjI2CDEgG
	 ExBE5oxTinf51E6WJVn3ZpZB2YSiThQj6hQPs/Pz02gOtGOz6Ew6mSN8c9akTL+mKh
	 FB7SG2LuAjYgIzZ6RmxgpDXEaoPT7yrA57mihxPg=
Date: Tue, 5 May 2026 11:57:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.12] block: fix memory leak in in bio_map_user_iov()
Message-ID: <2026050551-rice-cider-db2e@gregkh>
References: <20260505094529.406783-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505094529.406783-1-dmantipov@yandex.ru>

On Tue, May 05, 2026 at 12:45:29PM +0300, Dmitry Antipov wrote:
> Local fuzzing has observed the following issue with 6.12.82 (and
> then reproduced with 6.12.85 as well):
> 
> BUG: memory leak
> unreferenced object 0xffff88810c568000 (size 2048):
>   comm "syz.2.17", pid 1369, jiffies 4294894662
>   hex dump (first 32 bytes):
>     a8 62 6f 15 80 88 ff ff 00 00 00 00 00 00 00 00  .bo.............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 43ffe8f):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
>     slab_post_alloc_hook mm/slub.c:4152 [inline]
>     slab_alloc_node mm/slub.c:4197 [inline]
>     __do_kmalloc_node mm/slub.c:4331 [inline]
>     __kmalloc_node_noprof+0x428/0x510 mm/slub.c:4338
>     __kvmalloc_node_noprof+0xb5/0x240 mm/util.c:658
>     kvmalloc_array_node_noprof include/linux/slab.h:1040 [inline]
>     want_pages_array lib/iov_iter.c:992 [inline]
>     iov_iter_extract_user_pages lib/iov_iter.c:1818 [inline]
>     iov_iter_extract_pages+0x51b/0x14d0 lib/iov_iter.c:1884
>     bio_map_user_iov+0x325/0xa50 block/blk-map.c:304
>     blk_rq_map_user_iov+0x248/0x790 block/blk-map.c:646
>     blk_rq_map_user+0x123/0x190 block/blk-map.c:673
>     scsi_bsg_sg_io_fn+0x8d4/0xb00 drivers/scsi/scsi_bsg.c:53
>     bsg_sg_io+0x1b7/0x2b0 block/bsg.c:67
>     bsg_ioctl+0x3a4/0x5b0 block/bsg.c:151
>     vfs_ioctl fs/ioctl.c:51 [inline]
>     __do_sys_ioctl fs/ioctl.c:907 [inline]
>     __se_sys_ioctl fs/ioctl.c:893 [inline]
>     __x64_sys_ioctl+0x194/0x220 fs/ioctl.c:893
>     do_syscall_x64 arch/x86/entry/common.c:47 [inline]
>     do_syscall_64+0x90/0x170 arch/x86/entry/common.c:78
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Since 'iov_iter_extract_user_pages()' may reallocate (that is,
> replace an initial stack-allocated array with the one allocated via
> 'kvmalloc_array()'), this array must be freed, if actually replaced,
> when handling error returned from 'iov_iter_extract_pages()'.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> (not sure about Fixes: due to a lot of renames and moves in this area)
> ---
>  block/blk-map.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index b5fd1d857461..8523646054f0 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -305,6 +305,8 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  					       nr_vecs, extraction_flags, &offs);
>  		if (unlikely(bytes <= 0)) {
>  			ret = bytes ? bytes : -EFAULT;
> +			if (pages != stack_pages)
> +				kvfree(pages);
>  			goto out_unmap;
>  		}
>  
> -- 
> 2.54.0
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
