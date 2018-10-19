Return-Path: <martin.petersen@oracle.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: don't check position contiguity for DISCARD in attempt_merge
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
Date: Fri, 19 Oct 2018 11:57:18 -0400
In-Reply-To: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
	(Jianchao Wang's message of "Fri, 19 Oct 2018 17:24:53 +0800")
Message-ID: <yq15zxyj5ep.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jianchao,

> Discard command supports multiple ranges of blocks, so needn't
> checking position contiguity when merging. Let's do the same thing
> in attempt_merge as the blk_try_merge.

Discards need to be contiguous unless queue->limits.max_discard_segments
is bigger than 1. So if you remove this I think you need to add a
contiguity check in req_attempt_discard_merge().

-- 
Martin K. Petersen	Oracle Linux Engineering
