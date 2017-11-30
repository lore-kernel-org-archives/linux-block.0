Return-Path: <martin.petersen@oracle.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] nbd: set discard granularity properly
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1511990024-2742-1-git-send-email-josef@toxicpanda.com>
Date: Thu, 30 Nov 2017 10:58:54 -0500
In-Reply-To: <1511990024-2742-1-git-send-email-josef@toxicpanda.com> (Josef
	Bacik's message of "Wed, 29 Nov 2017 16:13:44 -0500")
Message-ID: <yq1h8tbg3lt.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Josef,

> For some reason we had discard granularity set to 512 always even when
> discards were disabled.  Fix this by having the default be 0, and then
> if we turn it on set the discard granularity to the blocksize.

Originally, discard_max_bytes was the queue limit used to indicate
whether discards were supported or not. Callers were supposed to check
that for a value bigger than 0 before interpreting granularity and
alignment. However, many callers triggered on discard_granularity > 0
instead, and as a result things have been muddled somewhat.

So I don't have a problem with only reporting granularity when the
feature is actually enabled...

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
