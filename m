Return-Path: <SRS0=2qaK=TK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B33C04A6B
	for <linux-block@archiver.kernel.org>; Fri, 10 May 2019 06:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4422217D6
	for <linux-block@archiver.kernel.org>; Fri, 10 May 2019 06:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="itdBqCoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEJG3M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 May 2019 02:29:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39235 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfEJG3I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 May 2019 02:29:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so3817215wrl.6
        for <linux-block@vger.kernel.org>; Thu, 09 May 2019 23:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fXoP+f6QC17xzzktncyb1JK9XYTxg2n/Jos+hr8hflY=;
        b=itdBqCoK1ajm7GqCEPGxrB4iEYXPleHImyaPAPsZtPsRwoWDRxpDa4NAhAIe/YjORU
         oqeRSlllHu/LFz4qLzNU/BtIHxQjE+c0XLCAsitWX5oumvzfiN1VN8S2uYdJdes6QkyI
         JMYBg7Ls0TpcMqP8QlutVJ1FpirHfsqDQd/dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXoP+f6QC17xzzktncyb1JK9XYTxg2n/Jos+hr8hflY=;
        b=jtuqat0V58sXk8lejgc7sHrcakdG/HdCkQGJNorO7tfQal8W3ZmQdZYd84dlGf/Jbc
         Be2QeghoAk9qX4AUp9/NwgO+Fo60jHm3ArWY3sbmf2bT+/+PR6mhYg+9X2gKHaC5lCum
         faaV3lTyA/pE5y3tdX33FPjR9BnXdqrfKQWVXM+D5fv9wQniwMazflq77yIpWP2+68Nb
         wnDMr3p9Z1grBe8ViV7jDG/wWCB3BRJ+Ef3LFmzLdQkceFXHobyN1m88gZi7ne8us029
         igGgMHK3L5cRW9nQybZseVRtibt8NjDzQJLAYDI0edDz1kRUCokMO+0TQ6995oWD3EOP
         kBfg==
X-Gm-Message-State: APjAAAX/9Tu5WPh4WN1RCB3upViIPzUHBdLL7in0h4l/s+H2g81nN/a6
        K5AxsJf3crMPGlpKV4D8zP0LGA==
X-Google-Smtp-Source: APXvYqyD/Ihm3RfEZqSrIUKTRP3K/yqwgsWS6ZBxR1ydlc2vrnLSWVZMYQ86kUm3VXj7Ytc6N2PrUQ==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr6398927wrj.262.1557469746571;
        Thu, 09 May 2019 23:29:06 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id n17sm3750263wrw.77.2019.05.09.23.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 23:29:05 -0700 (PDT)
Date:   Fri, 10 May 2019 08:27:27 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] sbitmap: fix improper use of smp_mb__before_atomic()
Message-ID: <20190510062727.GA4607@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-4-git-send-email-andrea.parri@amarulasolutions.com>
 <20190510034101.GC27944@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510034101.GC27944@ming.t460p>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Fri, May 10, 2019 at 11:41:02AM +0800, Ming Lei wrote:
> On Mon, Apr 29, 2019 at 10:14:59PM +0200, Andrea Parri wrote:
> > This barrier only applies to the read-modify-write operations; in
> > particular, it does not apply to the atomic_set() primitive.
> > 
> > Replace the barrier with an smp_mb().
> > 
> > Fixes: 6c0ca7ae292ad ("sbitmap: fix wakeup hang after sbq resize")
> > Cc: stable@vger.kernel.org
> > Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > Reported-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: linux-block@vger.kernel.org
> > ---
> >  lib/sbitmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> > index 155fe38756ecf..4a7fc4915dfc6 100644
> > --- a/lib/sbitmap.c
> > +++ b/lib/sbitmap.c
> > @@ -435,7 +435,7 @@ static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
> >  		 * to ensure that the batch size is updated before the wait
> >  		 * counts.
> >  		 */
> > -		smp_mb__before_atomic();
> > +		smp_mb();
> >  		for (i = 0; i < SBQ_WAIT_QUEUES; i++)
> >  			atomic_set(&sbq->ws[i].wait_cnt, 1);
> >  	}
> > -- 
> > 2.7.4
> > 
> 
> sbitmap_queue_update_wake_batch() won't be called in fast path, and
> the fix is correct too, so:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thank you for the review(s),

  Andrea


> thanks,
> Ming
