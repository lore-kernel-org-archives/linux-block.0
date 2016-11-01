Return-Path: <prvs=011358c635=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <hch@lst.de>
Subject: [PATCHSET] Throttled buffered writeback
Date: Tue, 1 Nov 2016 15:08:43 -0600
Message-ID: <1478034531-28559-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

I have addressed the (small) review comments from Christoph, and
rebased it on top of for-4.10/block, since that now has the
flag unification and fs side cleanups as well. This impacted the
prep patches, and the wbt code.

I'd really like to get this merged for 4.10. It's block specific
at this point, and defaults to just being enabled for blk-mq
managed devices.

Let me know if there are any objections.
