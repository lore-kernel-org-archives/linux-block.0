Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C84C433DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 19:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A17207DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 19:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XFo2LL3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHXTpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXTpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 15:45:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646FDC061573
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 12:45:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q93so142231pjq.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XLzPGl4Eap2WEQDnCBOMpgiVYB87oR4tNzXe04U1Yus=;
        b=XFo2LL3y7AhxhrbYL3AA5QloXwqCtv51CFv+ivg2vqei/6inK40GT7BuWmfnCoqsag
         0TB19Ve8hTo23hLyYbP2EB4J627lToJoVqRnzGrN0ziDNgINk1UHHXiIlQxRxVjxoDyO
         MrfK8UK5FHNIHYSB07msbw8lRemEDR8lfZ74UIMQxiiklijoaS5ZwdC8vGg3NnN/cu9/
         4aJlQnL7TX1W4yY0mNjKPq+5tV+qzpORVVVTA9X90A8/BN7DIlPfo6iWc5bWHhY20bj+
         k1SHQTfNN67IP3GLzbkCDC8jlXLCty/OmE3lRGlaYyL/0Ynxx8vKbjUuEIHUWt5FxZJO
         rKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XLzPGl4Eap2WEQDnCBOMpgiVYB87oR4tNzXe04U1Yus=;
        b=DPXuH/5xGP7T6XWzQ6fRPBYNv11o87OWHal10gyzDQKAs+Ss4to7EIjlZIAY60LBWq
         WoYmnHd702xmxDo+60ka7FFrT+/u4ZnqBZQr39F5CE0GLbj5WPx3kGM+U2VRbuZsutlz
         CjcjukGIej9jpGBzKBi0UEz0uDsVdqDPxetAU93KqCl51RcTnuxOxh2fSLSxN7IZseWY
         F0jUiTZDyq+raV6pJGVYxbBYLwPj9NXJzaPHog/QZ/d5Y5vHfSCVgCvbGcYvzNBxRQFa
         +el2nau1CzzBlg4x9b90IHgTG0OW9dkTU56sM+XfKZg8Sylht6KvagLuuCqIBFx4NmN3
         nd5Q==
X-Gm-Message-State: AOAM5329WTbg+p7xtlDLxPPCrCQSB2GB3ST0moCE6rnFXhtbpgy879HI
        uKsDx9fwEBWzsgUU0T2b9eKTeg==
X-Google-Smtp-Source: ABdhPJwS7A/m7RK1cRDv1D4biUVRSI0CtsgcuILfl5254A5JscLQW1n+XDBrmv9+ubuiC+AL2ZrNnQ==
X-Received: by 2002:a17:90a:ac07:: with SMTP id o7mr702682pjq.194.1598298343792;
        Mon, 24 Aug 2020 12:45:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21e8::193f? ([2620:10d:c090:400::5:b493])
        by smtp.gmail.com with ESMTPSA id j14sm1880974pgj.3.2020.08.24.12.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 12:45:43 -0700 (PDT)
Subject: Re: [PATCH] rnbd: fix uninitialized variable
To:     Tong Zhang <ztong0001@gmail.com>, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200824194322.337375-1-ztong0001@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b904063-ca08-092d-a861-e1c80d511ab1@kernel.dk>
Date:   Mon, 24 Aug 2020 13:45:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824194322.337375-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/20 1:43 PM, Tong Zhang wrote:
> variable err is uninitialized when bio is an error code

It's fixed in Linus's tree:

commit 17bc10300c69bd51b82983cdadafa0a7791f074e
Author: Nathan Chancellor <natechancellor@gmail.com>
Date:   Mon Aug 17 23:49:25 2020 -0700

    block/rnbd: Ensure err is always initialized in process_rdma

-- 
Jens Axboe

