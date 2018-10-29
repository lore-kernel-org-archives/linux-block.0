Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V5] block: fix the DISCARD request merge
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <610adbc6-24ba-e6ed-a98a-f3faeef8bd51@kernel.dk>
Date: Mon, 29 Oct 2018 09:33:19 -0600
MIME-Version: 1.0
In-Reply-To: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/27/18 5:52 AM, Jianchao Wang wrote:
> There are two cases when handle DISCARD merge.
> If max_discard_segments == 1, the bios/requests need to be contiguous
> to merge. If max_discard_segments > 1, it takes every bio as a range
> and different range needn't to be contiguous.
> 
> But now, attempt_merge screws this up. It always consider contiguity
> for DISCARD for the case max_discard_segments > 1 and cannot merge
> contiguous DISCARD for the case max_discard_segments == 1, because
> rq_attempt_discard_merge always returns false in this case.
> This patch fixes both of the two cases above.

Applied, thanks.

-- 
Jens Axboe
