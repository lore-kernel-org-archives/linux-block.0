Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
References: <20181107143745.11845-1-keith.busch@intel.com> <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
 <20181107151538.GA11941@localhost.localdomain> <CACVXFVNbzK-WjJDrFjvApHE7R9bG3MnbN6M507d43KnUh3Ujpw@mail.gmail.com>
 <20181107154412.GB11941@localhost.localdomain>
In-Reply-To: <20181107154412.GB11941@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 8 Nov 2018 00:03:41 +0800
Message-ID: <CACVXFVPUwc9jDirAk2a4w8WhF-EqLXRputTZ+iOp9=1qAsfoeA@mail.gmail.com>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 7, 2018 at 11:47 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Wed, Nov 07, 2018 at 11:44:59PM +0800, Ming Lei wrote:
> > blk_update_request() may tell us how much progress made, :-)
>
> Except when it doesn't, which is 100% of the time for many block
> drivers, including nvme.

Please look at blk_mq_end_request()(<- nvme_complete_rq()), which
calls blk_update_request().

Thanks,
Ming Lei
