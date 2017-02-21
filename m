Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
 <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ef431f1c-e3c6-4940-bb2a-f5131ca96855@kernel.dk>
Date: Tue, 21 Feb 2017 16:15:53 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/21/2017 04:02 PM, Linus Torvalds wrote:
> Hmm. The new config options are incomprehensible and their help
> messages don't actually help.
> 
> So can you fill in the blanks on what
> 
>   Default single-queue blk-mq I/O scheduler
>   Default multi-queue blk-mq I/O scheduler
> 
> config options mean, and why they default to none?
> 
> The config phase of the kernel is one of the worst parts of the whole
> project, and adding these kinds of random and incomprehensible config
> options does *not* help.

I'll try and see if I can come up with some better sounding/reading
explanations.

But under a device managed by blk-mq, that device exposes a number of
hardware queues. For older style devices, that number is typically 1
(single queue). This is true for most SCSI devices that are run by
scsi-mq, which is often hosting rotational storage. Faster devices, like
nvme, exposes a lot more hardware queues (multi-queue). Hence the
distinction between having a scheduler attached for single-queue
devices, and for multi-queue devices. For rotational devices, we'll want
to default to something like mq-deadline, and I actually thought that
was the default already. It should be (see below). For multi-queue
devices, we'll want to initially default to "none", and then later
attach a properly multiqueue scheduler, when we have it (it's still in
development).

"none" just means that we don't have a scheduler attached.

In essence, we want to default to having a sane IO scheduler attached
depending on device class. For single-queue devices, that's deadline for
now. For multi-queue, we'll want to wait until we have something that
scales really well. It's not that easy to present this information in a
user grokkable fashion, since most people would not know the difference
between the two.

I'll send the below as a real patch, and also ponder how we can improve
the Kconfig text.

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 0715ce93daef..f6144c5d7c70 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -75,7 +75,7 @@ config MQ_IOSCHED_NONE
 
 choice
 	prompt "Default single-queue blk-mq I/O scheduler"
-	default DEFAULT_SQ_NONE
+	default DEFAULT_SQ_DEADLINE if MQ_IOSCHED_DEADLINE=y
 	help
 	  Select the I/O scheduler which will be used by default for blk-mq
 	  managed block devices with a single queue.

-- 
Jens Axboe
