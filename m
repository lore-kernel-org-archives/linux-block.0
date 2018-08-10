Return-Path: <prvs=753ac577b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hare@suse.com" <hare@suse.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v6 02/12] scsi: Alter handling of RQF_DV requests
Date: Fri, 10 Aug 2018 15:07:00 +0000
Message-ID: <3a763b4c0db34fbab0d31573f07cf8ee5fcd3170.camel@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
	 <20180809194149.15285-3-bart.vanassche@wdc.com>
	 <20180810012019.GA2816@ming.t460p>
In-Reply-To: <20180810012019.GA2816@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-10 at 09:20 +-0800, Ming Lei wrote:
+AD4- On Thu, Aug 09, 2018 at 12:41:39PM -0700, Bart Van Assche wrote:
+AD4- +AD4- Process all requests in state SDEV+AF8-CREATED instead of only =
RQF+AF8-DV
+AD4- +AD4- requests. This does not change the behavior of the SCSI core be=
cause
+AD4- +AD4- the SCSI device state is modified into another state before SCS=
I
+AD4- +AD4- devices become visible in sysfs and before any device nodes are
+AD4- +AD4- created in /dev. Do not process RQF+AF8-DV requests in state SD=
EV+AF8-CANCEL
+AD4- +AD4- because only power management requests should be processed in t=
his
+AD4- +AD4- state.
+AD4-=20
+AD4- Could you explain a bit why only PM requests should be processed in
+AD4- SDEV+AF8-CANCEL?

Hi Ming,

There is only one function that changes the device state into SDEV+AF8-CANC=
EL,
namely +AF8AXw-scsi+AF8-remove+AF8-device(). I think that in the SDEV+AF8-C=
ANCEL state all
newly queued requests should be ignored except the SYNCHRONIZE CACHE and
STOP commands submitted by sd+AF8-shutdown(). More information about the SC=
SI
device states is available in the commit message of 9b22a8fb0edd (+ACI-Upda=
ted
state model for SCSI devices+ACI-).

Bart.
