Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9066FC433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 03:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622B121841
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 03:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oMY2V4F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgFRDqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 23:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgFRDqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 23:46:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2915C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 20:46:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n9so1882241plk.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 20:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4GT56k9T/ZTDoyTYqGTbPF7+FHS2XvXa9AkMU/5htfA=;
        b=oMY2V4F0GZ4EaNFR9ALy1J/WJKUSagln2jQWoKHSSHprBse0BcRSPzNRfYaFH/Q731
         fFr3LBpUu9HCzfEpKjvDWcAIETemlq6lTuejnio/7Xp/xL/U30ZNEfU+vVoF/pfZCqgu
         VtNMy1Q0XJgNGgNUGOl+il+5+JpX6aIAv78Ts+z4KYoAGdvlBSH4UBhax+YRq4sEbsGl
         AnOuJErt7wgLVMFCREjhTaraBnX4NRnUiG8Wou5+qFgLuAiXsELFs/lpvQ7RjKDo7gBU
         dq3tRXbdxivc6WsLFp5/3wMZilb0m+oNw/8o0dkFhI4b65PKbBHzEiHiNN3WkmBrTNYi
         0JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4GT56k9T/ZTDoyTYqGTbPF7+FHS2XvXa9AkMU/5htfA=;
        b=BRyhkSSWH/Eix7GqABQTRsR9r/jBkQTAiB8wZV0o1uyRVfbHjpilcpBU7b8FTwa/T4
         W4RSr54KcZfSGgtl7k5Mh15kE2IfFrIzpxLQB53ty+HpaFkRi6ZeSGcNGVvo/OZ17rhv
         OB009frPV/WqU4/GoiSzX5PRjVXYwksiR5QayxLkHL9Ki9o58NKZRkrMP738qXgMMlak
         gs4Zkgx6b1zhDOinWu4pcsNFSWdBmEBpTTJQtdYJbhXXXOii4E2/w+Ke1CystFaKGmx2
         XeKKnEsI72EdwF+mlJK5BItBQ1qm9qs8NVxyGjgzaMZvuybt4b9uJQQWmHV4MSEu00Ds
         e7vw==
X-Gm-Message-State: AOAM532bLW3gUVE9Eh0P+YEynsbD51T3JchfV8ON56hU2UBsnzPK4fLf
        50Vz2vT6PAEtJ+0v9PYjrKCLNA==
X-Google-Smtp-Source: ABdhPJxxx7EVn4Cpsblh2T7oW56MKK52snnSq2TEgJvD++4dJbPCza8tlqhrtmtxkvIWk1LQ27YFiQ==
X-Received: by 2002:a17:902:599a:: with SMTP id p26mr2120023pli.322.1592451994183;
        Wed, 17 Jun 2020 20:46:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b11sm1198002pfr.58.2020.06.17.20.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 20:46:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] loop: replace kill_bdev with invalidate_bdev
To:     Zheng Bin <zhengbin13@huawei.com>, hch@infradead.org,
        bvanassche@acm.org, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     houtao1@huawei.com, yi.zhang@huawei.com
References: <20200530114032.125678-1-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f50b771a-52c3-f8ae-9baa-1603dc83d115@kernel.dk>
Date:   Wed, 17 Jun 2020 21:46:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200530114032.125678-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/20 5:40 AM, Zheng Bin wrote:
> v1->v2: modify comment, and make function 'kill_bdev' static
> 
> Zheng Bin (2):
>   loop: replace kill_bdev with invalidate_bdev
>   block: make function 'kill_bdev' static

This doesn't apply, so please fix that and resubmit.

-- 
Jens Axboe

