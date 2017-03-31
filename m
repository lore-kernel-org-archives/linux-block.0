Return-Path: <martin.petersen@oracle.com>
To: "hch\@lst.de" <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "agk\@redhat.com" <agk@redhat.com>,
        "lars.ellenberg\@linbit.com" <lars.ellenberg@linbit.com>,
        "snitzer\@redhat.com" <snitzer@redhat.com>,
        "philipp.reisner\@linbit.com" <philipp.reisner@linbit.com>,
        "axboe\@kernel.dk" <axboe@kernel.dk>,
        "shli\@kernel.org" <shli@kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel\@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev\@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid\@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 12/23] sd: handle REQ_UNMAP
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-13-hch@lst.de>
	<1490719722.2573.8.camel@sandisk.com> <20170330090201.GD12015@lst.de>
	<yq1h92a3hsv.fsf@oracle.com> <20170330173020.GB24229@lst.de>
Date: Thu, 30 Mar 2017 22:19:55 -0400
In-Reply-To: <20170330173020.GB24229@lst.de> (hch@lst.de's message of "Thu, 30
	Mar 2017 19:30:20 +0200")
Message-ID: <yq17f36yypg.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

"hch@lst.de" <hch@lst.de> writes:

> If you manually change the provisioning mode to WS10 on a device that
> must use WRITE SAME (16) to be able to address all blocks you're already
> screwed right now, and with this patch you can screw yourself through
> the WRITE_ZEROES path in addition to the DISCARD path.

Oh, I see. We only had the LBA sanity check in place for write same, not
for discard.

-- 
Martin K. Petersen	Oracle Linux Engineering
