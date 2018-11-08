Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
To: Keith Busch <keith.busch@intel.com>, Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
References: <20181107143745.11845-1-keith.busch@intel.com>
 <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
 <20181107151538.GA11941@localhost.localdomain>
 <CACVXFVNbzK-WjJDrFjvApHE7R9bG3MnbN6M507d43KnUh3Ujpw@mail.gmail.com>
 <20181107154412.GB11941@localhost.localdomain>
 <CACVXFVPUwc9jDirAk2a4w8WhF-EqLXRputTZ+iOp9=1qAsfoeA@mail.gmail.com>
 <20181107160909.GC11941@localhost.localdomain>
 <CACVXFVMcxNdbFnJd46fd05MJ63NT5VE-M+jrjSqxP0E9zaYcag@mail.gmail.com>
 <20181108012251.GB15857@localhost.localdomain>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <e867f35f-f9ac-0a37-dbb5-700704bb6364@suse.de>
Date: Thu, 8 Nov 2018 11:07:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181108012251.GB15857@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/11/2018 02:22, Keith Busch wrote:
> $ ./sg-test /dev/sda | grep -v 000000000000000000000000000000000
> 40733f4019dbffff8001244019dbffff4065244019dbffff0094244019dbffff
> c025244019dbffffc0e43a4019dbffff40973a4019dbffffc0623a4019dbffff
> 800c244019dbffffc0d61d4019dbffffc05f244019dbffff80091e4019dbffff
> 40913a4019dbffff806f3f4019dbffff40a83f4019dbffffc083244019dbffff
> 80eb1e4019dbffff00a93f4019dbffffc09a3a4019dbffff40503f4019dbffff
> 007f1b4019dbffffc0d91e4019dbffff40551e4019dbffff804a1b4019dbffff
> ....
> --
> 

Hi Keith,
Can you please add the above to blktests?

This would be very useful for downstream distributions.

Thanks a lot,
	Johannes

-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
