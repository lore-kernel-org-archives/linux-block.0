Return-Path: <BATV+a531e2bbbc8af89517f3+5043+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 14 Jun 2017 13:37:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 01/11] block: add support for carrying stream information
 in a bio
Message-ID: <20170614203759.GA14953@infradead.org>
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-2-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497467134-6323-2-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Btw, I think these could also easily map to DSM field in the NVMe
write command, except that these unfortunately mix in read information
as well.

> +	__REQ_WRITE_SHORT,	/* short life time write */

-> Frequent writes and infrequent reads to the LBA range indicated.

or

-> Frequent writes and frequent reads to the LBA range indicated.

> +	__REQ_WRITE_MEDIUM,	/* medium life time write */

-> Typical number of reads and writes expected for this LBA range.

> +	__REQ_WRITE_LONG,	/* long life time write */

-> Infrequent writes and infrequent reads to the LBA range indicated.

or

-> Infrequent writes and frequent reads to the LBA range indicated.

> +	__REQ_WRITE_EXTREME,	/* extremely long life time write */

-> One time write. E.g. command is due to virus scan, backup, file
copy, or archive.
