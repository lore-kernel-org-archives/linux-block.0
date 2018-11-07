Return-Path: <keith.busch@intel.com>
Date: Wed, 7 Nov 2018 09:09:09 -0700
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
Message-ID: <20181107160909.GC11941@localhost.localdomain>
References: <20181107143745.11845-1-keith.busch@intel.com>
 <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
 <20181107151538.GA11941@localhost.localdomain>
 <CACVXFVNbzK-WjJDrFjvApHE7R9bG3MnbN6M507d43KnUh3Ujpw@mail.gmail.com>
 <20181107154412.GB11941@localhost.localdomain>
 <CACVXFVPUwc9jDirAk2a4w8WhF-EqLXRputTZ+iOp9=1qAsfoeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVPUwc9jDirAk2a4w8WhF-EqLXRputTZ+iOp9=1qAsfoeA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 08, 2018 at 12:03:41AM +0800, Ming Lei wrote:
> On Wed, Nov 7, 2018 at 11:47 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > On Wed, Nov 07, 2018 at 11:44:59PM +0800, Ming Lei wrote:
> > > blk_update_request() may tell us how much progress made, :-)
> >
> > Except when it doesn't, which is 100% of the time for many block
> > drivers, including nvme.
> 
> Please look at blk_mq_end_request()(<- nvme_complete_rq()), which
> calls blk_update_request().

Huh? That just says 100% of the request size was transerred no matter
what was actually transferred.

The protocol doesn't have a way to express what transfer size occured
with a command's completion, and even it did, there's no way I'd trust
every firmware not to screw it.
