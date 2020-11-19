Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CD7C6369E
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF062246CE
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yfkLbsgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgKSQXw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgKSQXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 11:23:52 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF0CC0613CF
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2020 08:23:52 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n129so6700235iod.5
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2020 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SdfnZnZFCAVfsVFw2Gcaj97k5GE/KTLAJnWlDhpg+mc=;
        b=yfkLbsgH+auAQyTeo0NtHJm8/xRBiRHIz3loRAsb1FNG0Ra00wPu60HC1uupu7R5k0
         O0L3SMGWlW0iFoQNsAzzz17cCbDtET/I/DyPs88Q9kbAZnUQfXEwNCWCwTEQyJizM/bl
         L/RTLnUJw/qax5laikNXHNKshnNIfcR5GT7VfY/sjpMHShXSasq3SqeUJqmiHuo6qfor
         6PEk5Vsbsc9+ugnxVAEjGeaBg87mvL9cO1V/ItF/E5z4LfjVxbvdZEJUuyLRrt65URUN
         L/1yx/LFY7fGNVPGYhGProEyfomYVJ+vDGJaa8qxKY7WTrmHJUYzu2mxvba4OCz7fLeK
         ejAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SdfnZnZFCAVfsVFw2Gcaj97k5GE/KTLAJnWlDhpg+mc=;
        b=BFZHK8xXX6X1rkUbNrKBW2OZtoeKczahcUBeIqhConM/JZhfy6fCR9CzeXLjtL4udY
         2FeVS+bSR2Wynv2CvPnBMxhaarsRqw7v4yzFhvrAew3yhDDsJdvsLEvv3LuoNWBTIZrn
         vWXeHDw6kquoezOU+e3ZYL/BTfBTiHJppnX7CN+zdrKz26At1Yp0OTVKQnxlbdH+5rCm
         cKnFikSBecd8U8i3jkUo+hiVkOvdDQEQ/Z67AbX4XBaPK1izJCI6Cap7DFZjQZocIZoa
         BLu65xxyHpwyY11GQId7THoom2WpuzyaEHKO0AxidhUiFkEYnpmnbwUmUr1BCVXsj7m7
         5/vw==
X-Gm-Message-State: AOAM533e67cHW4YBJMfusvVi4X0uEfhkx9C/CLZNoCeNepezZFZbO1XE
        GTJ+bf6IPduudbnzV4OX3paTnA==
X-Google-Smtp-Source: ABdhPJwacRNE46/FcGIrducjj2/Ja7LpFzT4psmd2m9exf2iyrVD2fmBKlrS5BD4kiuzaYJE4smlgw==
X-Received: by 2002:a02:cb99:: with SMTP id u25mr14879852jap.73.1605803031610;
        Thu, 19 Nov 2020 08:23:51 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a13sm164092ilh.0.2020.11.19.08.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:23:50 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.10
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201119075057.GA2465128@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ebd1fa99-a32b-cb98-cbd4-ddc5c5b067ba@kernel.dk>
Date:   Thu, 19 Nov 2020 09:23:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119075057.GA2465128@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/20 12:50 AM, Christoph Hellwig wrote:
> The following changes since commit 9f16a66733c90b5f33f624b0b0e36a345b0aaf93:
> 
>   block: mark flush request as IDLE when it is really finished (2020-11-13 14:24:16 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-19

Pulled, thanks.

-- 
Jens Axboe

