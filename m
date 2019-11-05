Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F54CCA9EC9
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 00:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BED214D9
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 00:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jBW6MAoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfKEAK7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:10:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33974 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbfKEAK6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 19:10:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id e4so12713540pgs.1
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 16:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZdHIvJCsCyG40ixK1Kgkixh43OI8kecVqD+tKS4zGU4=;
        b=jBW6MAoHjR4CO69gCwRsDX3q9OXsCghW3SjCIfeQxObnj3F43ANaZPiUd4d4AqOz4y
         XtlVyOGKBpFiTZf4N0cw1pRgMmyQptePATdH9MqjCOWxxj3Eo9x+qR/SkxGveRwOyeHV
         ablGtVSrkvpK1l3raoZaNPe2B9/0sZAPD9T9mtiSP44JlSneltTncatjZV5qUACbykYA
         YJC66Yk29NBgnMqSJ4ARQZyMYtOpeC0o9uzyUvJM+E8YjjhmP2CbYSgB1JVHm2KujMzv
         QKYvTCqlgmIM1cYs9/ALF1yZtxcuNbjI3uyTYaaKiBEuTEJRkoUZqMbnwqD4CEcthRv/
         ZDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZdHIvJCsCyG40ixK1Kgkixh43OI8kecVqD+tKS4zGU4=;
        b=Ia/Kb/digl3N9wl6Tp8O+Z6WPK8C/rgpNnj1JiBrk0l7F4tD61DoImzGgQZzy7FnU8
         M3nThF6dFRNrBs4w7YwmgzzfGY2pnmdJgVHbcKYFnmGESDmIi+9R6s/SOyczmJvoUGKZ
         eEvMcjMg8i/1WFxoM4v/krQhmtX5y3EGv0lkPU365ibMv5XV50GoxXRvz5wVn/OFHVdD
         2BTME2hXzszVFTOP17RPK2KxazTyzcZYKN4ow9gzaOsS1g46pj51kE+WctkfEG/SzSlP
         6z5OzJaCJPaVt/E87sMqIRV1DSY8rXHSFhlyBf+AzLbDLz2Ts0vPPb64rfMgaE+h5DqK
         MY7A==
X-Gm-Message-State: APjAAAXRAF0vi+eXA5vp+aPUcjUvPwPtC/dwnbbq6yJbaIMAi1+YsHXz
        8vGwMbEP4rExPEDGad/sfd/2jcS69xTeDQ==
X-Google-Smtp-Source: APXvYqxki5NhXtBAuGwQHqWdiV+M7dzzddsKQsmCdzccVMdt1tslKvVIUw1Cbjq22CLMy3j9RtgT9w==
X-Received: by 2002:a17:90a:9505:: with SMTP id t5mr2425734pjo.133.1572912656061;
        Mon, 04 Nov 2019 16:10:56 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id gi2sm16838215pjb.29.2019.11.04.16.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 16:10:55 -0800 (PST)
Subject: Re: [PATCH] block: skip the split micro-optimization for devices with
 chunk size
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20191105000617.26923-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e0192ec8-5151-afa4-f355-9dac595457ab@kernel.dk>
Date:   Mon, 4 Nov 2019 17:10:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105000617.26923-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 5:06 PM, Christoph Hellwig wrote:
> If the devices sets a chunk size we might have to split I/O that is
> smaller than a page size if it crosses the chunk boundary.  Skip the
> micro-optimization for small I/Os in that case.

I'm just going to fold this in with the previous, which is still head
of tree.

-- 
Jens Axboe

