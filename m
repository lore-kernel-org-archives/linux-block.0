Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE034C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 02:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812F1218A1
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 02:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PA5eFYXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfCOCBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:01:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47076 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfCOCBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 22:01:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id a22so5241928pgg.13
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 19:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=go+tLHOixlm2nN9xlk8BtYTUPoazLswodwDVW4lpadk=;
        b=PA5eFYXiN5QrnJyGFluHnJEZlKyQ6g8x0Hksg1AYSF85t+YFClyTq3EBAY/xENF2nO
         BY26ccN9zoDP7rBhk1jr6MiA7yKmTUb/BZJtbNKOx7ipBWmfEwrmYGcfrRBKifSHEw/y
         QXSHI77kKo64nPIeKmdVsh/eLxqlI4+e+rH/JwgxByPaL3ZA/T+GwUFa83QjVypfLAln
         jzZsxZFcJOdWGm4KV9qaw6XNV8RjRwUlusRPT/2LgHACF2aj+//LWGQHVSPW48QVjlHv
         L2FDyzOCtwFLcCo+9DOGpwQW1T/G0bUiD7vEXsCdZCWcgnvwts+2z2KOZTjKAqn09Xmc
         Z04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=go+tLHOixlm2nN9xlk8BtYTUPoazLswodwDVW4lpadk=;
        b=L1hZvDn+W+BAeIy6LWBodasXgBhfcfvHUDubP4GAkTeewz6Nb3lekaE29MHGNdhwBt
         QgC++qkLj5fFDw4GNFf8j8junGNGkzHOB0F5ac8a+A6vzeZa8tdAPZly/kkiCc6qOGpA
         9AcmElg/ohjIIf8HMXMxpedaEHByg9rppTkfy+sgoRaJpA660HSk1cET8Jg14eKGG/a7
         gBJ37x5htsGRvS6FKLWc9nANH1T3HvwbXrnTfLTt/uD089O2I7o1g5QG5/vnn8uXtulM
         xwi0YYAVmxlGLySXouECCasqMX2jKeo+nvyiriw93zi85pfdFo+rK3Q1vQi6FnJiHO0Z
         T5ow==
X-Gm-Message-State: APjAAAW5gebuQeBx15iFmRkwsOezEFqVuO/8E4BiveFe7FYNaJcLPlZY
        O9aTbgkHVYujSiry1mn/w8yjYfkSHl1HfQ==
X-Google-Smtp-Source: APXvYqwXr5zE3VAy6wB+XWnxvRkOrjlzD6zVfdGVK2JYFokskrLaHEBSMmoUvFVtyFrFMc0smzhqBQ==
X-Received: by 2002:a63:d54f:: with SMTP id v15mr996627pgi.318.1552615271711;
        Thu, 14 Mar 2019 19:01:11 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b138sm555754pfb.48.2019.03.14.19.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 19:01:10 -0700 (PDT)
Subject: Re: [PATCH 15/18] blktrace: change strncpy+truncation to strlcpy
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531445162-19771-1-git-send-email-asmadeus@codewreck.org>
 <20190314213721.339979f0@oasis.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <80ab6751-cd34-1da6-91c7-7558d3a17943@kernel.dk>
Date:   Thu, 14 Mar 2019 20:01:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314213721.339979f0@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 7:37 PM, Steven Rostedt wrote:
> 
> Jens,
> 
> I noticed this old patch in my inbox. It looks like a legit cleanup.
> Want to take it?

Indeed, I've applied it. Thanks!

-- 
Jens Axboe

