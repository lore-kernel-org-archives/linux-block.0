Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB0C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 17:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2AE21479
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 17:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="dNSImmto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfGARfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:35:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43154 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfGARfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 13:35:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so6899590pfg.10
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GjbFO6Zi6jfRe/bkXkrP+9GcrEaqmKIfWUxraeXKXoE=;
        b=dNSImmtoyKvCh7FQUaeZ3H+IlOUassJYpIT4IOBzRA/umVqcBU+oJib3Y4Tl9gz8OO
         IeC82sEYlTh8MQW4gFDDVlu1TUmSEWj9SxFtgDS/zlesu6iMhWD1c+tytHcwKPoQjXUD
         bEysU3uxLQXV7tO2NZogs4GoPdJZ13MhQqGTQDa92yYqS1qt+Nu5QJRLcVeQPHr0rEED
         EkSkPyT8Y7qGSnA9Jzcp36zaYzcXo82TuoCsleDiTHzU/XpKq1nqUqvFRFLbsehZRDWu
         giulAdHxLjgMf+YqikwbTd+sFIgLr1y6si4OzEGSSR+CEYVRGPYJHv7sO+9bW6zPAnBz
         rdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjbFO6Zi6jfRe/bkXkrP+9GcrEaqmKIfWUxraeXKXoE=;
        b=YOahikuuuTnghuavzrcTQFiXaj8X/vrdKdcUz4VODnNILz87igfyDQdL+oazYJEgwE
         IVOxEiKygOma7YvYGWHCl9jAXwK8S1/0KhNCRPK3AbZOchBVX8Wsql05uiNQtpn9n0B9
         gnE3rUD004B2KWPX1AEgj0X0Rb16oDU/Rt4RjRaej4+OX2qXsZCjsNmIJyLDiDPDmb0C
         4rCif5CyuxnhEF10MoQ2dtsJ3yWcWeFCozQVODQlQBn2JpRw7Mc4zMc3Tq1sP04cQuFu
         miWOdQJdze8ViZNrV2eQx7asLoef0lXhpWuBZMUQcT7AhRpygTyURmKZ+9ZDZ+6oS8H9
         o8nw==
X-Gm-Message-State: APjAAAXU4Hu2nTxKFBqmjJv53hroPySZzzK3/sGHQU9Ix0EyxTGo0HbI
        4xryp4QxEc4wnPTly0Bzw4RZgQ==
X-Google-Smtp-Source: APXvYqxtxAAgSqS41C5xcQoSqXTmvzLidlYL25xNGfj2neKpWdb+qxRMeYdqx/zu68hrSA6v5Us1Zw==
X-Received: by 2002:a17:90a:8d09:: with SMTP id c9mr428334pjo.131.1562002535372;
        Mon, 01 Jul 2019 10:35:35 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:c56d])
        by smtp.gmail.com with ESMTPSA id i126sm12622656pfb.32.2019.07.01.10.35.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 10:35:34 -0700 (PDT)
Date:   Mon, 1 Jul 2019 10:35:34 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sbitmap: Replace cmpxchg with xchg
Message-ID: <20190701173534.GA10076@vader>
References: <722e1d561f0a49dc464d3a2b1be4c077f7502726.1558625912.git.asml.silence@gmail.com>
 <0979d23f-bc31-b653-51d0-867dd52bf7ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0979d23f-bc31-b653-51d0-867dd52bf7ee@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 29, 2019 at 08:42:23AM -0700, Pavel Begunkov wrote:
> Ping?
> 
> On 23/05/2019 08:39, Pavel Begunkov (Silence) wrote:
> > From: Pavel Begunkov <asml.silence@gmail.com>
> > 
> > cmpxchg() with an immediate value could be replaced with less expensive
> > xchg(). The same true if new value don't _depend_ on the old one.
> > 
> > In the second block, atomic_cmpxchg() return value isn't checked, so
> > after atomic_cmpxchg() ->  atomic_xchg() conversion it could be replaced
> > with atomic_set(). Comparison with atomic_read() in the second chunk was
> > left as an optimisation (if that was the initial intention).
> > 
> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > ---
> >  lib/sbitmap.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> > index 155fe38756ec..7d7e0e278523 100644
> > --- a/lib/sbitmap.c
> > +++ b/lib/sbitmap.c
> > @@ -37,9 +37,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
> >  	/*
> >  	 * First get a stable cleared mask, setting the old mask to 0.
> >  	 */
> > -	do {
> > -		mask = sb->map[index].cleared;
> > -	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
> > +	mask = xchg(&sb->map[index].cleared, 0);

This hunk is clearly correct.

> >  	/*
> >  	 * Now clear the masked bits in our free word
> > @@ -527,10 +525,8 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
> >  		struct sbq_wait_state *ws = &sbq->ws[wake_index];
> >  
> >  		if (waitqueue_active(&ws->wait)) {
> > -			int o = atomic_read(&sbq->wake_index);
> > -
> > -			if (wake_index != o)
> > -				atomic_cmpxchg(&sbq->wake_index, o, wake_index);
> > +			if (wake_index != atomic_read(&sbq->wake_index))
> > +				atomic_set(&sbq->wake_index, wake_index);

This hunk used to imply a memory barrier and no longer does. I don't
think that's a problem, though.

Reviewed-by: Omar Sandoval <osandov@fb.com>
