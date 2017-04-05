Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH 10/25] block: add a flags argument to (__)blkdev_issue_zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170331163313.31821-1-hch@lst.de>
	<20170331163313.31821-11-hch@lst.de>
Date: Wed, 05 Apr 2017 07:46:31 -0400
In-Reply-To: <20170331163313.31821-11-hch@lst.de> (Christoph Hellwig's message
	of "Fri, 31 Mar 2017 18:32:58 +0200")
Message-ID: <yq160ijt6ug.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Turn the existin discard flag into a new BLKDEV_ZERO_UNMAP flag with
                  g

> similar semantics, but without referring to di=D1=95card.
                                                s

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

--=20
Martin K. Petersen	Oracle Linux Engineering
