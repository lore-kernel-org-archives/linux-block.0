Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1540508961.66186.82.camel@acm.org>
Subject: Re: [PATCHSET 0/28] blk-mq driver conversions and legacy path
 removal
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Date: Thu, 25 Oct 2018 16:09:21 -0700
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
+AD4 The first round of this went into 4.20-rc, but we've still some of
+AD4 them pending. This patch series converts the remaining drivers to
+AD4 blk-mq. The ones that support dual paths (like SCSI and DM) have
+AD4 the non-mq path removed. At the end, legacy IO code and schedulers
+AD4 are killed off.
+AD4 
+AD4 This patch series is on top of my for-linus branch. It can also
+AD4 be bound in my mq-conversions branch.

Hi Jens,

I cloned your mq-conversions branch and ran the block, srp and nvmeof-mp
test groups from the blktests project. The result of these tests on my
setup is the same as with kernel v4.19: except for a few false positive
lockdep complaints, all tests pass. The most recent commit that is
involved in the false positive lockdep complaints I encountered is
87915adc3f0a (+ACI-workqueue: re-add lockdep dependencies for flushing+ACI).
Patches are being discussed to address these false positives.

Bart.
