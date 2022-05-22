Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A8C433EF
	for <linux-block@archiver.kernel.org>; Sun, 22 May 2022 21:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiEVV1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 May 2022 17:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbiEVV00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 May 2022 17:26:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A413D14
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 14:26:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c14so12087400pfn.2
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=Jy6s8DEa5jSDvUdj8WBl45STs9nfFZM1IrmIzLolR84=;
        b=XpzVcCFMPMRPF6AKPrdsazhWF0OuQNGHKGAKsGhp1RoEWhpTOOCLy1N+FU3EXosb8C
         bf0Y/oefnYB0Wmcb13ng0oWHEwKB83UN6AjBLUl2LYlwOWL6vhGP1yNjh5WHOD3Zhavb
         8nNtiop9Peq0RjHeRDksRtw8D74TaFEl2wv003O159oPYS/UFyanDBI3Q52i5pjHoSQM
         +qGCglb1BTjPSr87O7nG6BVclSB0fTUy2fT2xzYDSelRAUaExTVMtDrCJkbqitEh785p
         pAxidYrhJ3a/ytZUQLor5nLcbw0GhlFUYizgA9lyXYDaBSEr15GVKONvAKauZoqrf42c
         FhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=Jy6s8DEa5jSDvUdj8WBl45STs9nfFZM1IrmIzLolR84=;
        b=lh4ZQppXlGE7ENZ/hCzGRrSqMklnFh2m7z4Jtz0jJVNnFJtSX2Ab4aSG9CK3cPiJI6
         RvBUYP4vdkZ1bt5dq8l/NkMWJyeso035pnJ9guL89b1bw+wfnkjeu4wvZbng6gRbkzJ5
         aRBwrkjg29n/6vDqCeoUpiMavJXVbZyAnppjQyi/bq9mB311Zp8MsqmG5RseU64cinnp
         oFhKuOgYpVn8fCQQ5BkqQxmuSSoB2CXIHGo8oT/JkLYK3IL51jYOSgcdloo8o24ujIy0
         xOV8yq/eRZx7GW0/ToIzoozN3Lc/w0o58GuWTGpVe/SFysnf4BH3WI6djUfi62T9nIt8
         2++Q==
X-Gm-Message-State: AOAM533/OKUfT50dImi2wN1to0M+QOjpG6dicaelrxnVrPvOwKQjpYoc
        u4NxXzcVDMszyo3zEVozFcq99Q==
X-Google-Smtp-Source: ABdhPJyhzDQhoqIrbgRSN/mIzZJF3J7wLyI50fM86fOei7NNuw/wBaY2mHUR4JFo1uTBnKhHnSi5hg==
X-Received: by 2002:a05:6a00:2442:b0:4fd:8b00:d2f with SMTP id d2-20020a056a00244200b004fd8b000d2fmr20545462pfj.39.1653254785023;
        Sun, 22 May 2022 14:26:25 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902cf4b00b0015e8d4eb22csm3525249plg.118.2022.05.22.14.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 14:26:24 -0700 (PDT)
Message-ID: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
Date:   Sun, 22 May 2022 15:26:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring passthrough support
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of everything else, this adds support for passthrough for
io_uring. The initial feature for this is NVMe passthrough support,
which allows non-filesystem based IO commands and admin commands. To
support this, io_uring grows support for SQE and CQE members that are
twice as big, allowing to pass in a full NVMe command without having to
copy data around. And to complete with more than just a single 32-bit
value as the output.

This will cause a merge conflict as well, with the provided buffer
change from the core branch, and adding CQE32 support for NOP in this
branch. Resolution:

diff --cc fs/io_uring.c
index 1015dd49e7e5,c5a476e6c068..395d3a921b53
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@@ -4997,17 -5169,11 +5256,23 @@@ static int io_nop_prep(struct io_kiocb 
   */
  static int io_nop(struct io_kiocb *req, unsigned int issue_flags)
  {
++	unsigned int cflags;
 +	void __user *buf;
 +
 +	if (req->flags & REQ_F_BUFFER_SELECT) {
 +		size_t len = 1;
 +
 +		buf = io_buffer_select(req, &len, issue_flags);
 +		if (!buf)
 +			return -ENOBUFS;
 +	}
 +
- 	__io_req_complete(req, issue_flags, 0, io_put_kbuf(req, issue_flags));
++	cflags = io_put_kbuf(req, issue_flags);
+ 	if (!(req->ctx->flags & IORING_SETUP_CQE32))
 -		__io_req_complete(req, issue_flags, 0, 0);
++		__io_req_complete(req, issue_flags, 0, cflags);
+ 	else
 -		__io_req_complete32(req, issue_flags, 0, 0, req->nop.extra1,
 -					req->nop.extra2);
++		__io_req_complete32(req, issue_flags, 0, cflags,
++					req->nop.extra1, req->nop.extra2);
  	return 0;
  }
  

Please pull!


The following changes since commit 7ccba24d3bc084d891def1a6fea504e4cb327a8c:

  io_uring: don't clear req->kbuf when buffer selection is done (2022-05-09 06:29:06 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.19/io_uring-passthrough-2022-05-22

for you to fetch changes up to 3fe07bcd800d6e5e4e4263ca2564d69095c157bf:

  io_uring: cleanup handling of the two task_work lists (2022-05-21 09:17:05 -0600)

----------------------------------------------------------------
for-5.19/io_uring-passthrough-2022-05-22

----------------------------------------------------------------
Anuj Gupta (1):
      nvme: add vectored-io support for uring-cmd

Christoph Hellwig (1):
      nvme: refactor nvme_submit_user_cmd()

Jens Axboe (6):
      Merge branch 'for-5.19/io_uring' into for-5.19/io_uring-passthrough
      Merge branch 'for-5.19/io_uring-socket' into for-5.19/io_uring-passthrough
      io_uring: add support for 128-byte SQEs
      fs,io_uring: add infrastructure for uring-cmd
      block: wire-up support for passthrough plugging
      io_uring: cleanup handling of the two task_work lists

Kanchan Joshi (3):
      nvme: wire-up uring-cmd support for io-passthru on char-device.
      nvme: helper for uring-passthrough checks
      nvme: enable uring-passthrough for admin commands

Ming Lei (1):
      blk-mq: fix passthrough plugging

Stefan Roesch (12):
      io_uring: support CQE32 in io_uring_cqe
      io_uring: store add. return values for CQE32
      io_uring: change ring size calculation for CQE32
      io_uring: add CQE32 setup processing
      io_uring: add CQE32 completion processing
      io_uring: modify io_get_cqe for CQE32
      io_uring: flush completions for CQE32
      io_uring: overflow processing for CQE32
      io_uring: add tracing for additional CQE32 fields
      io_uring: support CQE32 in /proc info
      io_uring: enable CQE32
      io_uring: support CQE32 for nop operation

 block/blk-mq.c                  | 109 ++++----
 drivers/nvme/host/core.c        |   2 +
 drivers/nvme/host/ioctl.c       | 278 +++++++++++++++++++-
 drivers/nvme/host/multipath.c   |   1 +
 drivers/nvme/host/nvme.h        |   5 +
 fs/io_uring.c                   | 444 ++++++++++++++++++++++++++------
 include/linux/fs.h              |   2 +
 include/linux/io_uring.h        |  33 +++
 include/trace/events/io_uring.h |  18 +-
 include/uapi/linux/io_uring.h   |  24 +-
 include/uapi/linux/nvme_ioctl.h |  28 ++
 11 files changed, 806 insertions(+), 138 deletions(-)

-- 
Jens Axboe

