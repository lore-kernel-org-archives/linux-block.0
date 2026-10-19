Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063E13D8BD;
	Mon, 19 Oct 2026 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373829; cv=none; b=Hq4yRCj/QsbR1Hnk+W+/2ukHCSF3aA7X6rQjwWNlO7ZQ6kNteqBzB7jv3SbD4Hf+Y1gbCxjK/x9ys5AAAGrAxsCqWp6CO35wr2GVnC8ih7eeJQ5YNM/bPBSEUJU+Elwv0mZcxXIOp7iy0QrrFW/rt8M0JPRSVwCaW17nr/LLemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373829; c=relaxed/simple;
	bh=szHP56FjldtD2Uxu4ijUioje532o4OKEHWIlQnqjj0Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JMEh2wwA83yEYme3s/nXdqtDoOengj/JJGI8/h4tUEowch2Jd4GwS9wB9cHHn9TCjYgxsvmrA+bQnJOJDefgI1hUSYNIxeYes24SfUMJ3J6MO+5wA4d/SdzEIYIMKtcHJ0Gc0N65cTEIVMMs6i42gTnEp5n8M9MzabPbFa8Wj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qpI4sZ58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qpI4sZ58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC371F000C4;
	Mon, 19 Oct 2026 01:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792373827;
	bh=Wuq5JSaJ2iBCmQVUdFVG10GyTUf/WKdjmQmYRhFmoAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=qpI4sZ58Sc+uFSzMeZSX5IXOxgqylXHLPUe31Fd5t6Ti9pTu+V6hhhQ4pATq/UbF6
	 scC3UloOpvxsLwZlZJilf5BGNw6MsKIgl095PR8Rw7z8Qlo/k7e0IbDwAzNSykEnWj
	 9MAEvMJqehU18J6SR4KWT4A/469vJRMCsI3xk6Yo=
Date: Sun, 18 Oct 2026 18:37:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: l1za0.sec@gmail.com
Cc: viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>, Tal Zussman <tz2294@columbia.edu>, Daehyeon Ko
 <4ncienth@gmail.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>
Subject: Re: [BUG] KASAN: slab-out-of-bounds Read in
 copy_folio_from_iter_atomic
Message-Id: <20261018183707.23dba84df0a235e36de1620d@linux-foundation.org>
In-Reply-To: <20261018081203.2431035-1-l1za0.sec@gmail.com>
References: <20261018081203.2431035-1-l1za0.sec@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 16:12:03 +0800 l1za0.sec@gmail.com wrote:

> From: Haocheng Yu <l1za0.sec@gmail.com>
> 
> Hi,
> 
> We found a KASAN slab-out-of-bounds read in copy_folio_from_iter_atomic() while 
> fuzzing Linux with a modified version of syzkaller. We couldn't find a report 
> of the same issue on syzbot. We are investigating the root cause and trying to 
> develop a fix. Could you let us know whether this issue warrants a fix?
> 
> The crash occurs on Linux v7.3.0-rc5. KASAN reports an 8-byte read 8 bytes past 
> a 144-byte allocation in kmalloc-192.
> 
> Relevant stack trace:
> 
>   iterate_iovec (include/linux/iov_iter.h:49)
>   __copy_from_iter (lib/iov_iter.c:261)
>   copy_folio_from_iter_atomic (lib/iov_iter.c:491)
>   generic_perform_write (mm/filemap.c:4392)
>   ext4_buffered_write_iter (fs/ext4/file.c:354)
>   ext4_file_write_iter (fs/ext4/file.c:794)
>   vfs_writev (fs/read_write.c:1058)
>   do_writev (fs/read_write.c:1104)
> 
> The reproducer mounts an ext4 image, opens a file, performs write operations, 
> and triggers the crash through writev() with a crafted iovec array.

tl;dr: bug in bio_iov_iter_get_pages().


Thanks.  Boy I burned a lot of tokens on this.

I was able to reproduce this.  I found that Daehyeon's "iov_iter:
validate extracted segment for bvec alignment" makes the KASAN warnings
go away.  https://lore.kernel.org/20261015061907.2713943-1-4ncienth@gmail.com

