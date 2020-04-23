Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F82C54FD0
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 20:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C229C2084D
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 20:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2R5fmG17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgDWUer (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgDWUer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 16:34:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C59CC09B043
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 13:34:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n24so2798617plp.13
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lAZLvgUscRE4/uWVi5RrbkZoz5M8Eu/oXCjzKRnqlSA=;
        b=2R5fmG17hWkeAurRHdMXiGPKZ4ZFUN7BUElkzTs+N6osWMzA8Fc3arF4hZn1/iNEQX
         XTnz+E1OPTR8p/AywK8peZM0ZWWjwLP9abn773JK/UllNoKAfCovo+83dmKHAtv2nPgc
         KvAzkSEbAU+wrWoRdYTTTj48sikHnuQcOHvA70ktqOzNdfaiplzxX8kEIDsogjS2G4QL
         WWCFepAdUVTYNaHLfmVk5KuGIFuvJYBcOL2jTU0Fo9JLOHb7e265jmplB4hGbDMgQRwr
         u5zJ10BQzNHGhNI2xpDh0rwPjiPxfoVJt3Dl2Tr+vqV+GZuS3fsaJHqqcqMSOYrGjhcK
         fPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lAZLvgUscRE4/uWVi5RrbkZoz5M8Eu/oXCjzKRnqlSA=;
        b=MHCy5rU3BydYbp7FXGSLzGI4LCxfMrgxEvK/0rhmv/Y2f60gC+oiJZxTI6IlffVnpq
         2e2+SLB9a3esVzgb2BVchX/c3LaayxX7doL1qy4/T9gVHSUz7ZTZt6kxjw9nMJ0jTTpU
         WwgdXC/bQgq5jct/gbcqBLWN0JvQbEnK5rIIyXSsrcDjI18VQutBVvjv6YCa2QWHBfPR
         eByLPl++CKeVjCNE26uTY5OiMmLpN4sBScuaHNA0E+GAluWFmNmeIwy/Rh5tC3WiPN8S
         mjJ+Q05EPqX6+D5OMtO2FIqwN6tnN3s7THGj6wMbymRXE0T28ntXGH6yCwGJuAOhoRUP
         k7vg==
X-Gm-Message-State: AGi0PuZrY1XIjCz7MznBbav/RqPlMKnL3quig+xL45qt25feJ5dw0+5o
        QJJH6WwRjsIt31odEM5JYLYPgA==
X-Google-Smtp-Source: APiQypLn+IYcd37nChbfNJ2MjfbSkY+RHfaNofUDTl6fpj9ZG+4vm2WpiQdjVS8Lz5J//GuY0Lfb6A==
X-Received: by 2002:a17:90a:df15:: with SMTP id gp21mr2708249pjb.2.1587674085328;
        Thu, 23 Apr 2020 13:34:45 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a15sm3155897pju.3.2020.04.23.13.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 13:34:44 -0700 (PDT)
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Jesse Barnes <jsbarnes@google.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Salman Qazi <sqazi@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
References: <20200206101833.GA20943@ming.t460p>
 <20200206211222.83170-1-sqazi@google.com>
 <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org>
 <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
 <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org>
 <CAKUOC8X=fzXjt=5qZ+tkq3iKnu7NHhPfT_t0JyzcmZg49ZEq4A@mail.gmail.com>
 <CAD=FV=WgfAgHSuDRXSUWFUV8CB3tPq7HG0+E7q2fRQniiJwa1w@mail.gmail.com>
 <CAJmaN=m4sPCUjS1oy3yOavjN2wcwhMWvZE9sVehySuhibTmABQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <016647fc-1d7b-7127-68aa-044d4230a22d@kernel.dk>
Date:   Thu, 23 Apr 2020 14:34:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJmaN=m4sPCUjS1oy3yOavjN2wcwhMWvZE9sVehySuhibTmABQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/23/20 2:13 PM, Jesse Barnes wrote:
> Jens, Bart, Ming, any update here?  Or is this already applied (I didn't check)?

No updates on my end. I was expecting that a v2 would be posted after
all the discussion on it, but that doesn't seem to be the case.

-- 
Jens Axboe

