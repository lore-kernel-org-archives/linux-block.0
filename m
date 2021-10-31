Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695F7C433F5
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5139860E0B
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhJaToq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhJaTop (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Oct 2021 15:44:45 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F11BC061714
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:42:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b203so3882127iof.1
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jj5YXm4gvBDLImTM9umWbZ/4moDJqxtX4hwJVoI/emc=;
        b=4T6o+w7wrpuG9V0c2cvw/Pjh6uWMdSuF/RX6UgWsVHnX1tscveYzR1gXdssSlIl/f6
         Pl40NtznkrixrMSuqCm1oB1qh+hIzMKFlrfG+m3XuoCxsSlxOjL/GVhpyUYwErsV8qot
         8ph3F26XfDWloRSVCUcQLVH0ghdVPEPs3TbyQGu49bhy+N5aVJQI1AQaRHyqKuI7ONc/
         XrggSuTssLkW1yWeieex2LAgaxMpwbFfH1Z40KYY5HWdrgPMWT3SwFX8LYXySBNNoDMO
         efg7JuB3kq+1PUVc9KbzrKEOl5MXMptHUa4NVdtZ5lGt78NWfK9Y0JUm9suV0+d3QC1X
         W2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jj5YXm4gvBDLImTM9umWbZ/4moDJqxtX4hwJVoI/emc=;
        b=gymNk9ybnIr9e5QPQ+exMphDXz7JH+htcMXplpgAm2XTA5oEixTy5pwG4KOxCO0W4R
         03K65xzuYPzznhmdpu68lCCb96IEaUUHblBhrma0QFDt8f0tA6TAZ8vyEMMZ2EG2BL0M
         E/mcLJoupDhSzMJ0G4UKX4oVaUzW/N4tsxoneQUJkjkaGVyrOAqqqGvA9dQa0mWoIQG6
         yv6qzotXMeDE1rLGtDGHW7Z3vEeLIppmfqsrlMPqMOJvH2Iy/CWyscWcRbsl/sIlfOrq
         KSx/XJEzhaVziUstMF5pcS2+ODOv/o/kyUXDqytfdemj0SdEL/U48YtYYdsIou1NqfqS
         /weg==
X-Gm-Message-State: AOAM530zMjoILeq3JFt/5z/+ddi0tOXvKx02mUsMNnPhtw5m9UsPufg0
        Vuf6VrIz7D4CRh3pjTSkubkxbw==
X-Google-Smtp-Source: ABdhPJzP673XSsEdfYgTpRv/d4IG5EQ2p5uMA25F5ci+VrlrKOT0drvsM3q5ny+UkBQfYu2opcXiWg==
X-Received: by 2002:a02:cc9a:: with SMTP id s26mr6366913jap.55.1635709331459;
        Sun, 31 Oct 2021 12:42:11 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n14sm1101953ilm.18.2021.10.31.12.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:42:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Remove ->ki_complete() res2 argument
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
Message-ID: <966b2cbc-8f25-edd9-29b7-f390a85bba61@kernel.dk>
Date:   Sun, 31 Oct 2021 13:42:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block branch, this pull request removes the res2
argument from kiocb->ki_complete(). Only the USB gadget code used it,
everybody else passes 0. The USB guys checked the user gadget code they
could find, and everybody just uses res as expected for the async
interface.

Note that this will throw one merge conflict in block/fops.c which is
trivial to resolve, but it will miss the other addition of a ki_complete
call in there. The '0' just needs to be removed there, I've included my
merge resolution below.

Please pull!


The following changes since commit e94f68527a35271131cdf9d3fb4eb3c2513dc3d0:

  block: kill extra rcu lock/unlock in queue enter (2021-10-21 08:37:26 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/ki_complete-2021-10-29

for you to fetch changes up to 6b19b766e8f077f29cdb47da5003469a85bbfb9c:

  fs: get rid of the res2 iocb->ki_complete argument (2021-10-25 10:36:24 -0600)

----------------------------------------------------------------
for-5.16/ki_complete-2021-10-29

----------------------------------------------------------------
Jens Axboe (2):
      usb: remove res2 argument from gadget code completions
      fs: get rid of the res2 iocb->ki_complete argument

 block/fops.c                       |  2 +-
 crypto/af_alg.c                    |  2 +-
 drivers/block/loop.c               |  4 ++--
 drivers/nvme/target/io-cmd-file.c  |  4 ++--
 drivers/target/target_core_file.c  |  4 ++--
 drivers/usb/gadget/function/f_fs.c |  2 +-
 drivers/usb/gadget/legacy/inode.c  |  7 ++-----
 fs/aio.c                           |  6 +++---
 fs/cachefiles/io.c                 | 12 ++++++------
 fs/ceph/file.c                     |  2 +-
 fs/cifs/file.c                     |  4 ++--
 fs/direct-io.c                     |  2 +-
 fs/fuse/file.c                     |  2 +-
 fs/io_uring.c                      |  6 +++---
 fs/iomap/direct-io.c               |  2 +-
 fs/nfs/direct.c                    |  2 +-
 fs/overlayfs/file.c                |  4 ++--
 include/linux/fs.h                 |  2 +-
 18 files changed, 33 insertions(+), 36 deletions(-)


diff --cc block/fops.c
index 3777c7b76eae,d86ebda73e8c..450bcbc0e90c
--- a/block/fops.c
+++ b/block/fops.c
@@@ -282,94 -305,6 +283,94 @@@ static ssize_t __blkdev_direct_IO(struc
  	return ret;
  }
  
 +static void blkdev_bio_end_io_async(struct bio *bio)
 +{
 +	struct blkdev_dio *dio = container_of(bio, struct blkdev_dio, bio);
 +	struct kiocb *iocb = dio->iocb;
 +	ssize_t ret;
 +
 +	if (likely(!bio->bi_status)) {
 +		ret = dio->size;
 +		iocb->ki_pos += ret;
 +	} else {
 +		ret = blk_status_to_errno(bio->bi_status);
 +	}
 +
- 	iocb->ki_complete(iocb, ret, 0);
++	iocb->ki_complete(iocb, ret);
 +
 +	if (dio->flags & DIO_SHOULD_DIRTY) {
 +		bio_check_pages_dirty(bio);
 +	} else {
 +		bio_release_pages(bio, false);
 +		bio_put(bio);
 +	}
 +}
 +
 +static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 +					struct iov_iter *iter,
 +					unsigned int nr_pages)
 +{
 +	struct block_device *bdev = iocb->ki_filp->private_data;
 +	struct blkdev_dio *dio;
 +	struct bio *bio;
 +	loff_t pos = iocb->ki_pos;
 +	int ret = 0;
 +
 +	if ((pos | iov_iter_alignment(iter)) &
 +	    (bdev_logical_block_size(bdev) - 1))
 +		return -EINVAL;
 +
 +	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
 +	dio = container_of(bio, struct blkdev_dio, bio);
 +	dio->flags = 0;
 +	dio->iocb = iocb;
 +	bio_set_dev(bio, bdev);
 +	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 +	bio->bi_write_hint = iocb->ki_hint;
 +	bio->bi_end_io = blkdev_bio_end_io_async;
 +	bio->bi_ioprio = iocb->ki_ioprio;
 +
 +	if (iov_iter_is_bvec(iter)) {
 +		/*
 +		 * Users don't rely on the iterator being in any particular
 +		 * state for async I/O returning -EIOCBQUEUED, hence we can
 +		 * avoid expensive iov_iter_advance(). Bypass
 +		 * bio_iov_iter_get_pages() and set the bvec directly.
 +		 */
 +		bio_iov_bvec_set(bio, iter);
 +	} else {
 +		ret = bio_iov_iter_get_pages(bio, iter);
 +		if (unlikely(ret)) {
 +			bio->bi_status = BLK_STS_IOERR;
 +			bio_endio(bio);
 +			return ret;
 +		}
 +	}
 +	dio->size = bio->bi_iter.bi_size;
 +
 +	if (iov_iter_rw(iter) == READ) {
 +		bio->bi_opf = REQ_OP_READ;
 +		if (iter_is_iovec(iter)) {
 +			dio->flags |= DIO_SHOULD_DIRTY;
 +			bio_set_pages_dirty(bio);
 +		}
 +	} else {
 +		bio->bi_opf = dio_bio_write_op(iocb);
 +		task_io_account_write(bio->bi_iter.bi_size);
 +	}
 +
 +	if (iocb->ki_flags & IOCB_HIPRI) {
 +		bio->bi_opf |= REQ_POLLED | REQ_NOWAIT;
 +		submit_bio(bio);
 +		WRITE_ONCE(iocb->private, bio);
 +	} else {
 +		if (iocb->ki_flags & IOCB_NOWAIT)
 +			bio->bi_opf |= REQ_NOWAIT;
 +		submit_bio(bio);
 +	}
 +	return -EIOCBQUEUED;
 +}
 +
  static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
  {
  	unsigned int nr_pages;

-- 
Jens Axboe

