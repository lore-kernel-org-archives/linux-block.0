Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481B8C433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 23:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12408611AF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 23:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbhIIXBm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhIIXBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 19:01:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DCBC061574
        for <linux-block@vger.kernel.org>; Thu,  9 Sep 2021 16:00:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d6so4784245wrc.11
        for <linux-block@vger.kernel.org>; Thu, 09 Sep 2021 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RqlFooijnqgBWG+n4PheUUBY3UoPu5druSxjQVNP4pc=;
        b=hOMBnlDSEDR7iy5R+ZtkYVvrSGdlNfwJFf7ywDphMox/DSdk7yBZ3TZqL8p4+ehChs
         29wgkR4PCK6M+7KqMBIiYHjsEiekpQw4QJDtuRxrMq2o2o9GZTK7aAvHeOuwCXNhHqYn
         e/lu5rCffUglGlQJwapgXHo/qpQOXfFNMMpHbclyie5P4NHoIM9L8l0TREOligfEq/Gf
         aGuCG+zkTaQXe3wrBtnQmWoDGz/dsYKIXzqkyGlyldalsICpY9vPu+2v70swutX2q64I
         PA1ySp+r0lDBNT6Dmnjp7hj4Fu9auQPtpOpk4YMldONK2MfxbY3zFT/xMIQhZdWLdo1F
         W1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RqlFooijnqgBWG+n4PheUUBY3UoPu5druSxjQVNP4pc=;
        b=6mJGP4VI0WIMMO1xrX2cUNuh7miN0gQC9KGxlqXCiW8u40EKbqngayS0cyk4Tkyazf
         b+0ZDBv/j8PipPBKo8EztghfqTdmLg23sGg4EzDht9g/q/PM1peT53XvsQszvhpUbQ8s
         4Ameu+9gc31qZNitDzqBcBVufDIpW7J2l0NYveYFrXt7LvORI6dnhA1IICzNyVHMiZFe
         /Ovi3oD2JajQCuGXWY5vMBzb4paGgOm+a7yQMQ8zkJvY+Dc+blnYe3mpgaekI21aaFCg
         I7TGJqN0h8MMBkB+LkIBqY++EXAWCyOg4fk6zdjfUlQic8RFnq4zBnDV1A+yQSptTtnV
         oyOA==
X-Gm-Message-State: AOAM530fvlt+K1XP9VqnPF5pe6GzTVlRBootrL/oeX93pPxD4TrmhyiQ
        zVBsyvtVF+F365ywtBCA6ogccw==
X-Google-Smtp-Source: ABdhPJxWt4e+LY4UUMeuzojh6FRWGxJqFBaTYQ3llxyKt+xTVT0/VVt/URICnQniJcCgsPMT0aDKeA==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr6265555wrw.174.1631228430980;
        Thu, 09 Sep 2021 16:00:30 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id x9sm2593289wmi.30.2021.09.09.16.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:00:30 -0700 (PDT)
Date:   Fri, 10 Sep 2021 00:00:28 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     hch@infradead.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        lumip@lumip.de, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YTqSDICXcjdrC+vt@equinox>
References: <YTcILRYw/AKen0X4@infradead.org>
 <20210909001721.2030-1-phil@philpotter.co.uk>
 <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 08, 2021 at 05:42:30PM -0700, Randy Dunlap wrote:
> Documentation/process/coding-style.rst says:
> 
>   The preferred limit on the length of a single line is 80 columns.
> 
> checkpatch only checks lines > 100 columns since that is OK in a few
> cases, like a long quoted string.
> 
> So try to limit line lengths to 80 columns unless there is some
> other reason not to do that.
> 

Dear Randy,

Thank you for clarifying this, appreciate it. Will try and bear it in
mind in future :-)

Regards,
Phil
