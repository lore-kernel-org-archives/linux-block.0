Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD31C433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD1C61443
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhD1OEs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbhD1OEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 10:04:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB5C061573
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 07:03:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gj14so979430pjb.5
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HVK6sJ5rAmqrn0m6H37k3y2DXcZyJR6beBYIZ8OR3Hc=;
        b=KBGKiJAr4PdtXa9ZUCmpliMzck+/5Ni7d9gGfqlDlfwg4V+5EFdQ+GQb7in+Y1+MD4
         WU8NKVpjLK3CsNmi2qH3YS6a6UeGtehc1FWjCQym9t+cn+2mgrUldvToS5G7G2ndeBoK
         z0li6pcpv6GjFuQF8PiJBsskuMVG5ne5XBYdmUvRv711nbpOcZQdD9chXuIsDSpewREb
         2gYBAHMr4jsR8UMNrMYRzTbVPfB7h/jPFB1heD0c8RFegftF69tos9UqasUDM5NgWzd2
         uKnxKYYxXX6rXs7c2AYn7FL0KxrNZ2UDHlM21FS642ZZzTRgo66ErCFxzG2q0JL/+ai/
         n/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HVK6sJ5rAmqrn0m6H37k3y2DXcZyJR6beBYIZ8OR3Hc=;
        b=gJQf1qi3WFLrDnSezldl//GDuow2mUaMtLFi9ivqPr8e+HiOv7cDUsHiCxIdAtdjYM
         84p+fxczb8TyeybuBd89LmnPAwbU97GAEBQimKy0fpSz89A8X2cC8k82zpGipFf/nwHC
         XemeRPIQDRL52PgjNkQVoGILcJJRovw6u60uVD05h9ODktXPJ05vAyHg7IFn/MOBLhhp
         ZNd+esQdRUEKjc4uLrdXZfvRrmyCEc+tUsvZMgTwaIKsyrm743X/WmVrU8pkwa7xD88X
         iiUpxfCOCwPEHNejf1GEl/kZROeOpJomttHvMBfQwa3VeFPorcJ8UwAfMIRBP6cpHLjj
         eKFQ==
X-Gm-Message-State: AOAM533Ke43o3aCglEpiTXVJJRhs/FScWeLeDZqhW2Jc8IstXLhOe0sL
        1rUDKldrqe1ZvFzCATH5VbitDg==
X-Google-Smtp-Source: ABdhPJxwp0J+/qWhc1PIJ0D+RgPMEGdLcjroqLMMDin+tWhOJFbCPI+iuSbdbMsMF5jUseVNb6FTqQ==
X-Received: by 2002:a17:90a:540c:: with SMTP id z12mr4145834pjh.42.1619618637803;
        Wed, 28 Apr 2021 07:03:57 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b4sm4700058pfv.188.2021.04.28.07.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 07:03:57 -0700 (PDT)
Subject: Re: [PATCH for-next 0/4] Misc update for RNBD
To:     Gioh Kim <gi-oh.kim@ionos.com>, linux-block@vger.kernel.org
Cc:     hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
References: <20210428061359.206794-1-gi-oh.kim@ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a198997f-9bc0-4ffa-9d62-33aa9511629f@kernel.dk>
Date:   Wed, 28 Apr 2021 08:03:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210428061359.206794-1-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/21 12:13 AM, Gioh Kim wrote:
> Some misc updates for RNBD:
> * Remove unnecessary likely/unlikely macro from if-else statement
> * Fix coding style issues reported by checkpatch.pl
> * Add error check

Applied for post initial merge, thanks.

-- 
Jens Axboe

