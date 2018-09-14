Return-Path: <hch@lst.de>
Date: Fri, 14 Sep 2018 14:58:13 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@lst.de" <hch@lst.de>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 02/10] block, scsi: Give RQF_PREEMPT back its
 original meaning
Message-ID: <20180914125813.GB26651@lst.de>
References: <20180804000325.3610-1-bart.vanassche@wdc.com> <20180804000325.3610-3-bart.vanassche@wdc.com> <4a329d4c-8b11-be8f-28f7-88839a6f9b66@suse.de> <4d70e0857780753bd8938b06f3a1a5ead2e0f4c1.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d70e0857780753bd8938b06f3a1a5ead2e0f4c1.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 06, 2018 at 01:54:40PM +0000, Bart Van Assche wrote:
> On Mon, 2018-08-06 at 08:27 +0200, Hannes Reinecke wrote:
> > I am not sure this is going to work for SCSI parallel; we're using the
> > QUIESCE state there to do domain validation, and all commands there are
> > most definitely not PM requests.
> > Can you please validate your patches with eg aic7xxx and SCSI parallel
> > disks?
> 
> Hello Hannes,
> 
> How about using the RQF_PM flag for SCSI parallel requests instead of
> RQF_PREEMPT? That change will also avoid that RQF_PREEMPT has a double meaning.
> Anyway, I will see whether I can drop that change from this series and submit
> that change seperately.

One thing I'd like to do is split BLK_MQ_REQ_PREEMPT and RQF_PREEMPT,
that is don't set RQF_PREEMPT automatically when BLK_MQ_REQ_PREEMPT is
passed to blk_get_request, but let the caller set it manually.  After
that RQF_PREEMPT isn't used by the block layer itself at all and can
be moved into ide/scsi specific flags that we can use as we want.
