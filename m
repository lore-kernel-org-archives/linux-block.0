Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 08/30] scsi: provide mq_ops->busy() hook
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20181031175922.8849-1-axboe@kernel.dk>
	<20181031175922.8849-9-axboe@kernel.dk>
Date: Tue, 06 Nov 2018 21:00:28 -0500
In-Reply-To: <20181031175922.8849-9-axboe@kernel.dk> (Jens Axboe's message of
	"Wed, 31 Oct 2018 11:59:00 -0600")
Message-ID: <yq1bm713av7.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> Only the SCSI legacy path provides a way to check if target is
> currently busy, provide the same for the MQ path.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
