Return-Path: <SRS0=YUXN=73=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394DAC433DF
	for <linux-block@archiver.kernel.org>; Sun, 14 Jun 2020 22:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E762074D
	for <linux-block@archiver.kernel.org>; Sun, 14 Jun 2020 22:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j6311Ihu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgFNWs6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jun 2020 18:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgFNWs5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jun 2020 18:48:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC07C03E969
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2020 15:48:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so6774976pgo.9
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2020 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=odYYJe3FGdrPjfZxDptD/x2hgNUbZ+M5spiQZGUX/DE=;
        b=j6311IhuHKpq4G2m/JCIF9Bkh5vOuknhzJ1J7jWJcCxO85CHRbX0qr+gSV2K/Pj7Iv
         u1LA2NgC2VQfWaqcmaRE2qOfBABa4m3Y/vFmbzPeK9voM52UV1moO4ESFqnZKbo7mxI3
         aUL7/i3TYhlYFCKQxuS40ZAG+S6fHfXhYFdb1ihBy/AAAlKlhBzjrp2aPHJ9sl7ntEfq
         GVqv8aRyM8fAYyAAyeWsHuAK+Iq3qJG9VYlmzk8xMywAkXwRezRdR5hXECozsGnKzyHG
         VnpbNHD0FM7M3sYPJQPs0M0gD3rq6IavEh4zdBM1Yq06CIGSEoyQKf4+XFQpcfy/Nfsm
         GA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odYYJe3FGdrPjfZxDptD/x2hgNUbZ+M5spiQZGUX/DE=;
        b=cd6ehew2oubuNczJn28i3h463N3+dUT/qb0asmEMCwFoBWtaW/1cLZONr2yW2KYTj+
         ARHKk3urTaXIXrIDeKcRKEbnRx1xgXPCrBTNIADeeXunmBAcemfg5bp841WKjjok/tww
         R8FTiaWjn1ubfKYYCDIMOwNz9dC/Is1T7nq5t2oAuBNjG4MEDzk636Mrx+CME60jWQGD
         n87LrVcc2bAY9qEYmzRiGOaf0yMP8+I0wilyUAijN4nVtlQMt34JGku9TWo6tEtBzbgo
         TpYI5w/6Vt3sVcxAEVvHR49fD7fKfcyl+tkWF0IQjZrc43pMB0OxujoNb4zlWOcXfG+r
         GLjQ==
X-Gm-Message-State: AOAM532TpfcGR9fZk/1PJbggzQDlerWnn3+f+bc5ivHXm7cGbz6iSd/7
        P+/rItQ00Cq3Bf2LOBSfKWhEM6iJ8SnY7g==
X-Google-Smtp-Source: ABdhPJzBwGWakpM2MReXolA9DndxGRQ5h+8rnqDcL3t/V7jtfGFaBmcXe+JTY29VRPOEbeb/Al+hcg==
X-Received: by 2002:a65:4488:: with SMTP id l8mr19020779pgq.327.1592174935249;
        Sun, 14 Jun 2020 15:48:55 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l187sm11787108pfl.218.2020.06.14.15.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 15:48:54 -0700 (PDT)
Subject: Re: [PATCH 0/4] bcache: more fixes for v5.8-rc1
To:     colyli@suse.de
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20200614165333.124999-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <595e3582-980e-6cac-66d6-9ced628239e6@kernel.dk>
Date:   Sun, 14 Jun 2020 16:48:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200614165333.124999-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/20 10:53 AM, colyli@suse.de wrote:
> From: Coly Li <colyli@suse.de>
> 
> Hi Jens,
> 
> Here are more following up fixes for bcache v5.8-rc1.
> 
> The two patches from me are minor clean up. Rested two patches
> are important.
> 
> - Mauricio Faria de Oliveira contributes a fix for a potential
>   kernel panic when users configures improper block size value
>   to bcache backing device. This problem should be fixed as soon
>   as possible IMHO.
> - Zhiqiang Liu contributes a fix for a potential deadlock (even quite
>   hard to trigger), which I want to have it as soon as possible.
> 
> Please take these patches for v5.8-rc1, or -rc2 if it is late for -rc1.

A few hours before -rc1 release is indeed too late. I'd only queue and
push anything this late if there was a very compelling reason to do so.

I've queued them up for -rc2.

-- 
Jens Axboe

