Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7167DC43215
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 12:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B50220748
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 12:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfccVARt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfKRMt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:49:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33801 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfKRMt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 07:49:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id e6so19347968wrw.1
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 04:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzafYSZxnPK6IARPnsA3hMeydxdZ+vWMbZqlbTbu264=;
        b=JfccVARt1sSwpJGTtDR8EMG4H4J/sFy2OH3nynkFuMHRxl+B/4tBnlPH1t/AFzSMXe
         Sen39S4GOvg2QYLvVw2MyTOp2DZ1puxe+p6E5NcZNP1Ob/e2t7LTdJtFrgcrhbFPheFI
         UC2IoNp6MzlGmH26HSM6eVNlbhZN7U86J+KM1iuD3TohtdP3kCBiKL77SGdq7aAFtAjM
         w26F5x2v+4ZSOA0W9UtRFYezkUk2p5flSGSEsNPd5iEY4f3ifhx4MwkWwwG9hLUOgJy9
         soFmSksPFEZDHxxqyXtqfUstoHODD+ThInY49iLReF5J8+0AiJXN0JYlshdrqjl7bMze
         JFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzafYSZxnPK6IARPnsA3hMeydxdZ+vWMbZqlbTbu264=;
        b=OGxlCFNsGu+ZmGi0PORy5R4nNzPqIIjZto68ntMw9YAI+gvXtRAcA+G71QMusDJz4q
         4V64FzcewUssdb9stm/tTVDWCZrkNuH5WtKO18PNoubbGPlab72hxkOSDs8NQg1gPAB8
         h9DKM4DwcCXPBcWduZcBOg655Cw6D8VcMRWuJotZZDc393DdmOVM+twem/YFL8x2OHJY
         3aFmsdG6S4G9BTcUpjo2i1nnjhh+cE4E0ZZFtY+CglS4EEWQi1jX2JMoguNWhBSS1DGw
         aL1esqitxJRDt21VL1Si8WufHK0/0/5lL4z7wOHNA3R8iBjV/LW01Spy98UQf39aDJ2J
         j67Q==
X-Gm-Message-State: APjAAAVmudZmqMTrATDWyTMCA0OKn8HJH0JNjofXpX1c4kCP+RjcQIoR
        DNn0EeTOyoPlV0yYhzTgC6bjgblxdkG+ZWhMFKa/JkMB
X-Google-Smtp-Source: APXvYqyPEWCBhJ6YujPNRNnxWClv1u1FteWv8iwzp4+o+/LP1jXVeMYlfUwe8Y64NjPffy6VraPunQNj4d7JF1MKos8=
X-Received: by 2002:adf:979a:: with SMTP id s26mr30720656wrb.92.1574081394736;
 Mon, 18 Nov 2019 04:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20191118110122.50070-1-bigeasy@linutronix.de>
In-Reply-To: <20191118110122.50070-1-bigeasy@linutronix.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 18 Nov 2019 20:49:43 +0800
Message-ID: <CACVXFVO6BA1HDUL=0XZzPVDDg0YYTyKwC1ajcXQ0OjF3VWpuHg@mail.gmail.com>
Subject: Re: [PATCH] block: Don't disable interrupts in trigger_softirq()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 18, 2019 at 7:03 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> trigger_softirq() is always invoked as a SMP-function call which is
> always invoked with disables interrupts.
>
> Don't disable interrupt in trigger_softirq() because interrupts are
> already disabled.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  block/blk-softirq.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/block/blk-softirq.c b/block/blk-softirq.c
> index 457d9ba3eb204..6e7ec87d49faa 100644
> --- a/block/blk-softirq.c
> +++ b/block/blk-softirq.c
> @@ -42,17 +42,13 @@ static __latent_entropy void blk_done_softirq(struct softirq_action *h)
>  static void trigger_softirq(void *data)
>  {
>         struct request *rq = data;
> -       unsigned long flags;
>         struct list_head *list;
>
> -       local_irq_save(flags);
>         list = this_cpu_ptr(&blk_cpu_done);
>         list_add_tail(&rq->ipi_list, list);
>
>         if (list->next == &rq->ipi_list)
>                 raise_softirq_irqoff(BLOCK_SOFTIRQ);
> -
> -       local_irq_restore(flags);
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
