Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 09/30] scsi: kill off the legacy IO path
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20181031175922.8849-1-axboe@kernel.dk>
 <20181031175922.8849-10-axboe@kernel.dk> <yq17ehp3aiu.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9343e6fc-89fb-24ff-cccd-da33913534c2@kernel.dk>
Date: Tue, 6 Nov 2018 21:48:59 -0700
MIME-Version: 1.0
In-Reply-To: <yq17ehp3aiu.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/6/18 7:07 PM, Martin K. Petersen wrote:
> 
> Jens,
> 
> Looks good to me.
> 
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks for reviewing both of these. Since the series is hard
to break apart, are you fine with me carrying this for 4.21
in the block tree? I can stage it very soon, which would make
it trivial for you to base the 4.21 SCSI branch on it to avoid
conflicting changes.

-- 
Jens Axboe
