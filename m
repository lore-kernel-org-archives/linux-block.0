Subject: Re: [PATCH V2 1/5] block: add async variant of blkdev_issue_zeroout
To: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
References: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <5b985e6b-2904-9899-3b16-32747434b901@fb.com>
Date: Thu, 1 Dec 2016 07:59:37 -0700
MIME-Version: 1.0
In-Reply-To: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 11/30/2016 01:28 PM, Chaitanya Kulkarni wrote:
> Similar to __blkdev_issue_discard this variant allows submitting
> the final bio asynchronously and chaining multiple ranges
> into a single completion.

Applied this, and the other 4, for 4.10. Thanks.

-- 
Jens Axboe
