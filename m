Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2279C63777
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 00:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AACF722265
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 00:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGbFosuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKNAtZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKNAtZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 19:49:25 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4DAC0613D1;
        Fri, 13 Nov 2020 16:49:25 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x15so7732169pfm.9;
        Fri, 13 Nov 2020 16:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8fCnEYw1oV7LYGWU3hhuAXtv4iuMCupq08ToJfobOTs=;
        b=vGbFosuzMtNJCB5p8qKkpMyY9vviFRm6epxalqJiINlvJa/r99W2WK4+/lULIgTp8k
         LnljURBVZSnkIsm0XCI+JNX4M4sKRb0tjEfsRX5qVkBVxrDOCKoGUwTKx6S6DEgvQVvf
         tTNsFGzD3FSQ+fMJoz80bUCbZPQvC6pa5ofUIkaNZ6Zc5FDA6RF3QSwJZY9dnGrZaWuT
         LWvI28OD+Ham0txe5x9AqCJXgNNIdtAjurhDj/XBNPsaJP4O6GGlJ74bD2fQTDb8OffF
         FzP+dgQ7MfrDvP+FH68if5PhpIDNaSAHGfH5g0NDuJ1akIYM9cmeyMjNr8v34VIqDs1u
         nEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fCnEYw1oV7LYGWU3hhuAXtv4iuMCupq08ToJfobOTs=;
        b=D68IgdCcYCCRD3iNW0TnJYrp0lsmI6q4TkAprMVML/i//V/2OmZkTGjw/bC3VUo+cV
         LmRthfuBWOs+zwHc28wOygzokXXK3fQjlhajb1mABPKR4Fqro/bF4Zr2CVMOQ026aWec
         eDicQ0F6x0R6fncilLEB6lc5HMLKsimEELx+vI546nCbuLcGgfWet5+QIRB6czU0uiG+
         rTvieWwaV0eMXEiOS7yl1/R9mWSl+RfzDifOWtB4mseNod1hQ8vcvwu+IYjpGmMhxzsl
         i5SNaH5OgSBDnch0J9idux9nCx3VwWvm50+nj6K7QKN/pLnJX75LTyxaMTPcOdxMmIeR
         6jmw==
X-Gm-Message-State: AOAM530X7zmb1CRwBJ78aWI+njBaIY4ZkGh2HvbyFZahX1T6hzdB2btQ
        hGX5FnCw3rZrguUJTFxzR4s=
X-Google-Smtp-Source: ABdhPJw5ODUOSdKxFPuZb9IfCQekD2tk6ovIv289KAqVk4cLb5qLtf1/Vj7JmmTWduVRkrCgIupdjA==
X-Received: by 2002:a17:90a:8a:: with SMTP id a10mr5511232pja.39.1605314964587;
        Fri, 13 Nov 2020 16:49:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id z8sm10563959pfn.181.2020.11.13.16.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 16:49:23 -0800 (PST)
Date:   Sat, 14 Nov 2020 09:49:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, ngupta@vflare.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] zram: break the strict dependency from lzo
Message-ID: <20201114004921.GA1875489@google.com>
References: <20201028115921.848-1-rsalvaterra@gmail.com>
 <20201028185927.GB128655@google.com>
 <20201103212847.GA1631979@google.com>
 <CALjTZvZpjgSqT8fRF90yooTV6S5eoz+PBJn7BfesT=y2uW8nmA@mail.gmail.com>
 <20201104204152.GB3544305@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104204152.GB3544305@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (20/11/04 12:41), Minchan Kim wrote:
> On Wed, Nov 04, 2020 at 02:12:35PM +0000, Rui Salvaterra wrote:
> > Hi, Minchan,
> > 
> > On Tue, 3 Nov 2020 at 21:29, Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > Can't we just provide choice/endchoice in Kconfig to select default
> > > comp algorithm from admin?
> > 
> > I'm fine with whatever you guys decide, just let me know what works
> > best for everyone.
> 
> Thanks. Sergey, if you don't mined, I'd like to approach more explict
> way to select default compressor algorithm in Kconfig.
> 
> Do you have any suggestion?

No objections. Some people tend to dislike new Kconfig options,
but we probably can live with that.

	-ss
