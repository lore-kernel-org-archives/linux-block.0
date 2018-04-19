Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 19 Apr 2018 13:18:55 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"maier@linux.ibm.com" <maier@linux.ibm.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	"dgilbert@interlog.com" <dgilbert@interlog.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>,
	"lduncan@suse.com" <lduncan@suse.com>,
	"osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH blktests] scsi/004: add regression test for false
 BLK_STS_OK with non good SAM status
Message-ID: <20180419201855.GD20941@vader>
References: <1523955817-15790-1-git-send-email-maier@linux.ibm.com>
 <20180419185330.GA20941@vader>
 <20180419191320.GB20941@vader>
 <18799c58a6ce27142b46ba6ec471e09f1eefedcf.camel@wdc.com>
 <55fb164b-e4a4-95c8-2382-f7251c4973df@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55fb164b-e4a4-95c8-2382-f7251c4973df@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 19, 2018 at 01:44:41PM -0600, Jens Axboe wrote:
> On 4/19/18 1:41 PM, Bart Van Assche wrote:
> > On Thu, 2018-04-19 at 12:13 -0700, Omar Sandoval wrote:
> >> On Thu, Apr 19, 2018 at 11:53:30AM -0700, Omar Sandoval wrote:
> >>> Thanks for the test! Applied.
> >>
> >> Side note, it's unfortunate that this test takes 180 seconds to run only
> >> because we have to wait for the command timeout. We should be able to
> >> export request_queue->rq_timeout writeable in sysfs. Would you be
> >> interested in doing that?
> > 
> > Hello Omar,
> > 
> > Is this perhaps what you are looking for?
> > # ls -l /sys/class/scsi_device/*/*/timeout             
> > -rw-r--r-- 1 root root 4096 Apr 19 08:52 /sys/class/scsi_device/2:0:0:0/device/timeout
> > -rw-r--r-- 1 root root 4096 Apr 19 12:39 /sys/class/scsi_device/8:0:0:1/device/timeout
> 
> We should have it generically available though, not just for SCSI. In
> retrospect, it should have been under queue/ from the start, now we'll
> end up with duplicate entries for SCSI.

For the sake of this test, I just decreased the timeout through SCSI.
