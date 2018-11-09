Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 09/30] scsi: kill off the legacy IO path
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20181031175922.8849-1-axboe@kernel.dk>
	<20181031175922.8849-10-axboe@kernel.dk> <yq17ehp3aiu.fsf@oracle.com>
	<9343e6fc-89fb-24ff-cccd-da33913534c2@kernel.dk>
Date: Thu, 08 Nov 2018 21:28:25 -0500
In-Reply-To: <9343e6fc-89fb-24ff-cccd-da33913534c2@kernel.dk> (Jens Axboe's
	message of "Tue, 6 Nov 2018 21:48:59 -0700")
Message-ID: <yq1y3a3vvau.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> Thanks for reviewing both of these. Since the series is hard to break
> apart, are you fine with me carrying this for 4.21 in the block tree?
> I can stage it very soon, which would make it trivial for you to base
> the 4.21 SCSI branch on it to avoid conflicting changes.

Sure, that's fine.

-- 
Martin K. Petersen	Oracle Linux Engineering
