Return-Path: <hch@lst.de>
Date: Mon, 25 Sep 2017 18:20:44 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/6] Make SCSI device suspend and resume work
	reliably
Message-ID: <20170925162044.GB12952@lst.de>
References: <20170922221405.22091-1-bart.vanassche@wdc.com> <CACVXFVNCcij6RNNxZ77iDMc_82j_qpfso+g+NqpfgN3Cs9=FpQ@mail.gmail.com> <1506356246.2641.8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506356246.2641.8.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 04:17:27PM +0000, Bart Van Assche wrote:
> This patch series definitely is an alternative for blk-mq/scsi-mq. And as you
> know my approach can be extended easily to the legacy SCSI core by adding
> blk_queue_enter() / blk_queue_exit() calls where necessary in the legacy block
> layer. I have not done this because the bug report was against scsi-mq and not
> against the legacy SCSI core. Additionally, since the legacy block layer and
> SCSI core are on their way out I did not want to spend time on modifying these.

For now we'll have to fix both paths to have equal functionality.  Even
if scsi might be on it's way out there still are many drivers that
use the legacy request path, and with mmc we'll probably grow another
dual block layer driver soon, although hopefully the transition
period will be much shorter.
