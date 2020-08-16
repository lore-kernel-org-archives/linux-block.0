Return-Path: <SRS0=mZfT=B2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD1C433DF
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 23:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6091D20704
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 23:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="chSTNlMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHPXvC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Aug 2020 19:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgHPXvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Aug 2020 19:51:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25BC061385
        for <linux-block@vger.kernel.org>; Sun, 16 Aug 2020 16:51:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e4so6929333pjd.0
        for <linux-block@vger.kernel.org>; Sun, 16 Aug 2020 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FpjaFqw6MAVjixrg8WWd5gyqQ0JqwCGhPaZrUX6JaVs=;
        b=chSTNlMPnY8Yrgh+JBUgMCpP6dTTqAhjnDVvkIuUzRIPAchGtQnMHFLYGHWV6cpbGY
         FA+BDYBizktOOheWfgllp3QbqmSH/z4jz63LDkv2wFOhcgq6J11DTuspb+6/RJ4HXEJO
         hLhkcq5cJDYCYmSL3clAt1ycrukXb3msfwuA9OAiB7GehMZYDDEmnTwY4PN9zZmwbb09
         04tCQvYmxLcYSSJ0LwODVAkJhSJKGu07jYkNOt7Tjp+e8LyandTtAq/wfnibMvjFuwe1
         4cIfan+W3OUv4k32QA0bZ3Eq05qghH6bTgBZc9eCIR3pS4KXQDpw4mG6rbaYmaK4H/Is
         Cavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FpjaFqw6MAVjixrg8WWd5gyqQ0JqwCGhPaZrUX6JaVs=;
        b=AHE3PdanD1Nq6ih1c6dkUfB3QrMP960F7Oj4bvtANHdGEc0SF0//vkIGZxejOHjJpT
         IJw1CySChsPjqZj0/j3IUR3w+m3H/hmVYdsfOku9t5brVmKU1FeZlbKifxrUiCzreuOr
         Sae7HXOo5Z3ziDCebDKlNrs+EopVg9NPIQVez4s7zsEYiG8ga+v8ugrlAUIjr1fp8mF8
         z1Cqswv3/IltrAahFnBG9He+L/G17+vPtywG1TC0744Rtw1PlcFbEmEXyMdwxlO8+Lyc
         G+xKTAD+Vr3tmfpFN/bcBWWvtamf9rGPUxgr2DV0Fwv8ov09ievYJZjdROG/Lw3l5hEW
         xXpA==
X-Gm-Message-State: AOAM530KytSnqu21n5xNWIHi7/7sVw06JkosJTyFat1cmKaKUmXNvYAx
        U0VI4u74smz61rvERvJo+cQs7Hx+Ch9gQQ==
X-Google-Smtp-Source: ABdhPJwHEmcuKw6C9pRhtZTYdrqZ+5NVm6RYn3NdCqwuYuEIxoXPDpH3fvI2jh0+W29CuNy+pLw61Q==
X-Received: by 2002:a17:90a:19d1:: with SMTP id 17mr9994666pjj.93.1597621860739;
        Sun, 16 Aug 2020 16:51:00 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::1000? ([2620:10d:c090:400::5:65e4])
        by smtp.gmail.com with ESMTPSA id a16sm17538517pfr.45.2020.08.16.16.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 16:50:59 -0700 (PDT)
Subject: Re: [PATCH v2] block: blk-mq.c: fix @at_head kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20200816233934.1573-1-rdunlap@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <174779d5-d698-0893-881a-3e371f2a1296@kernel.dk>
Date:   Sun, 16 Aug 2020 16:50:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200816233934.1573-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/20 4:39 PM, Randy Dunlap wrote:
> Fix a new kernel-doc warning in block/blk-mq.c:
> 
> ../block/blk-mq.c:1844: warning: Function parameter or member 'at_head' not described in 'blk_mq_request_bypass_insert'

Replaced the previous one - and since I was doing that anyway, I removed
the 'new' from the commit message. Looks like it was from 5.6, so not
what I'd call new.

-- 
Jens Axboe

