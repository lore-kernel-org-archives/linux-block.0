Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:41280 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaSWN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jul 2018 14:22:13 -0400
Received: by mail-qk0-f182.google.com with SMTP id d22-v6so10639295qkc.8
        for <linux-block@vger.kernel.org>; Tue, 31 Jul 2018 09:41:05 -0700 (PDT)
Date: Tue, 31 Jul 2018 12:41:03 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
        Josef Bacik <jbacik@fb.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [Bug] block/for-next: IO hang in rq_qos_throttle
Message-ID: <20180731164102.kovmreqnymbzy5wb@destiny>
References: <CACVXFVNKAhGkievaHXDvPngw7xW5hWg_0oOSLXD1R4uaxSJs3w@mail.gmail.com>
 <83C56CD1-93E0-41E3-AF41-27C4F33851FE@fb.com>
 <20180722072804.GA955@ming.t460p>
 <20180727154741.v2ubbwerblyug43a@destiny>
 <CACVXFVOuaCT6Q04ztFubLAZUhPPXjpCdDNckoRquN1jvtb8eZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVOuaCT6Q04ztFubLAZUhPPXjpCdDNckoRquN1jvtb8eZw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jul 28, 2018 at 08:11:33PM +0800, Ming Lei wrote:
> On Fri, Jul 27, 2018 at 11:47 PM, Josef Bacik <josef@toxicpanda.com> wrote:
> > On Sun, Jul 22, 2018 at 03:28:05PM +0800, Ming Lei wrote:
> >> On Sun, Jul 22, 2018 at 02:15:38AM +0000, Josef Bacik wrote:
> >> > Yup I sent a patch for this on Thursday, sorry about that,
> >> >
> >>
> >> I just applied the patch of 'blk-rq-qos: make depth comparisons unsigned',
> >> looks the same IO hang can be triggered too.
> >
> > Ok I'm back from vacation and I'm trying to reproduce but it's not happening for
> > me.  What testing infrastructure is this?  blktests and xfstests don't have a
> > sanity/ in their test suites.  I'm wondering if there's something else about the
> > test that I'm missing.  Thanks,
> 
> As I mentioned,
> 
> The following IO hang is triggered on dbench test on xfs/usb-storage:
> 
>       dbench -t 20 -s 64
> 

Yup I just wasnt sure if there was something else about the test that was making
things different between our two setups.  I cannot reproduce with any variation.
I've tried longer dbench runs, I've put dm-delay in front of my usb stick to
artificially increase the io latency, nothing seems to trigger it for me.  Could
you run this debug patch and give me the output?  Thanks,

Josef


diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 461a9af11efe..36950ba5288d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -520,6 +520,8 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 		if (may_queue(rwb, rqw, &wait, rw))
 			break;
 
+		printk(KERN_ERR "queueing, inflight %d, limit %u\n",
+		       atomic_read(&rqw->inflight), get_limit(rwb, rw));
 		if (lock) {
 			spin_unlock_irq(lock);
 			io_schedule();
