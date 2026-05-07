Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860B322A1C;
	Thu,  7 May 2026 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179961; cv=none; b=a18iU0dZhnBIbGmMnss85zWjzGr2tj04kEg10y8gYG3b/8r5dW99pkVGXD5btF/9kARcEi2sruSHsDuUlqMAMKN5P2PKrI3vsSen+9GP0VOXp58uKqxpZsf7wJ53a+qN3WXKVC6ueC3Z8MHbzLPduLnzTkz8D/b9sEFwb2E/vAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179961; c=relaxed/simple;
	bh=Tc81Q9XjgNE9US3pjCS/tJcvAK7mSmtWxOxL8FNhZjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSRw8/ob5GDLSNuEO9obCR6Ff+sm1XHYkqGdFknlfxQaXgyAjMzOo2eAvvoXWnBcikAJCaspBJJ00XUIL3oVFmdpwLpQ16T4ZcepJySt6TzhWWANQ5jy8kH1+C7iMIthSd8dM172tvCFLyK1X+6DZx+w0ahX/XYaEMMchoxkE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ne8XbMgX; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ne8XbMgX"
Received: from localhost (unknown [95.24.24.108])
	by mail.ispras.ru (Postfix) with ESMTPSA id 71F8545A1D2A;
	Thu,  7 May 2026 18:52:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 71F8545A1D2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1778179956;
	bh=/bbQJdxpQMdNVIxD/3Bnt+r15GlacM3WgigLD9oFQI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ne8XbMgXZte7hgfYIO++r+3UUHOZM/4SWChoETEkhQaVSut0Vv/CWqxFIaAvHMCEW
	 cdWmfeoWhrEuRCLk7DzE44UQOw1VxPzzWwx30xGatDAZSatH+d0gNvYKg68hwz5dso
	 ZQ0B0aCw8bkjqmjAmzFpWUrOzU0q9PatP3XV2MiA=
Date: Thu, 7 May 2026 21:52:36 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.12] block: fix memory leak in in bio_map_user_iov()
Message-ID: <20260507212200-2614841ccc112a082cab6938-pchelkin@ispras>
References: <20260505094529.406783-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505094529.406783-1-dmantipov@yandex.ru>

Hi,

On Tue, 05. May 12:45, Dmitry Antipov wrote:
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

Presumably root of the problem is located inside
iov_iter_extract_user_pages().  I suppose the leak you're hitting is
because pin_user_pages_fast() there fails, right?

In some form the issue is present in current upstream as well.  For
example, there is another callsite of iov_iter_extract_pages() in
block/bio-integrity.c where the same pattern still persists.  This implies
we'd better fix the callee and make it clean up any memory it may have
already allocated in case it fails. [ there's about a dozen of
iov_iter_extract_pages() callsites in mainline, they should be checked
of course when adding constraints to the function contract ]

That change could then be ported to the relevant stable kernels as well
without big conflicts.

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

If agreed on the need for iov_iter_extract_user_pages() adjustment, then
it could be 7d58fe731028 ("iov_iter: Add a function to extract a page list
from an iterator").

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