Daehyeon's patch is presently in mm.git's mm-unstable branch, with
cc:stable, targeted for upstreaming during the second week of the merge
window.

Daehyeon's patch prevents this reproducer from triggering the bug by
rejecting the misaligned direct-I/O request before extraction advances
the iterator.  Without that check, extraction skips the initial empty
iovec and the following 10-byte segment, then encounters an alignment
error.  The bio is discarded, but the iterator remains advanced.  iomap
subsequently restores its byte count without restoring its position,
leaving 1025 bytes recorded when only 1015 remain.  Buffered-I/O
fallback then walks beyond the imported iovec array.  So Daehyeon's
patch avoids the bad path, but doesn't address the underlying failure
to restore the iterator when rejecting a bio.

Tal Zussman's atomic-write fixes also change the rejected-bio handling
in bio_iov_iter_get_pages().  In particular, his partial-pin fix
rejects an atomic bio rather than allowing a short atomic write to be
submitted.  That introduces another cleanup path on which the iterator
may already have advanced.  The rollback should therefore cover that
path as well, preferably through the common cleanup label in Tal's
version.  The two fixes address different problems and are
complementary, but their error handling needs to be reconciled when
both are merged.


Proposed fix:


From: Andrew Morton <akpm@linux-foundation.org>
Subject: block: restore the iterator when rejecting a misaligned bio
Date: Sun, 18 Oct 2026 17:30:00 -0700

bio_iov_iter_get_pages() can extract some iovecs before encountering a
misaligned one.  It releases the pages and rejects the entire bio, but
leaves the supplied iterator advanced.

An iomap direct-I/O caller may subsequently reexpand the iterator's
byte count and fall back to buffered I/O.  The reexpanded count then
includes bytes before the iterator's current segment, potentially
causing iterate_iovec() to read beyond the imported iovec array.

In a reproducer using an initial empty iovec followed by 10-byte and
1015-byte segments, writev() returned 1015 instead of 1025 and KASAN
reported an 8-byte read beyond the nine-element iovec allocation.
Saving and restoring the iterator on the rejected-bio path makes
writev() return 1025 and eliminates the KASAN report.

Restore the entire iterator rather than reverting a byte count:
advancing past an empty segment changes its position without consuming
any bytes.

Leave successful and partially accepted bio paths unchanged.

Fixes: 14b007e17881 ("block: validate user space vectors during extraction")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Haocheng Yu <l1za0.sec@gmail.com>
Closes: https://lore.kernel.org/20261018081203.2431035-1-l1za0.sec@gmail.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tal Zussman <tz2294@columbia.edu>
Cc: Daehyeon Ko <4ncienth@gmail.com>
Cc: <stable@vger.kernel.org>
---
Testing on x86-64 QEMU/KVM with generic KASAN:
- Before: the ext4 writev() reproducer returned 1015 instead of 1025
  and triggered an 8-byte slab out-of-bounds read.
- After: 100 consecutive reproducer runs returned 1025 without KASAN;
  60-second buffered and direct ext4 fio runs passed.
- Daehyeon's alignment patch independently avoids the reproducer.

Tal Zussman's pending atomic-write changes introduce another rejected-bio
cleanup path. If both patches are combined, restore the iterator there too.


---

 block/bio.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/block/bio.c~bio-iov-iter-rollback
+++ a/block/bio.c
@@ -1285,6 +1285,7 @@ int bio_iov_iter_get_pages(struct bio *b
 			   unsigned mem_align_mask, unsigned len_align_mask)
 {
 	iov_iter_extraction_t flags = 0;
+	struct iov_iter saved_iter;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1303,6 +1304,7 @@ int bio_iov_iter_get_pages(struct bio *b
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		flags |= ITER_ALLOW_P2PDMA;
 
+	saved_iter = *iter;
 	do {
 		ssize_t ret;
 
@@ -1320,6 +1322,7 @@ int bio_iov_iter_get_pages(struct bio *b
 				bio_release_pages(bio, false);
 				bio_clear_flag(bio, BIO_PAGE_PINNED);
 				bio->bi_vcnt = 0;
+				*iter = saved_iter;
 			}
 			if (!bio->bi_vcnt)
 				return ret;
_

