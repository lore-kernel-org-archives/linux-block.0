Return-Path: <prvs=749b68ccf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 02/10] block, scsi: Give RQF_PREEMPT back its original
 meaning
Date: Mon, 6 Aug 2018 13:54:40 +0000
Message-ID: <4d70e0857780753bd8938b06f3a1a5ead2e0f4c1.camel@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
	 <20180804000325.3610-3-bart.vanassche@wdc.com>
	 <4a329d4c-8b11-be8f-28f7-88839a6f9b66@suse.de>
In-Reply-To: <4a329d4c-8b11-be8f-28f7-88839a6f9b66@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-08-06 at 08:27 +-0200, Hannes Reinecke wrote:
+AD4- I am not sure this is going to work for SCSI parallel+ADs- we're usin=
g the
+AD4- QUIESCE state there to do domain validation, and all commands there a=
re
+AD4- most definitely not PM requests.
+AD4- Can you please validate your patches with eg aic7xxx and SCSI paralle=
l
+AD4- disks?

Hello Hannes,

How about using the RQF+AF8-PM flag for SCSI parallel requests instead of
RQF+AF8-PREEMPT? That change will also avoid that RQF+AF8-PREEMPT has a dou=
ble meaning.
Anyway, I will see whether I can drop that change from this series and subm=
it
that change seperately.

Thanks,

Bart.
