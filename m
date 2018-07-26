Return-Path: <prvs=7387fcde5=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ps@pks.im" <ps@pks.im>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Date: Thu, 26 Jul 2018 13:51:48 +0000
Message-ID: <62ddc886d005b91bd6a1bd8775259bb0b5cbe2b2.camel@wdc.com>
References: 
 <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
	 <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
	 <20180726083850.GB1674@ncase>
In-Reply-To: <20180726083850.GB1674@ncase>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-26 at 10:38 +-0200, Patrick Steinhardt wrote:
+AD4- That still leaves the other problem of broken suspend. I've just
+AD4- checked with v4.17.10, and it's still there: as soon as I resume
+AD4- from suspend, the kernel oopses and reboots the machine. I guess
+AD4- I'll have to do another debugging session and see where it fails
+AD4- exactly (and no, this time there are no more changes to the
+AD4- kernel tree).

Can you share the kernel oops details before you start running a bisect?

Thanks,

Bart.
