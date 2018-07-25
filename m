Return-Path: <prvs=737f04b27=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ps@pks.im" <ps@pks.im>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Date: Wed, 25 Jul 2018 18:13:02 +0000
Message-ID: <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
References: 
 <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
In-Reply-To: 
 <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-13 at 15:29 +-0200, Patrick Steinhardt wrote:
+AD4- When power management for SCSI is enabled and if a device uses blk-mq=
,
+AD4- it is possible to trigger a +AGA-NULL+AGA- pointer exception when res=
uming that
+AD4- device. The NPE is triggered when trying to dereference the +AGA-requ=
est+AF8-fn+AGA-
+AD4- function pointer of the device's +AGA-request+AF8-queue+AGA-:
+AD4-=20
+AD4-     +AF8AXw-blk+AF8-run+AF8-queue+AF8-uncond:470
+AD4-     +AF8AXw-blk+AF8-run+AF8-queue:490
+AD4-     blk+AF8-post+AF8-runtime+AF8-resume:3889
+AD4-     sdev+AF8-runtime+AF8-resume:263
+AD4-     scsi+AF8-runtime+AF8-resume:275
+AD4-=20
+AD4- When the SCSI device is being allocated by +AGA-scsi+AF8-alloc+AF8-sd=
ev+AGA-, the
+AD4- device's request queue will either be initialized via
+AD4- +AGA-scsi+AF8-mq+AF8-alloc+AF8-queue+AGA- or +AGA-scsi+AF8-old+AF8-al=
loc+AF8-queue+AGA-. But the +AGA-request+AF8-fn+AGA-
+AD4- member of the request queue is in fact only being set in
+AD4- +AGA-scsi+AF8-old+AF8-alloc+AF8-queue+AGA-, which will then later cau=
se the mentioned NPE.
+AD4-=20
+AD4- Fix the issue by checking whether the +AGA-request+AF8-fn+AGA- is set=
 in
+AD4- +AGAAXwBf-blk+AF8-run+AF8-queue+AF8-uncond+AGA-. In case it is unset,=
 we'll silently return and
+AD4- not try to invoke the callback, thus fixing the NPE.

Which kernel version are you using? Can you check whether the following two
commits are in your kernel tree?

+ACo- 4fd41a8552af (+ACI-SCSI: Fix NULL pointer dereference in runtime PM+A=
CIAOw- December
  2015).
+ACo- 765e40b675a9 (+ACI-block: disable runtime-pm for blk-mq+ACIAOw- July =
2017).

Thanks,

Bart.
