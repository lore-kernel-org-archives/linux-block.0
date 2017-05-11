Return-Path: <hch@lst.de>
Date: Thu, 11 May 2017 08:26:30 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: "hch@lst.de" <hch@lst.de>, Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"agk@redhat.com" <agk@redhat.com>,
	"lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
	"snitzer@redhat.com" <snitzer@redhat.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"shli@kernel.org" <shli@kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 25/27] block: remove the discard_zeroes_data flag
Message-ID: <20170511062630.GA18517@lst.de>
References: <20170405172125.22600-26-hch@lst.de> <1493671519.2665.15.camel@sandisk.com> <1493707425.23202.77.camel@haakon3.risingtidesystems.com> <1493709373.23202.79.camel@haakon3.risingtidesystems.com> <20170502072328.GA11522@lst.de> <1493782395.23202.84.camel@haakon3.risingtidesystems.com> <20170507092209.GA27370@lst.de> <1494312374.16894.36.camel@haakon3.risingtidesystems.com> <20170510140627.GA23759@lst.de> <1494478235.16894.115.camel@haakon3.risingtidesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494478235.16894.115.camel@haakon3.risingtidesystems.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 10, 2017 at 09:50:35PM -0700, Nicholas A. Bellinger wrote:
> 1) Expose a block_device or request_queue bit to signal 'real LBPRZ'
> support up to IBLOCK, in order to maintain SCSI target feature
> compatibility.

No way.  If you want to zero use REQ_OP_WRITE_ZEROES..
