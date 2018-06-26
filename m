Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix blk_mq_end_request() and blk_end_request() for WRITE SAME
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180626001009.16557-1-bart.vanassche@wdc.com>
Date: Tue, 26 Jun 2018 11:53:05 -0400
In-Reply-To: <20180626001009.16557-1-bart.vanassche@wdc.com> (Bart Van
	Assche's message of "Mon, 25 Jun 2018 17:10:06 -0700")
Message-ID: <yq1a7rh5yu6.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Hi Bart,

> This series of three patches fixes a crash in the block layer core
> that I encountered while retesting the SRP tests in blktests. Please
> consider these patches for kernel v4.19.

Patches 1 and 2 look fine. However, I'm not sure I'm so keen on patch
3. It looks like it's papering over a more fundamental issue.

Can you elaborate a bit on why the existing code fails with dm in the
mix?

-- 
Martin K. Petersen	Oracle Linux Engineering
