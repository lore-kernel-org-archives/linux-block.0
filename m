Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1FAECAAA3
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 13:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbiHZNdg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Aug 2022 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbiHZNdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Aug 2022 09:33:35 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CADC5CF
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 06:33:34 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y187so1183548iof.0
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bm4tNFuy7lSf2+m8K3Mk3PHBL0KBtw2bz6p4BIebiH8=;
        b=4rmQtelHxrXF2TehFEJmJDM3lHeF+2qSetwNFnF/P/zC3gHySXd3t2+mS4RMBRfqp+
         BlNfWSXG8ipBdGO6V0gMY4TG464nywtsNx/nJ+FsktyVWv+hUq7pmk7L2OtYDd6iud3j
         fInjKY9s3mR/Rvjo50SCrkVzHVyXOyAmjukKyvKeEacg8EEsIEHsFfvDhTJnRvDe+K+G
         S5QNrXosnVYg47XJHVQcMJzP4aOo2d37N7k/bmFcwackGUw7RwAwIEgagWqoSRffZoVc
         GiG/YEfLr4fzrIT8uVdM0y+DXMG0FVdcKehgU+wWzrOO0Wl49QKNuNk1fqYPWCdCb41t
         xcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bm4tNFuy7lSf2+m8K3Mk3PHBL0KBtw2bz6p4BIebiH8=;
        b=GcqPemeqFBzY2fVqaZAJkX09XMuFTLXBrhLUa7ztOOt6mxO/2RTvh/NWe7Zb7ZIP2V
         e66708dxBN/5C8WcpoPJUZkkqEPAoRAhKnEv+ZRIRXIpOrixx3QBlCzrLNVeozcAW73T
         09qsgEewSyHvBodHPvH7HQnSVcrLGDcoWCOT4GFb80Zv49ecETWnWfmJCOo4XQJGa0Bg
         QFHnPVk4GpDZiDvG850aiWMUC+9FGKt/YfTboFzJ+C9nwk8f2Cq3qVCWUiuIxeLKrboM
         7oG0OoI0iWMozNlaKOhbpu6IMrAc7iSIy/9ArkrmGtcLCk5ArKPx11dJJ3+8CIbcIMkB
         yGoA==
X-Gm-Message-State: ACgBeo0NaW1RQiHep8bgcTS875Z1QEenZtlPuAtHaqSQ3OpxjgKQhmX9
        J8RG4DSaFyX2Hb9z5zhwWbR+Xvp2o4U0/g==
X-Google-Smtp-Source: AA6agR7F0eMxPcgqhP1YNe+QE43HU/WkX+NniCKip1RcGWHW3S3Wl/CWmsLIO535/YTQCkewOgiTeQ==
X-Received: by 2002:a02:cb5b:0:b0:341:aebb:d13 with SMTP id k27-20020a02cb5b000000b00341aebb0d13mr4010731jap.176.1661520813508;
        Fri, 26 Aug 2022 06:33:33 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v12-20020a02b08c000000b0034338e975b3sm927694jah.50.2022.08.26.06.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 06:33:32 -0700 (PDT)
Message-ID: <4fff9af8-90c3-86f9-37c7-75dcd3e95dc0@kernel.dk>
Date:   Fri, 26 Aug 2022 07:33:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] blk-mq: determine in advance whether batch alloc can be
 performed
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1661477190-86862-1-git-send-email-liusong@linux.alibaba.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1661477190-86862-1-git-send-email-liusong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/22 7:26 PM, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> Some conditions for judging whether batch alloc can be performed are
> included in "blk_mq_get_tags", and this function is only used by
> "__blk_mq_alloc_requests_batch".
> 
> This patch introduced a helper "can_do_batch_alloc" to prepend the
> judgment condition and avoid unnecessary function calls.

Curious if you saw any differences from this? Or do you just consider
it a cleanup?

-- 
Jens Axboe


