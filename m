Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: sr: get/drop reference to device in revalidate and check_events
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <a76164e7-8d9f-37d5-8c2e-6733778d20da@kernel.dk>
Date: Thu, 12 Apr 2018 22:41:06 -0400
In-Reply-To: <a76164e7-8d9f-37d5-8c2e-6733778d20da@kernel.dk> (Jens Axboe's
	message of "Wed, 11 Apr 2018 10:23:30 -0600")
Message-ID: <yq1muy7u8u5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> We can't just use scsi_cd() to get the scsi_cd structure, we have
> to grab a live reference to the device. For both callbacks, we're
> not inside an open where we already hold a reference to the device.

Applied to 4.17/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
