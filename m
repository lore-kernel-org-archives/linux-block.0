Return-Path: <martin.petersen@oracle.com>
To: "hch\@lst.de" <hch@lst.de>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "agk\@redhat.com" <agk@redhat.com>,
        "lars.ellenberg\@linbit.com" <lars.ellenberg@linbit.com>,
        "snitzer\@redhat.com" <snitzer@redhat.com>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        "philipp.reisner\@linbit.com" <philipp.reisner@linbit.com>,
        "axboe\@kernel.dk" <axboe@kernel.dk>,
        "shli\@kernel.org" <shli@kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel\@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev\@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid\@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 23/23] block: remove the discard_zeroes_data flag
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-24-hch@lst.de>
	<1490720411.2573.11.camel@sandisk.com> <20170330090655.GF12015@lst.de>
Date: Thu, 30 Mar 2017 11:29:29 -0400
In-Reply-To: <20170330090655.GF12015@lst.de> (hch@lst.de's message of "Thu, 30
	Mar 2017 11:06:55 +0200")
Message-ID: <yq1d1cy3hra.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

"hch@lst.de" <hch@lst.de> writes:

> Jens, any opinion?  I'd like to remove it too, but I fear it might
> break things.  We could deprecate it first with a warning when read
> and then remove it a few releases down the road.

I know of several apps that check this variable (as opposed to the
ioctl).

-- 
Martin K. Petersen	Oracle Linux Engineering
