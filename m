Return-Path: <BATV+736af7e55a6f7db1fe82+5455+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 31 Jul 2018 13:12:25 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "keescook@chromium.org" <keescook@chromium.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"vinod.koul@intel.com" <vinod.koul@intel.com>,
	"david.kershner@unisys.com" <david.kershner@unisys.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"nab@linux-iscsi.org" <nab@linux-iscsi.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"manoj@linux.vnet.ibm.com" <manoj@linux.vnet.ibm.com>,
	"sdharia@codeaurora.org" <sdharia@codeaurora.org>,
	"jgross@suse.com" <jgross@suse.com>,
	"cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"pombredanne@nexb.com" <pombredanne@nexb.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"mrochs@linux.vnet.ibm.com" <mrochs@linux.vnet.ibm.com>,
	"tj@kernel.org" <tj@kernel.org>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ukrishn@linux.vnet.ibm.com" <ukrishn@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/9] scsi: build scsi_common.o for all scsi
 passthrough request users
Message-ID: <20180731201225.GA1989@infradead.org>
References: <20180731195155.46664-1-keescook@chromium.org>
 <20180731195155.46664-4-keescook@chromium.org>
 <a5b545eade66f95c9a9ecf37676306a8d395187c.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a5b545eade66f95c9a9ecf37676306a8d395187c.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 31, 2018 at 08:01:16PM +0000, Bart Van Assche wrote:
> On Tue, 2018-07-31 at 12:51 -0700, Kees Cook wrote:
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 24cd47014657..a6abd7a856c6 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -76,7 +76,7 @@ obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
> >  obj-$(CONFIG_NUBUS)		+= nubus/
> >  obj-y				+= macintosh/
> >  obj-$(CONFIG_IDE)		+= ide/
> > -obj-$(CONFIG_SCSI)		+= scsi/
> > +obj-y				+= scsi/
> >  obj-y				+= nvme/
> >  obj-$(CONFIG_ATA)		+= ata/
> >  obj-$(CONFIG_TARGET_CORE)	+= target/
> 
> The above change not only selects scsi_common.o but also the following object
> files: scsi.o hosts.o scsi_ioctl.o scsicam.o scsi_error.o scsi_lib.o scsi_scan.o
> scsi_sysfs.o scsi_devinfo.o scsi_trace.o scsi_logging.o. That is a change that
> has not been mentioned in the patch description.

It shouldn't.  All these are built into scsi_mod.o, which is only built
when CONFIG_SCSI is set.  Under what circumstances do you see them built?
