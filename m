Return-Path: <martin.petersen@oracle.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: axboe@kernel.dk, hch@infradead.org, tytso@mit.edu,
        martin.petersen@oracle.com, snitzer@redhat.com,
        linux-api@vger.kernel.org, bfoster@redhat.com, xfs@oss.sgi.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] block: require write_same and discard requests align to logical block size
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <146612624734.12764.4316680863289411106.stgit@birch.djwong.org>
	<146612626092.12764.773833541076937471.stgit@birch.djwong.org>
Date: Wed, 29 Jun 2016 00:58:06 -0400
In-Reply-To: <146612626092.12764.773833541076937471.stgit@birch.djwong.org>
	(Darrick J. Wong's message of "Thu, 16 Jun 2016 18:17:41 -0700")
Message-ID: <yq1oa6ksiap.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

>>>>> "Darrick" == Darrick J Wong <darrick.wong@oracle.com> writes:

Darrick> Make sure that the offset and length arguments that we're using
Darrick> to construct WRITE SAME and DISCARD requests are actually
Darrick> aligned to the logical block size.  Failure to do this causes
Darrick> other errors in other parts of the block layer or the SCSI
Darrick> layer because disks don't support partial logical block writes.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
