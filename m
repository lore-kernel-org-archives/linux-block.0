Return-Path: <ming.lei@redhat.com>
Date: Tue, 26 Sep 2017 17:11:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/6] Make SCSI device suspend and resume work reliably
Message-ID: <20170926091145.GE518@ming.t460p>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
 <CACVXFVNCcij6RNNxZ77iDMc_82j_qpfso+g+NqpfgN3Cs9=FpQ@mail.gmail.com>
 <1506356246.2641.8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506356246.2641.8.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 04:17:27PM +0000, Bart Van Assche wrote:
> On Mon, 2017-09-25 at 10:36 +0800, Ming Lei wrote:
> > On Sat, Sep 23, 2017 at 6:13 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> > > It is known that during the resume following a hibernate sometimes the
> > > system hangs instead of coming up properly. This patch series fixes this
> > > problem. This patch series is an alternative for Ming Lei's "[PATCH V5
> > > 0/10] block/scsi: safe SCSI quiescing" patch series. The advantages of
> > > this patch series are:
> > 
> > No, your patch doesn't fix scsi quiesce on block legacy, so not an alternative
> > of my patchset at all.
> 
> This patch series definitely is an alternative for blk-mq/scsi-mq. And as you
> know my approach can be extended easily to the legacy SCSI core by adding
> blk_queue_enter() / blk_queue_exit() calls where necessary in the legacy block
> layer. I have not done this because the bug report was against scsi-mq and not
> against the legacy SCSI core. Additionally, since the legacy block layer and
> SCSI core are on their way out I did not want to spend time on modifying these.

Let me show you the legacy report and verification:

	https://www.spinics.net/lists/linux-block/msg17237.html

If you have transport_spi device at hand, the issue can be reproduced
in several minutes by the following way:

	- set nr_request of this disk as 4
	- while true; do
		trigger revalidate once in 5 seconds
		meantime run heavy/background concurrent I/O

-- 
Ming
