Return-Path: <prvs=749b68ccf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v4 02/10] block, scsi: Give RQF_PREEMPT back its original
 meaning
Date: Mon, 6 Aug 2018 14:15:44 +0000
Message-ID: <a3c2efd9423c547c9389b23e70fa857c25e5fa07.camel@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
	 <20180804000325.3610-3-bart.vanassche@wdc.com>
	 <CACVXFVO3Ge7LRQdSvRMzAgSrQVFcHZGMAMnt_duNqX6X7Z=Dvw@mail.gmail.com>
In-Reply-To: 
 <CACVXFVO3Ge7LRQdSvRMzAgSrQVFcHZGMAMnt_duNqX6X7Z=Dvw@mail.gmail.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2018-08-04 at 09:16 +-0800, Ming Lei wrote:
+AD4- The above change will cause regression on SPI transport, please see
+AD4- spi+AF8-dv+AF8-device(), where non-PM command is sent to device via
+AD4- scsi+AF8-execute() after the device is put to QUIESCE.

Hello Ming,

I will drop this patch for now and revisit this change later.

Bart.
