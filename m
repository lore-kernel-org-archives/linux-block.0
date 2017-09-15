Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] scsi_transport_fc: fix NULL pointer dereference in fc_bsg_job_timeout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170907115436.5069-1-hch@lst.de>
	<20170907115436.5069-3-hch@lst.de>
Date: Thu, 14 Sep 2017 20:40:40 -0400
In-Reply-To: <20170907115436.5069-3-hch@lst.de> (Christoph Hellwig's message
	of "Thu, 7 Sep 2017 13:54:36 +0200")
Message-ID: <yq1bmmcssjb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> bsg-lib now embeddeds the job structure into the request, and
> req->special can't be used anymore.

Applied to 4.14/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering
