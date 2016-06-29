Return-Path: <martin.petersen@oracle.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: axboe@kernel.dk, hch@infradead.org, tytso@mit.edu,
        martin.petersen@oracle.com, snitzer@redhat.com,
        linux-api@vger.kernel.org, bfoster@redhat.com, xfs@oss.sgi.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: invalidate the page cache when issuing BLKZEROOUT.
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <146612624734.12764.4316680863289411106.stgit@birch.djwong.org>
	<146612625412.12764.6647932282740152837.stgit@birch.djwong.org>
Date: Wed, 29 Jun 2016 00:57:27 -0400
In-Reply-To: <146612625412.12764.6647932282740152837.stgit@birch.djwong.org>
	(Darrick J. Wong's message of "Thu, 16 Jun 2016 18:17:34 -0700")
Message-ID: <yq1shvwsibs.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

>>>>> "Darrick" == Darrick J Wong <darrick.wong@oracle.com> writes:

Darrick> Invalidate the page cache (as a regular O_DIRECT write would
Darrick> do) to avoid returning stale cache contents at a later time.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
