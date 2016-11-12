Return-Path: <prvs=012435efd5=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC: <hch@infradead.org>
Subject: [PATCHSET v3] block: IO polling improvements
Date: Fri, 11 Nov 2016 22:11:24 -0700
Message-ID: <1478927487-12998-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Respun on top of for-4.10/block, dropping patches that have been
merged. This patchset adds Christoph's simplified sync O_DIRECT
bdev access mode, and implements a more efficient IO polling on
top of it. For more details, see the v2 posting here:

http://www.mail-archive.com/linux-block@vger.kernel.org/msg02079.html

Changes since v2:

- Adapt to blk stat changes
- Make it explicit that only blk-mq supports polling
- Fix a bug in the hrtimer code, switching to absolute mode if we
  have to loop around (thanks Omar).
