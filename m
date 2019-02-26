Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3487C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 03:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E43C20842
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 03:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551152880;
	bh=A4/eVFasMyGYxeSjA0iWkl1nBT7mtanSUlP5mKbDM8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qU3bGlgbjNmGK9+0wrkKU6wREmArQN+BjdRQJq+aXo3WzjC0MjyBh81ghtPoex8VP
	 vbZtmShrJeCOn3MvmtCfFT/sj2O4R4yHiXjY8U2bK/dFkXfMioJ81MwjXMlF0faKig
	 zQzud5mpG2SGaQUD6A+SASsAPqWuJV9K9Clf2B1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfBZDqR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfBZDqR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Feb 2019 22:46:17 -0500
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A612120842;
        Tue, 26 Feb 2019 03:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551152776;
        bh=A4/eVFasMyGYxeSjA0iWkl1nBT7mtanSUlP5mKbDM8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMZrg9XRNTaD/UnQTni3YJoQNIiYo/eqzMyqS7NgQ6bvI/2RVKRjhuHNXWXRtdw2K
         0DmHVSH1a3gcO4/X2EVkrHVTyqRd6jn4pAiaWnSoEE7MDLNaDMf9FqvEqB7j0b3gYp
         u3ZEH030nl76+ysVib4V5izWoeKyHM2WRZdnBbB0=
Date:   Mon, 25 Feb 2019 19:46:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 11/19] block: implement bio helper to add iter bvec pages
 to bio
Message-ID: <20190226034613.GA676@sol.localdomain>
References: <20190211190049.7888-1-axboe@kernel.dk>
 <20190211190049.7888-13-axboe@kernel.dk>
 <20190220225856.GB28313@ming.t460p>
 <b143e8c3-33d5-5f09-c441-98b3bf326d81@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b143e8c3-33d5-5f09-c441-98b3bf326d81@kernel.dk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On Thu, Feb 21, 2019 at 10:45:27AM -0700, Jens Axboe wrote:
