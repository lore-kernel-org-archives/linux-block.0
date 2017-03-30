Return-Path: <hch@lst.de>
Date: Thu, 30 Mar 2017 11:02:01 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "agk@redhat.com" <agk@redhat.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@kernel.org" <shli@kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 12/23] sd: handle REQ_UNMAP
Message-ID: <20170330090201.GD12015@lst.de>
References: <20170323143341.31549-1-hch@lst.de> <20170323143341.31549-13-hch@lst.de> <1490719722.2573.8.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1490719722.2573.8.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 28, 2017 at 04:48:55PM +0000, Bart Van Assche wrote:
> >  	if (sdp->no_write_same)
> >  		return BLKPREP_INVALID;
> >  	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)
> 
> Users can change the provisioning mode from user space from�SD_LBP_WS16 into
> SD_LBP_WS10 so I'm not sure it's safe to skip the (sdkp->ws16 || sector >
> 0xffffffff || nr_sectors > 0xffff) check if REQ_UNMAP is set.

They can, and if the device has too many sectors that will already cause
discard to fail, and in this case it will cause write zeroes to fail as
well.  The intent behind this patch is to keep the behavior the same
as the old path that uses discards for zeroing.  The logic looks a bit
clumsy, but I'd rather keep it as-is.
