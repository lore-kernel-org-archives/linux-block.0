Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1313C433E0
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 05:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60A522AAA
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 05:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgLUFjh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgLUFjg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Dec 2020 00:39:36 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62487C0613D3;
        Sun, 20 Dec 2020 21:38:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z21so5696415pgj.4;
        Sun, 20 Dec 2020 21:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:cc:subject:message-id:mime-version:content-disposition;
        bh=Ua2/mrhX7ym2QXGBEungLOzE+u2b0KzmVzT/pkdbpzo=;
        b=uBQONVucB+rIvkwClOZ8NcgHT8yprJdrlfDyYY49kJO/4UfCAQD/ALefIv2FwSzsPh
         hAHAd5U8PI2xBQQfyfdh1X0/qjxGyp1iSIdhzhEbg60xZ6yh9L1WC/rAHUevfskvLWcv
         DYkVkrWlHs5c3OJ79deH2dQTDI8XmVqsm2KmJ8+94RPOthyG0q/mSdMo/rPA/MyHlssA
         5irNWwCv/u4hR52Y+317ZFLjcTWSu2vbIrEqWMQ4XNvok6O020jABgcvJvpjoYCSkhzw
         ERYRAHvrLSwF8rHcdn+V7DbsxFWhxm6FMNl6sSStXqZA+Ycrj3/ZOwmPmAuTaBbnXWEB
         1bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ua2/mrhX7ym2QXGBEungLOzE+u2b0KzmVzT/pkdbpzo=;
        b=CFHfGHc75wIKwMx8MkTjtbw0JsT7vUXUQMKpxq4EaJQSIgQpw6xyV6Aro+w2KKYpxQ
         ywDw76bRO0PUSoFhVDVJ811qJs4hzUF0qdYJory1Y98R0IghNNIyCc8GG6PodX4KaEtb
         57DKzxypNwN7UZ9B+RJHKM5Y3hrVh5zfhxmfSj52sWYkodQiqIAWtWpcfhtaTOAuXmcD
         gnXz7Q7ge1Forp8lEayeKUEUns5T/X7zos0Dxe0+1avGWrVQBlHDk2Mb6wag37W1efZ3
         MulyAF3nw/cdttInIFcXieqYyMSHf1w+c2nZCsEA+jGGzWkzjPeWS5enfOIDGl/eBJNt
         t/QA==
X-Gm-Message-State: AOAM533YPWZpkkE7RyBTiJlOMRXCNwlz6CnIGzoFjW7zwKzwAHpQk8MS
        0RGYnQJgBgYRED61WoBYs/5KF4ynI9UbIw==
X-Google-Smtp-Source: ABdhPJzgQswpROGP7j52LG+e4qEzK3ZKxIdFWseQ6PpDkbHVyLu7hzqPW3nmwO5DqrNMhq9K9iDaqQ==
X-Received: by 2002:a63:924f:: with SMTP id s15mr12434339pgn.360.1608497287041;
        Sun, 20 Dec 2020 12:48:07 -0800 (PST)
Received: from localhost ([103.248.31.152])
        by smtp.gmail.com with ESMTPSA id 11sm1361643pgz.22.2020.12.20.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 12:48:06 -0800 (PST)
Date:   Mon, 21 Dec 2020 02:17:53 +0530
From:   'Amey Narkhede' <ameynarkhede03@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Fwd: Re: [PATCH] block: aoe: replace use of __constant_htons to htons
Message-ID: <20201220204753.zduzo6l6bqojlbnd@archlinux>
MIME-Version: 1.0
Content-Type: message/rfc822
Content-Disposition: inline
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Date: Mon, 21 Dec 2020 01:50:23 +0530
From: 'Amey Narkhede' <ameynarkhede03@gmail.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] block: aoe: replace use of __constant_htons to htons
Message-ID: <20201220202019.j7x64yahapgilr7u@archlinux>
References: <20201220164625.94105-1-ameynarkhede03@gmail.com>
 <d708db73308747feb0484287a09c443e@AcuMS.aculab.com>
Content-Disposition: inline
In-Reply-To: <d708db73308747feb0484287a09c443e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

On 20/12/20 07:35PM, David Laight wrote:
> From: Amey Narkhede
> > Sent: 20 December 2020 16:46
> >
> > The macro htons expands to __swab16 which has special
> > case for constants in little endian case. In big
> > endian case both __constant_htons and htons macros
> > expand to the same code. So, replace __constant_htons
> > with htons to get rid of the definition of __constant_htons
> > completely.
> >
> ...
> >  static struct packet_type aoe_pt __read_mostly = {
> > -	.type = __constant_htons(ETH_P_AOE),
> > +	.type = htons(ETH_P_AOE),
> >  	.func = aoenet_rcv,
>
> Does this cause grief if someone is doing a COMPILE_TEST on LE?
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
I did COMPILE_TEST on my x86_64 machine and it compiled
without any problems.
I assume that was the point or am I missing
something? I'm a beginner contributor so please
let me know if there any mistakes.

Amey