> On 2/20/19 3:58 PM, Ming Lei wrote:
> > On Mon, Feb 11, 2019 at 12:00:41PM -0700, Jens Axboe wrote:
> >> For an ITER_BVEC, we can just iterate the iov and add the pages
> >> to the bio directly. This requires that the caller doesn't releases
> >> the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.
> >>
> >> The current two callers of bio_iov_iter_get_pages() are updated to
> >> check if they need to release pages on completion. This makes them
> >> work with bvecs that contain kernel mapped pages already.
> >>
> >> Reviewed-by: Hannes Reinecke <hare@suse.com>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>  block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
> >>  fs/block_dev.c            |  5 ++--
> >>  fs/iomap.c                |  5 ++--
> >>  include/linux/blk_types.h |  1 +
> >>  4 files changed, 56 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/block/bio.c b/block/bio.c
> >> index 4db1008309ed..330df572cfb8 100644
> >> --- a/block/bio.c
> >> +++ b/block/bio.c
> >> @@ -828,6 +828,23 @@ int bio_add_page(struct bio *bio, struct page *page,
> >>  }
> >>  EXPORT_SYMBOL(bio_add_page);
> >>  
> >> +static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
> >> +{
> >> +	const struct bio_vec *bv = iter->bvec;
> >> +	unsigned int len;
> >> +	size_t size;
> >> +
> >> +	len = min_t(size_t, bv->bv_len, iter->count);
> >> +	size = bio_add_page(bio, bv->bv_page, len,
> >> +				bv->bv_offset + iter->iov_offset);
> > 
> > iter->iov_offset needs to be subtracted from 'len', looks
> > the following delta change[1] is required, otherwise memory corruption
> > can be observed when running xfstests over loop/dio.
> 
> Thanks, I folded this in.
> 
> -- 
> Jens Axboe
> 

syzkaller started hitting a crash on linux-next starting with this commit, and
it still occurs even with your latest version that has Ming's fix folded in.
Specifically, commit a566653ab5ab80a from your io_uring branch with commit date
Sun Feb 24 08:20:53 2019 -0700.

Reproducer:

#define _GNU_SOURCE
#include <fcntl.h>
#include <linux/loop.h>
#include <sys/ioctl.h>
#include <sys/sendfile.h>
#include <sys/syscall.h>
#include <unistd.h>

int main(void)
{
        int memfd, loopfd;

        memfd = syscall(__NR_memfd_create, "foo", 0);

        pwrite(memfd, "\xa8", 1, 4096);

        loopfd = open("/dev/loop0", O_RDWR|O_DIRECT);

        ioctl(loopfd, LOOP_SET_FD, memfd);

        sendfile(loopfd, loopfd, NULL, 1000000);
}


Crash:

page:ffffea0001a6aab8 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x100000000000000()
raw: 0100000000000000 ffffea0001ad2c50 ffff88807fca49d0 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:546!
invalid opcode: 0000 [#1] SMP
CPU: 1 PID: 173 Comm: syz_mm Not tainted 5.0.0-rc6-00007-ga566653ab5ab8 #22
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-20181126_142135-anatol 04/01/2014
RIP: 0010:put_page_testzero include/linux/mm.h:546 [inline]
RIP: 0010:put_page include/linux/mm.h:992 [inline]
RIP: 0010:generic_pipe_buf_release+0x37/0x40 fs/pipe.c:225
Code: 50 ff a8 01 48 0f 45 fa 8b 47 34 85 c0 74 0f f0 ff 4f 34 74 02 5d c3 e8 c7 1b fa ff 5d c3 48 c7 c6 60 aa b1 81 e8 59 25 fc ff <0f> 0b 0f 1f 80 00 00 00 00 55 48 89 e5 41 56 41 55 41 54 53 e8 a0
RSP: 0018:ffffc90000783cb0 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffff88807c358800 RCX: 0000000000000006
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88807fc95420
RBP: ffffc90000783cb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000000000001000 R14: 0000000000000000 R15: ffff88807c0b6e00
FS:  00007fd858adb240(0000) GS:ffff88807fc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dc13859000 CR3: 000000007a96b000 CR4: 00000000003406e0
Call Trace:
 pipe_buf_release include/linux/pipe_fs_i.h:136 [inline]
 iter_file_splice_write+0x2df/0x3f0 fs/splice.c:763
 do_splice_from fs/splice.c:851 [inline]
 direct_splice_actor+0x31/0x40 fs/splice.c:1023
 splice_direct_to_actor+0xff/0x240 fs/splice.c:978
 do_splice_direct+0x92/0xc0 fs/splice.c:1066
 do_sendfile+0x1be/0x390 fs/read_write.c:1436
 __do_sys_sendfile64 fs/read_write.c:1497 [inline]
 __se_sys_sendfile64+0xa6/0xc0 fs/read_write.c:1483
 __x64_sys_sendfile64+0x19/0x20 fs/read_write.c:1483
 do_syscall_64+0x4a/0x180 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fd858bd224e
Code: 89 ce 5b e9 b4 fd ff ff 0f 1f 40 00 31 c0 5b c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 49 89 ca b8 28 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e2 cb 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fffc517d148 EFLAGS: 00000206 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fd858bd224e
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 0000000000000003 R08: 00007fd858ca0be0 R09: 00007fffc517d240
R10: 00000000000f4240 R11: 0000000000000206 R12: 000055dc13858100
R13: 00007fffc517d240 R14: 0000000000000000 R15: 0000000000000000
---[ end trace 1d878656972e4a26 ]---
RIP: 0010:put_page_testzero include/linux/mm.h:546 [inline]
RIP: 0010:put_page include/linux/mm.h:992 [inline]
RIP: 0010:generic_pipe_buf_release+0x37/0x40 fs/pipe.c:225
Code: 50 ff a8 01 48 0f 45 fa 8b 47 34 85 c0 74 0f f0 ff 4f 34 74 02 5d c3 e8 c7 1b fa ff 5d c3 48 c7 c6 60 aa b1 81 e8 59 25 fc ff <0f> 0b 0f 1f 80 00 00 00 00 55 48 89 e5 41 56 41 55 41 54 53 e8 a0
RSP: 0018:ffffc90000783cb0 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffff88807c358800 RCX: 0000000000000006
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88807fc95420
RBP: ffffc90000783cb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000000000001000 R14: 0000000000000000 R15: ffff88807c0b6e00
FS:  00007fd858adb240(0000) GS:ffff88807fc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dc13859000 CR3: 000000007a96b000 CR4: 00000000003406e0

- Eric
