Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C8CC433DF
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529032078B
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbgEYJ4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 05:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389333AbgEYJ4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 05:56:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F188C061A0E;
        Mon, 25 May 2020 02:56:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jd9qA-0006Ec-Sg; Mon, 25 May 2020 11:56:15 +0200
Date:   Mon, 25 May 2020 11:56:13 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Phillip Susi <psusi@ubuntu.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH v1 04/25] block: nr_sects_write(): Disable preemption on
 seqcount write
Message-ID: <20200525095613.GB370823@debian-buster-darwi.lab.linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-5-a.darwish@linutronix.de>
 <20200522163908.GP325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522163908.GP325280@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, May 19, 2020 at 11:45:26PM +0200, Ahmed S. Darwish wrote:
> > For optimized block readers not holding a mutex, the "number of sectors"
> > 64-bit value is protected from tearing on 32-bit architectures by a
> > sequence counter.
> >
> > Disable preemption before entering that sequence counter's write side
> > critical section. Otherwise, the read side can preempt the write side
> > section and spin for the entire scheduler tick. If the reader belongs to
> > a real-time scheduling class, it can spin forever and the kernel will
> > livelock.
> >
> > Fixes: c83f6bf98dc1 ("block: add partition resize function to blkpg ioctl")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  block/blk.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/block/blk.h b/block/blk.h
> > index 0a94ec68af32..151f86932547 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -470,9 +470,11 @@ static inline sector_t part_nr_sects_read(struct hd_struct *part)
> >  static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
> >  {
> >  #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
> > +	preempt_disable();
> >  	write_seqcount_begin(&part->nr_sects_seq);
> >  	part->nr_sects = size;
> >  	write_seqcount_end(&part->nr_sects_seq);
> > +	preempt_enable();
> >  #elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
> >  	preempt_disable();
> >  	part->nr_sects = size;
>
> This does look like something that include/linux/u64_stats_sync.h could
> help with.

Correct.

I just felt though that this would be too much for a 'Cc: stable' patch.

In another (in-progress) seqlock.h patch series, all of the seqcount_t
call sites that are used for 64-bit values tearing protection on 32-bit
kernels are transformed to the u64_stats_sync.h API.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
