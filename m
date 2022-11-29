Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6CEC433FE
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 17:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiK2RIh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 12:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiK2RIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 12:08:36 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CB924957
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 09:08:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 9so14281606pfx.11
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfz3Mcgxkqb1OqUShW9AvM1bJWJ5IVPUimuhgnHTUfM=;
        b=aB+ZuGMOzbK18zkd0jlC4zEUTSM38tp9K/bCtuVmGeRWETnLRpEwg6Cfsis6G/o8YB
         2HqB7jorwoOw6h/LjLMxu5ed5EZE92927W/9yhpp/QruynXSUNxJp0OMoVkixJnRoaDz
         PSuOZAOkF9I4gSS32lclTss+2DBuTn/ncV2ntYH8YMzg9PF3tm8qf0hVKILYBg2UDCmD
         wbUFp/1Fi7NjOLDWJsNeD/wtnDvCVPYo4knWim39AeNTc1EFLvMkEGW6VYwyktGtW5Qx
         +UBWGG0y4yJft2CYMgbAUi9qHrNg41pvQg2NXxZ0NdMCIm2c1JLzlQ89YLhdvsbn7Bys
         PI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfz3Mcgxkqb1OqUShW9AvM1bJWJ5IVPUimuhgnHTUfM=;
        b=LxYDt64HLurSQqHXXgs6d+cfv1qtm/k0WJBeCKpSGLv++1VMCwbnRdO86wTJkRJPnd
         is5SBWLE5f63PmI11dshtM+5SquRAUujphUMIvSGd/c2pAVKUiFQ0LAjuhk2AnNB2FgL
         4DvMRXtEEneuIb03xA+IfiHKR6rQ2uMItPify6QphgIM7vXD7uaanbLnBTPdfZg0WbNn
         YDjUWzYAgOSc2xSyIRRn34uLAdZ4fWelP5tRUVanZO/QVF1GDgABm24SWQWGIkPjR8/U
         GBw9blM7AZQbNxGECKK8J2iKSxCGP0AIYIh7yV6D3Z1tjP4cE55LYgfDet9JyAbJnSLP
         CE6g==
X-Gm-Message-State: ANoB5png8SrYVECXpKOAPtZcjpHqPMSF4ztJHJNbUP8T+btAiyTAtLFA
        KjG8sAA/KcxCnifepf92nYgNAw==
X-Google-Smtp-Source: AA0mqf5swFLksPgiEDo6TRTvtGl0tdoW1L9fhbh0pRyA3vgdzDg/DHK7jSPhCQbx1VNNnHFBlq3wIw==
X-Received: by 2002:a63:ce58:0:b0:473:e2bb:7fc0 with SMTP id r24-20020a63ce58000000b00473e2bb7fc0mr33307253pgi.604.1669741713274;
        Tue, 29 Nov 2022 09:08:33 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h23-20020a63e157000000b00434272fe870sm8633883pgk.88.2022.11.29.09.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 09:08:32 -0800 (PST)
Message-ID: <9044e2b7-193f-ade4-b4a3-69e40b12088a@kernel.dk>
Date:   Tue, 29 Nov 2022 10:08:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/5] Fix probe failed when modprobe modules
Content-Language: en-US
To:     Li Zetao <lizetao1@huawei.com>
Cc:     st@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, airlied@redhat.com, kraxel@redhat.com,
        gurchetansingh@chromium.org, olvaffe@gmail.com, daniel@ffwll.ch,
        david@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, pmorel@linux.vnet.ibm.com,
        cornelia.huck@de.ibm.com, pankaj.gupta.linux@gmail.com,
        rusty@rustcorp.com.au, airlied@gmail.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221129160615.3343036-1-lizetao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221129160615.3343036-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/22 9:06 AM, Li Zetao wrote:
> This patchset fixes similar issue, the root cause of the
> problem is that the virtqueues are not stopped on error
> handling path.

Not related to just this patchset, but guys, Huawei really *REALLY* need
to get the email situation sorted. I'm digging whole/half patchsets out
of spam every morning.

This has been brought up in the past. And no, the cloud variant of
the email also doesn't work properly.

Talk to your IT department, get this sorted once and for all. You risk
your patches being dumped on the floor because people don't see them,
or only see small parts of a patchset. And it's really annoying to have
to deal with as a recipient.

-- 
Jens Axboe


