Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA822C433E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B8E20874
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 15:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="b78fpOxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410156AbgJPPbc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410157AbgJPPb3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 11:31:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24AC0613D4
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2020 08:31:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n9so1654539pgf.9
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2020 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zS15kjcQSFfjJkxGcL/3p1Ft+qS0KeG9wSgM95IEois=;
        b=b78fpOxWTlUgefWD0/2EXS6wg+MwU/PxFE8bTRumus+Y48AXJEgURgFkSGWvbsKOwT
         VPq959RsYhvTZbJvTEmbonWjcwn5BP+PT1JlNQ3b6ab09ZZHcW0ILYb3w56sryfeCoLQ
         bPCQhP4OAWmnr51JYXao2nnaPyL/f4A+rOqgGfrD1bPA0bqVPCj3RaAyWZNasIXAaVoM
         JQufOGtsmTY82d1YX2pFS3hjWCgq8JyuClqODmMmeV2Tt47D2J7ck7ZSFEfr3pfkEnRi
         l1Tamv+qAce0vst7geV5D4E2VeGCt37ulUVzE5fI8OPY/IgSTu13Zg9OifPNiPpb7kS1
         wxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zS15kjcQSFfjJkxGcL/3p1Ft+qS0KeG9wSgM95IEois=;
        b=ZGvXUbKfbO6uPbxDiKzps9FgJ9GiotRzazGbJI0WzURymVVfy5d9ANhnorl1RL4WBQ
         46Nfgh6lsnUCvg8McLNIFdENtrE4eIElIlcul1btpWhoceN10sl2FgOXs/0GW450BLaz
         r/HKriSfWvO+E6L5JeKWdtiprxXJQJirMPGmFI4Q3Zs0C4AT7/5JTnHnCmFlwE0i8e2N
         w8xA+GnjFXCyVkRm/m2Vu4esYXCdHZh4xOE5os325VQwMTX/tzGL36/egsOUx8qyr6pp
         /ZqiRJHnVNwmZS6eqi6EqrC3jEIhqLvGmUlTJXcAJbvPZfVGpqT3miWuUxLJBg95cfQf
         +KFA==
X-Gm-Message-State: AOAM533SDwRtkdunhGxR5blrIkVZNaIgbvpFM5h8hY/6b1VGdiT/+Bw0
        Eoyu86u7pT8tZzOWsi2A21w/0w==
X-Google-Smtp-Source: ABdhPJzgoFPmSQuxSp+gptC0qkKC7alqeO1/G1n3fsDmMNyZWQkh5Skz8fv39JzRRu97FhSMTyfk/w==
X-Received: by 2002:aa7:875a:0:b029:155:7c08:f2ed with SMTP id g26-20020aa7875a0000b02901557c08f2edmr4441795pfo.52.1602862288316;
        Fri, 16 Oct 2020 08:31:28 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f15sm3295008pfk.21.2020.10.16.08.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 08:31:27 -0700 (PDT)
Subject: Re: [RESEND PATCH] sgl_alloc_order: fix memory leak
To:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, bvanassche@acm.org
References: <20201015185735.5480-1-dgilbert@interlog.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1a4c312-2fbf-b149-bd43-7190af75ca24@kernel.dk>
Date:   Fri, 16 Oct 2020 09:31:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015185735.5480-1-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/15/20 12:57 PM, Douglas Gilbert wrote:
> sgl_alloc_order() can fail when 'length' is large on a memory
> constrained system. When order > 0 it will potentially be
> making several multi-page allocations with the later ones more
> likely to fail than the earlier one. So it is important that
> sgl_alloc_order() frees up any pages it has obtained before
> returning NULL. In the case when order > 0 it calls the wrong
> free page function and leaks. In testing the leak was
> sufficient to bring down my 8 GiB laptop with OOM.

I've picked this one up, thanks.

-- 
Jens Axboe

