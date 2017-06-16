Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 02/12] blk-mq: expose stream write stats through debugfs
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
	<1497544930-19174-3-git-send-email-axboe@kernel.dk>
Date: Fri, 16 Jun 2017 12:38:55 -0400
In-Reply-To: <1497544930-19174-3-git-send-email-axboe@kernel.dk> (Jens Axboe's
	message of "Thu, 15 Jun 2017 10:42:00 -0600")
Message-ID: <yq1mv97q44g.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> Useful to verify that things are working the way they should.
> Reading the file will return number of kb written to each
> stream. Writing the file will reset the statistics. No care
> is taken to ensure that we don't race on updates.
>
> Drivers will write to q->stream_writes[] if they handle a stream.

s/stream/write_lifetime_bucket/ or something like that.

-- 
Martin K. Petersen	Oracle Linux Engineering
