Return-Path: <martin.petersen@oracle.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: axboe@kernel.dk, hch@infradead.org, tytso@mit.edu,
        martin.petersen@oracle.com, snitzer@redhat.com,
        linux-api@vger.kernel.org, bfoster@redhat.com, xfs@oss.sgi.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, bart.vanassche@sandisk.com
Subject: Re: [PATCH v10 0/3] fallocate for block devices
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <147216972158.7860.13484490862091226290.stgit@birch.djwong.org>
Date: Thu, 25 Aug 2016 22:15:52 -0400
In-Reply-To: <147216972158.7860.13484490862091226290.stgit@birch.djwong.org>
	(Darrick J. Wong's message of "Thu, 25 Aug 2016 17:02:01 -0700")
Message-ID: <yq1shtsb7hj.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

>>>>> "Darrick" == Darrick J Wong <darrick.wong@oracle.com> writes:

Darrick,

Darrick> This is a redesign of the patch series that fixes various
Darrick> interface problems with the existing "zero out this part of a
Darrick> block device" code.  BLKZEROOUT2 is gone.

Looks good to me. Let's get this merged. Pretty please!

-- 
Martin K. Petersen	Oracle Linux Engineering
