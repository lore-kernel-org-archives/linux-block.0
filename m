Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC2EECE58D
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 11:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239CF21848
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 11:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Xmf0bmzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfJILkV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:40:21 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:34836 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfJILkV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Oct 2019 07:40:21 -0400
Received: by mail-pf1-f178.google.com with SMTP id 205so1468627pfw.2
        for <linux-block@vger.kernel.org>; Wed, 09 Oct 2019 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H9yWdcwqF3YgrsQop+U9uc3knP7XPJuVlXRHJT0dCLg=;
        b=Xmf0bmzlz5T1V530xRn2KRJYAiETb9q/k2xr4n2LYdg8FO7t/ydgNNB+12TC2pxsey
         MPrQlSH97am3t/ZeWws0eq8vmLr0MPIOk6+/BYx08JBi1yEq8s1EhkBG3taDkmdfcraQ
         nLG4B+UZr37QM+DFCxCcYBgpyeCv4PiT5As9E7odEQ/xyO37Lk1PTKCSpzNyBA85gRrF
         y4tuV1WEzw1a2eVT0zimusaPX21c4ZVsPTcEQ7Io/Tztdrg33XuL7IK2ZjZQ+IOY1wbt
         MStC/tnYe60+qIGzPGiNWsBL+PnBQyO/iHhu9/Ea31F4eWfeIzxqynRkxmeq40UwqBUA
         mEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H9yWdcwqF3YgrsQop+U9uc3knP7XPJuVlXRHJT0dCLg=;
        b=Gs3xaB0qC7hx62GwVicFzrukT8KAyhPvk1yPqzWIxueusexJkOmbuvd8YHFC6hxVHV
         hpvdSRfsz3IgLLgvD3TLjsgH3c4iuOHE6al0H8psWDpKiJr/H/J32lNDOTUSWVTOJe3h
         QWOVcqBoHj8JSnQYbx3/jA3LcTqklEhyYZKg7/b5ZrFeCwjE0IwOU+vCZbBZSHrahKeX
         IZiFCQAaC30CYypdTtW4PUFIQR3DSZAig0+OWGuAJtKsfvNrzYMFeiIlIFbP42G9CrNM
         sUhxSrYrExCKC4B48UtESd53pD0TI2WFrr9DUARl7sarwoKQx7mVF/znH9Tj/0/veVh8
         Gv0A==
X-Gm-Message-State: APjAAAViYjjcQOTOMWtQqF7Cp7gH0XyKSb0ZN2I24FvMvpto4VrOvZlL
        e9RKaQbWnk7L5S4HUsiDxLTPlw==
X-Google-Smtp-Source: APXvYqwwif6vv3CnXRINAWQr8KuQbgOV6wOKAyRb1G4QLjuL9Qq2VrMF/LWSP6+mzfmh3pjemoJCVA==
X-Received: by 2002:a62:b616:: with SMTP id j22mr3216943pff.55.1570621219307;
        Wed, 09 Oct 2019 04:40:19 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x19sm3643935pgc.59.2019.10.09.04.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 04:40:18 -0700 (PDT)
Subject: Re: liburing 0.2 release?
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>
References: <20191009083406.GA4327@stefanha-x1.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <414ccf6c-8591-a82b-9ae7-9b0f270d18e8@kernel.dk>
Date:   Wed, 9 Oct 2019 05:40:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009083406.GA4327@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/9/19 2:34 AM, Stefan Hajnoczi wrote:
> Hi Jens,
> I would like to add a liburing package to Fedora.  The liburing 0.1
> release was in January and there have been many changes since then.  Is
> now a good time for a 0.2 release?

I've been thinking the same. I'll need to go over the 0.1..0.2 additions
and ensure I'm happy with all of it (before it's set in stone), then we
can tag 0.2.

Let's aim for a 0.2 next week at the latest.

-- 
Jens Axboe

