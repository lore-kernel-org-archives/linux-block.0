Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A241C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403D4206F8
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 15:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibt3ZzYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgDCPzY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:55:24 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41331 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgDCPzY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 11:55:24 -0400
Received: by mail-qv1-f68.google.com with SMTP id t4so3801088qvz.8
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2020 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYwienmhzZwcpFtvNd9RSefcPiogX2fAxxNq9wneN/A=;
        b=ibt3ZzYn6jEr1uFt9Fmxd4uysCVOIdfYmHGyhSZVgnBIR/pi9AaC9kTdCIEoL3kfEI
         m1M3HVCiUKSl6z1hjBYbZy2HkUEoTPSNAqg2H5d/uB54PUOTygq+XKIgydbJxzGK9u4+
         eUkWHSb6TOmh7iVjaVyVEdX8JIuz0FKdd/+4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYwienmhzZwcpFtvNd9RSefcPiogX2fAxxNq9wneN/A=;
        b=SodX0qO2SxegX2B87WQmcpdlktnetSoFolTW0qF65Bd4uQFUEgUh4kqvPn0rye+kH8
         5IO0T4JFfZAbNVxjtElmtEUTJo7VApH6ZaZLg1w8S0r1TDSceVk5KBIxoDxpFP8LAgPk
         NlWyju72/MNOKVc8kB/RR7cbaRxrglcoT09Lv+bcw4KKhhWaVajVGhxoqEOww9mU8ICD
         AmVbjAvQXixHQhm4g8D/abXqZ/sBEoptNFnYDFdJ1+DRrwjrl5bEf6hURUmA+RTjMR+z
         QgRk3rTtTuVqRJwuSxonViq/C8radlYVCVFIHn63X1kf25Wek3kYCjXdNRJ0d2UOtLn0
         JK0g==
X-Gm-Message-State: AGi0PuYYFt0XCyJcJzayehj6fyWW0Ne8wnmH10emmyENXYb9zz1eqAlq
        yH3mRIel3DG6bhgntICBukvycmVwzqE=
X-Google-Smtp-Source: APiQypKkZHXVZYkwo0DemuSiZgteUCR4rWQJI+L704nGAosPDIukMQxQqYXqRj4SrgVET83RB38h+A==
X-Received: by 2002:ad4:57a6:: with SMTP id g6mr9075632qvx.182.1585929322714;
        Fri, 03 Apr 2020 08:55:22 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id c27sm6563931qkk.0.2020.04.03.08.55.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 08:55:22 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id g4so3779964qvo.12
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2020 08:55:22 -0700 (PDT)
X-Received: by 2002:a1f:e182:: with SMTP id y124mr7153752vkg.0.1585929006777;
 Fri, 03 Apr 2020 08:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200402155130.8264-1-dianders@chromium.org> <20200402085050.v2.2.I28278ef8ea27afc0ec7e597752a6d4e58c16176f@changeid>
 <20200403013356.GA6987@ming.t460p> <CAD=FV=Ub6zhVvTj79SWPUv19RDvD0gt5EjJV-FZSbYxUy_T1OA@mail.gmail.com>
In-Reply-To: <CAD=FV=Ub6zhVvTj79SWPUv19RDvD0gt5EjJV-FZSbYxUy_T1OA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Apr 2020 08:49:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vsk0SjkA+DbUwJxvO6NFcr0CO9=H1FD7okJ2PxMt5pYA@mail.gmail.com>
Message-ID: <CAD=FV=Vsk0SjkA+DbUwJxvO6NFcr0CO9=H1FD7okJ2PxMt5pYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blk-mq: Rerun dispatching in the case of budget contention
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Salman Qazi <sqazi@google.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Ajay Joshi <ajay.joshi@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Fri, Apr 3, 2020 at 8:10 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Correct that it only happens with BFQ, but whether it's a BFQ bug or
> not just depends on how you define the has_work() API.  If has_work()
> is allowed to be in-exact then it's either a blk-mq bug or a SCSI bug
> depending on how you cut it.  If has_work() must be exact then it is
> certainly a BFQ bug.  If has_work() doesn't need to be exact then it's
> not a BFQ bug.  I believe that a sane API could be defined either way.
> Either has_work() can be defined as a lightweight hint to trigger
> heavier code or it can be defined as something exact.  It's really up
> to blk-mq to say how they define it.
>
> From his response on the SCSI patch [1], it sounded like Jens was OK
> with has_work() being a lightweight hint as long as BFQ ensures that
> the queues run later.  ...but, as my investigation found, I believe
> that BFQ _does_ try to ensure that the queue is run at a later time by
> calling blk_mq_run_hw_queues().  The irony is that due to the race
> we're talking about here, blk_mq_run_hw_queues() isn't guaranteed to
> be reliable if has_work() is inexact.  :(  One way to address this is
> to make blk_mq_run_hw_queues() reliable even if has_work() is inexact.
>
> ...so Jens: care to clarify how you'd like has_work() to be defined?

Sorry to reply so quickly after my prior reply, but I might have found
an extreme corner case where we can still run into the same race even
if has_work() is exact.  This is all theoretical from code analysis.
Maybe you can poke a hole in my scenario or tell me it's so
implausible that we don't care, but it seems like it's theoretically
possible.  For this example I'll assume a budget of 1 (AKA only one
thread can get budget for a given queue):

* Threads A and B both run has_work() at the same time with the same
  "hctx".  has_work() is exact but there's no lock, so it's OK if
  Thread A and B both get back true.

* Thread B gets interrupted for a long time right after it decides
  that there is work.  Maybe its CPU gets an interrupt and the
  interrupt handler is slow.

* Thread A runs, get budget, dispatches work.

* Thread A's work finishes and budget is released.

* Thread B finally runs again and gets budget.

* Since Thread A already took care of the work and no new work has
  come in, Thread B will get NULL from dispatch_request().  I believe
  this is specifically why dispatch_request() is allowed to return
  NULL in the first place if has_work() must be exact.

* Thread B will now be holding the budget and is about to call
  put_budget(), but hasn't called it yet.

* Thread B gets interrupted for a long time (again).  Dang interrupts.

* Now Thread C (with a different "hctx" but the same queue) comes
  along and runs blk_mq_do_dispatch_sched().

* Thread C won't do anything because it can't get budget.

* Finally Thread B will run again and put the budget without kicking
  any queues.

Now we have a potential I/O stall because nobody will ever kick the
queues.


I think the above example could happen even on non-BFQ systems and I
think it would also be fixed by an approach like the one in my patch.

-Doug
