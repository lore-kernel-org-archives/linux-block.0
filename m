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
Subject: Re: [PATCH 12/23] sd: handle REQ_UNMAP
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170323143341.31549-1-hch@lst.de>
	<20170323143341.31549-13-hch@lst.de>
	<1490719722.2573.8.camel@sandisk.com> <20170330090201.GD12015@lst.de>
Date: Thu, 30 Mar 2017 11:28:32 -0400
In-Reply-To: <20170330090201.GD12015@lst.de> (hch@lst.de's message of "Thu, 30
	Mar 2017 11:02:01 +0200")
Message-ID: <yq1h92a3hsv.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

"hch@lst.de" <hch@lst.de> writes:

Christoph,

> On Tue, Mar 28, 2017 at 04:48:55PM +0000, Bart Van Assche wrote:
>> >  	if (sdp->no_write_same)
>> >  		return BLKPREP_INVALID;
>> >  	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)
>>=20
>> Users can change the provisioning mode from user space from=C2=A0SD_LBP_=
WS16 into
>> SD_LBP_WS10 so I'm not sure it's safe to skip the (sdkp->ws16 || sector >
>> 0xffffffff || nr_sectors > 0xffff) check if REQ_UNMAP is set.
>
> They can, and if the device has too many sectors that will already cause
> discard to fail,

I'm not sure I understand what you mean by that?

--=20
Martin K. Petersen	Oracle Linux Engineering
