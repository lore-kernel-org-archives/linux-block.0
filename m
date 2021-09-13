Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7CDC433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 13:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4A461051
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 13:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbhIMNQK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbhIMNQI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 09:16:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB6C061574
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 06:14:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b10so14272726ejg.11
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMkvd2XitPzUDN1Wycio35V+4AIrXPwaQ/vDiDQjWK0=;
        b=KkDyl0Ifgt2aRdU6fbVozbKCUgJd/sQ+d+HyOCqH4KPJRHGcw+Ijbd628Lazz2zf13
         qfRssLX/YJgrq2MdmqVIbqdO5W7n8DZIy//VSqNG96Dyas/9Xx+m/1jqNvflyr0zJ3ai
         KlRQWR/v4kOWDOeP7VCI2n+5QcknY3SRD1mHmXWR0+I+ES+jW0raqwthvhg4bjKktVnW
         aXaf+bMgQq52xezeLd3KA5ugo4URLNlBOYN66C91lBa9m5i5i0GcnHX2zxZevyg3wtEi
         ZH0QG2au97VLX716H+2FpPBIQ3LKAK2X++0gDjVwXny2BdB6n6K4KnFYcc5TXOplqJ7F
         ohAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMkvd2XitPzUDN1Wycio35V+4AIrXPwaQ/vDiDQjWK0=;
        b=dE07a3+dEEszRtgcNx/b6r9+sfdpcaWbcjHtt1RznJuTDRvEqp0Uz2hGwCDaI18vLs
         mKFepk0N4HMSrT194rdWWWgCqwx7TKO5Qz1g5LRECrzf/Ai3Shi9Fu04lHq/LCY5JQqS
         A3bBFLok7F3GexhVEc/UxfdKq0G/E+sVf8L8zdcbe1KQPyXSuAHDqtsUz/SwpH+G5Tv5
         2QkbjNr9fWCl8Y1cQgzvK97u3S2+Q0bWdR7lxxOb4U6Vd1K2GgIJh+p9Fy3xVfgZQU3v
         c7cAjt6oLaiNorQM8vKFaDdAf0cnDGR0fszTtOySlEzyMsWMkMs2IB3g/tEpAIJMBAq5
         /q0A==
X-Gm-Message-State: AOAM533JcD7sccAyZ3edtUf1u7SrkiBGsm+6r54VmEeA24RMD4u3VJ//
        ffD8X1mr01wK1S/5gOxwooOE0Ysv24qXRzwZ5WFfpf755RTU
X-Google-Smtp-Source: ABdhPJwHOmQse5JaEJZ9pdSms9x3cPQBvPXsPcnevtEzlANE5PG+3T95s3z+9oFoZWNK01UJ3aS4eVhx326VZNRqn+M=
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr12677672ejc.72.1631538888667;
 Mon, 13 Sep 2021 06:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210913112557.191-1-xieyongji@bytedance.com> <20210913112557.191-3-xieyongji@bytedance.com>
 <YT9FVrXcaUdaXlu6@infradead.org>
In-Reply-To: <YT9FVrXcaUdaXlu6@infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 13 Sep 2021 21:14:36 +0800
Message-ID: <CACycT3uY0BA1ax_fMpUq9rtbboDdAcTMLZeMmkLNBQMrgHAVig@mail.gmail.com>
Subject: Re: [PATCH 2/3] loop: Use invalidate_gendisk() helper to invalidate gendisk
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 8:35 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Sep 13, 2021 at 07:25:56PM +0800, Xie Yongji wrote:
> > Use invalidate_gendisk() helper to simplify the code for gendisk
> > invalidation.
>
> bdev can't be null here so this looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Can you also add a cleanup patch to remove the bdev checks and the
> entire bdev variable in __loop_clr_fd?

Sure.

Thanks,
Yongji
