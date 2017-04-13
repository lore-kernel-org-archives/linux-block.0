Return-Path: <bblock@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 14:23:58 +0200
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/6] Avoid that scsi-mq and dm-mq queue processing
 stalls sporadically
References: <20170407181654.27836-1-bart.vanassche@sandisk.com>
 <20170412105538.GB22576@bblock-ThinkPad-W530>
 <1492020683.2764.9.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1492020683.2764.9.camel@sandisk.com>
Message-Id: <20170413122358.GH22576@bblock-ThinkPad-W530>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 12, 2017 at 06:11:25PM +0000, Bart Van Assche wrote:
> On Wed, 2017-04-12 at 12:55 +0200, Benjamin Block wrote:
> > On Fri, Apr 07, 2017 at 11:16:48AM -0700, Bart Van Assche wrote:
> > > The six patches in this patch series fix the queue lockup I reported
> > > recently on the linux-block mailing list. Please consider these patches
> > > for inclusion in the upstream kernel.
> >
> > just out of curiosity. Is this maybe related to similar stuff happening
> > when CPUs are hot plugged - at least in that the stack gets stuck? Like
> > in this thread here:
> > https://www.mail-archive.com/linux-block@vger.kernel.org/msg06057.html
> >
> > Would be interesting, because we recently saw similar stuff happening.
>
> Hello Benjamin,
>
> My proposal is to repeat that test with Jens' for-next branch. If the issue
> still occurs with that tree then please check the contents of
> /sys/kernel/debug/block/*/mq/*/{dispatch,*/rq_list}. That will allow to
> determine whether or not any block layer requests are still pending. If
> running the command below resolves the deadlock then it means that a
> trigger to run a block layer queue is still missing somewhere:
>
> for a in /sys/kernel/debug/block/*/mq/state; do echo run >$a;�done
>
> See also git://git.kernel.dk/linux-block.git.
>

Thx for the hint! I'll forward that and see if the affected folks are
willing to reproduce.


                                                    Beste Gr��e / Best regards,
                                                      - Benjamin Block
--
Linux on z Systems Development         /         IBM Systems & Technology Group
		  IBM Deutschland Research & Development GmbH
Vorsitz. AufsR.: Martina Koederitz     /        Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
