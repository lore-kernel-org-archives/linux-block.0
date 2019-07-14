Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E1C73C66
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 04:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583DD20644
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 04:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bncUZlj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfGNEAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 00:00:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42171 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfGNEAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 00:00:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so9301923qkm.9;
        Sat, 13 Jul 2019 21:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C+RV+0t2aWNWIaDr884rCShvl4d1XlrRv+L4Pe0LIdg=;
        b=bncUZlj2UwsnM4lg7q3q6DAcLq3rf5IA9Zt0r1AOGUzbgCRxhk/X5M/GraYxyZ3vY3
         el+uVYCr42dlw2/qERTjY/gMAzybe3fRYSjvGLRh2EEPX65QiuNebhnyUlfJ0KZGeRYf
         AkNrFquwBx2vyB6SGNxS5/eXGxLKh0wRHSNCHWF3JdKCTR7TegsDhCVt9Abq9AOpVUVa
         hgkU6TJRgguqEm1hV1DYe051PZBZ3zyizFHPkHXdJqElTYFoz6koPOal65IuZj6vuwx1
         uTO2AI9pIhTpuSNpwFrKwO0/Txb/GXXhEdk1aq9dklR+Rh8M5zAC2P4LII464cNMSi6v
         0bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C+RV+0t2aWNWIaDr884rCShvl4d1XlrRv+L4Pe0LIdg=;
        b=NvWxGPHMe0XmaSQlXK3AtbFgkmUPlwR8IBwTFtgf018qJQxHcJQlXCxIWJDOXP2tU8
         7aSWhkGd8a4WO18rbyMLnk3j64vMzOYsbebKPm9yv9iUJjY71Ek9ZSUqOhMGayiSGjn0
         SKevMm5iNZN5wuoK9/n85is68PFsp/QFBPoLFJtqaiMuzhEjGR2GhCz6YeNaViQgOFx+
         OrITBqiqeOeJ4A/BKXmDwnh3T3e1gyrFJI2VH2vod19MYe9hDp4duU0SFhuPEhaJ+Uhg
         iWzmWKer6caDJEouH4KPyuJvbSK0jc2nWKM5S3ub5iqsnTgvoNXFrGbIrJ4W3oY8uvxr
         bgUw==
X-Gm-Message-State: APjAAAV4V8+/WQJNJxUk0f8K/7aW8IJ1JCCWM5gPvfsnXSYt2nJY5FDI
        Fr5GTp8i5Et1BHqS/3NthyEhkMCnnkY=
X-Google-Smtp-Source: APXvYqwR3zBitPfMP6j5VloXIL1iUifK5UJMmS24W2MbNT+arbkJg1XSP7j7UhqSmrUhabuH5MMFPw==
X-Received: by 2002:a05:620a:1097:: with SMTP id g23mr11879799qkk.185.1563076847251;
        Sat, 13 Jul 2019 21:00:47 -0700 (PDT)
Received: from continental ([191.35.237.35])
        by smtp.gmail.com with ESMTPSA id e8sm5792816qkn.95.2019.07.13.21.00.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 21:00:46 -0700 (PDT)
Date:   Sun, 14 Jul 2019 01:01:18 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: elevator.c: Check elevator kernel argument again
Message-ID: <20190714040118.GA19237@continental>
References: <20190713035221.31508-1-marcos.souza.org@gmail.com>
 <75c5681a-389f-cfaf-7f3f-31a2daec9da4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75c5681a-389f-cfaf-7f3f-31a2daec9da4@kernel.dk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 13, 2019 at 03:53:28PM -0600, Jens Axboe wrote:
> On 7/12/19 9:52 PM, Marcos Paulo de Souza wrote:
> > Since the inclusion of blk-mq, elevator= kernel argument was not being
> > considered anymore, making it impossible to specify a specific elevator
> > at boot time as it was used before.
> > 
> > This is done by checking chosen_elevator global variable, which is
> > populated once elevator= kernel argument is passed. Without this patch,
> > mq-deadline is the only elevator that is can be used at boot time.
> > 
> > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > ---
> > 
> >   I found this issue while inspecting why noop scheduler was gone, and
> >   so I found that was now impossible to use a scheduler different from
> >   mq-deadeline.
> > 
> >   Am I missing something? Is this a desirable behavior?
> 
> Just google, I'm sure 2-3 discussions on this topic will come up.
> 
> tldr is that the original parameter was a mistake and doesn't work at
> all for multiple devices. Today it's even worse, as we have device
> types that won't even work properly with any scheduler, liked the
> zoned devices. The parameter was never enabled for blk-mq because of
> that, and hence died when the legacy IO path was scrapped. It's not
> coming back.

Thanks Jens. So it makes sense to remove all leftover code of elevator argument with
some dead documentation about it, avoiding confusion about it in the future
again. I will send some patches tomorrow.

> 
> -- 
> Jens Axboe
> 
