Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11B3C433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 21:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJEVDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJEVDc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 17:03:32 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC3816B7
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 14:03:29 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id f23so16517049plr.6
        for <linux-block@vger.kernel.org>; Wed, 05 Oct 2022 14:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tg+zyVaDDOmexowwFOpcOqbm9qaJm8aITJoR5zudXLQ=;
        b=PPCRAkI0784UmU/iZ++zD43YrHZU8kVVtA0Uqm66FMNXeQPtApmG1n8krRTWg1euUl
         FUB0b5+IeNvOira3olnX6tOSTAXdm4kcZhsRyjWbBRLCKqdxe57Zxz9uhHvXnH5nV0Ce
         N4YJSOCZFtmLXcQ6AlbFAQlPsq3ABqciwtWf5iOZI/iI4RNlOAaG+3zyv7RiO4rz0/xB
         1coI3DXNlTyQODKBsuepCu4jPddIM2c19NfzzoMLIVrXh3DMAfMKSG0eo4jiZAtWWbqh
         QGJQMXrLuTFRaQ50ynGFmJAWpwVA+akfUIbN1fTffrvSIsqp0cuHhRv/tHvMGk/W+s4D
         AXtg==
X-Gm-Message-State: ACrzQf0w4AD2h4mwp1J5lXJpWnW8vwOYBanUFSDc8jdSuQrtnyhVPsQe
        Y43jbCWW1zx/80xdL+yaQqix0GajivYvgA==
X-Google-Smtp-Source: AMsMyM4FSAtpq/idUroGjCVsArTSMzzNpr5tPSuPEGaJyESEP3WCEa2HN53wpAvy5TcydapCmgB18Q==
X-Received: by 2002:a17:903:234f:b0:17f:6711:1f9f with SMTP id c15-20020a170903234f00b0017f67111f9fmr1495310plh.32.1665003808986;
        Wed, 05 Oct 2022 14:03:28 -0700 (PDT)
Received: from ?IPV6:2600:1010:b028:54bc:3c2a:11bf:3557:f843? ([2600:1010:b028:54bc:3c2a:11bf:3557:f843])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902cec300b00176a715653dsm10984571plg.145.2022.10.05.14.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:03:28 -0700 (PDT)
Message-ID: <206b68b7-e52c-969c-a08f-a309a86c1ba6@acm.org>
Date:   Wed, 5 Oct 2022 14:03:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: again? - Write I/O queue hangup at random on recent Linus'
 kernels
Content-Language: en-US
To:     Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
        linux-block@vger.kernel.org
References: <CAK8fFZ5w8CC7ez50dEd9nGJpc_c-ubJLk3+77d7Y5qN1pMkfRQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAK8fFZ5w8CC7ez50dEd9nGJpc_c-ubJLk3+77d7Y5qN1pMkfRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/22 12:43, Jaroslav Pulchart wrote:
> I'm investigating a queue hangup issue of our databases running on the
> 5.19.y kernel.
> 
> I found "Write I/O queue hangup at random on recent Linus' kernels"
> thread (https://www.spinics.net/lists/linux-bcache/msg10781.html)
> already fixed some time.
That message mentions WBT (write back throttling). Is WBT enabled in 
your kernel? If so, does disabling it help?

Thanks,

Bart.
