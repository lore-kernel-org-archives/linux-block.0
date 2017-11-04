Return-Path: <ming.lei@redhat.com>
Date: Sat, 4 Nov 2017 10:11:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171104021136.GA10440@ming.t460p>
References: <1509670091.2636.0.camel@wdc.com>
 <CAFfF4qsbPCj3XLw0HkyJYELcqeqiPx_nR-G-1tSRew9z7ujw2Q@mail.gmail.com>
 <20171103021234.GH27370@ming.t460p>
 <1509676969.10883.0.camel@wdc.com>
 <20171103035050.GI27370@ming.t460p>
 <1509722593.2473.12.camel@wdc.com>
 <20171103154700.GA7021@ming.t460p>
 <1509724220.2473.21.camel@wdc.com>
 <CAFfF4qvBsTUE1jzYfd0b7GnNF3z_ojypfpWHbcwFUtZG422_MQ@mail.gmail.com>
 <20171103164730.GB7021@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171103164730.GB7021@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Sat, Nov 04, 2017 at 12:47:31AM +0800, Ming Lei wrote:
> On Fri, Nov 03, 2017 at 12:13:09PM -0400, Laurence Oberman wrote:
> > Hi
> > I had it working some time back. I am off today to take my son to the
> > doctor.
> > I will get Bart's test working again this weekend.
> 
> Hello Laurence and Bart,
> 
> Just found srp-test starts to work now with v4.14-rc4 kernel, and
> the IO hang issue has been reproduced one time. BTW, the connection
> failure happened on for-next of block tree.
> 
> Will investigate the issue this weekend.

Hi Bart,

Please test the following patch to see if your issue can be fixed:

https://marc.info/?l=linux-scsi&m=150976056219162&w=2

I run three times of your test 01, not see the hang issue any more
once this patch is applied.

Thanks,
Ming

> 
> > 
> > On Nov 3, 2017 11:51 AM, "Bart Van Assche" <Bart.VanAssche@wdc.com> wrote:
> > 
> > > On Fri, 2017-11-03 at 23:47 +0800, Ming Lei wrote:
> > > > Forget to mention, there is failure when running 'make' under srp-test
> > > > because shellcheck package is missed in RHEL7. Can that be the issue
> > > > of test failure? If yes, could you provide a special version of srp-test
> > > > which doesn't depend on shellcheck?
> > >
> > > The srp-test software does not depend on shellcheck. The only purpose of
> > > the "shellcheck" target in the srp-test Makefile is to verify the syntax
> > > of the shell scripts. The tests run fine even if shellcheck is missing.
> > >
> > > Bart.
> 
> -- 
> Ming

-- 
Ming
