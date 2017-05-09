Return-Path: <markus@trippelsdorf.de>
Date: Tue, 9 May 2017 06:42:10 +0200
From: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Remove leading whitespace and trailing newline in
 elevator switch error message
Message-ID: <20170509044209.GB17152@x4>
References: <20170506052243.GB291@x4>
 <TU4PR84MB03040339EFF3AB676CBD1382ABEF0@TU4PR84MB0304.NAMPRD84.PROD.OUTLOOK.COM>
 <27B041E0-D0FD-4072-ADAA-B36EDC8D09C0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <27B041E0-D0FD-4072-ADAA-B36EDC8D09C0@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On 2017.05.08 at 20:22 -0600, Jens Axboe wrote:
> 
> > On May 8, 2017, at 8:18 PM, Elliott, Robert (Persistent Memory)
> > <elliott@hpe.com> wrote:
> >> +        printk(KERN_ERR "elevator: type %s not found\n", name);
> > ...
> >> +    printk(KERN_ERR "elevator: switch to %s failed\n",
> > 
> > That leaves two lines of error prints for a single error, and
> > the second line doesn't convey additional information.
> 
> Yeah good point. Honestly I think we should just kill both lines. None
> of them add value. 

They at least help debugging of udev rules, e.g. on Gentoo they have:

 # set noop on solid state drives
 SUBSYSTEM=="block", ACTION=="add", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="noop"

And this will of course fail for mq. But how will you notice it without
any dmesg error message?

-- 
Markus
