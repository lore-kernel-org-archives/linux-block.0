Return-Path: <linux-scsi-owner@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, Mike Snitzer <snitzer@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 15/18] scsi: allocate scsi_cmnd structures as part of struct request
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
        <1485365126-23210-16-git-send-email-hch@lst.de>
Date: Wed, 25 Jan 2017 22:30:18 -0500
In-Reply-To: <1485365126-23210-16-git-send-email-hch@lst.de> (Christoph
        Hellwig's message of "Wed, 25 Jan 2017 18:25:23 +0100")
Message-ID: <yq17f5i8pmd.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> Rely on the new block layer functionality to allocate
Christoph> additional driver specific data behind struct request instead
Christoph> of implementing it in SCSI itѕelf.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
