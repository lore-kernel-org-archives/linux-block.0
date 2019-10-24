Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9DDCA9EB9
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 03:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0136420679
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 03:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T2bbeZtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406506AbfJXDjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:39:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44063 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408307AbfJXDjF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 23:39:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so11138962pll.11
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2019 20:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W8sgLGjMxM6EuY1mpsS+9Tn33OqsmcrGz0uhv99VAHA=;
        b=T2bbeZtvsO039PfGe+EjPR125EqRdU9mKD894GYoR0zBnNNVcSR1u3DGiXZFKGUrwF
         Q1L4mEl5u7aBDGEgAvXjkzTOXSSGhbHMY7JwyTtpuA/1lUXfeioaDSSD5DwpPF81FKT1
         ajJMYUZOWHJQq3Czs4YHreOwy2CVWx9lD7yEqbXak5+nnWYpgJsNSp3cviar/kEx8g3A
         JL2eoJFhv69W7IpzFJO3QBiRSBRWpD2PYo0i6gZ0SVVJGOTgtJG3panMDXQqq/fdjcQQ
         JYHL/HihPBR2U1KB50B+TI1h2RA9YPd7A7tX1ZQWp7kanwYzwZ3TCAZYt7pKgxi2zf4H
         C+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W8sgLGjMxM6EuY1mpsS+9Tn33OqsmcrGz0uhv99VAHA=;
        b=aDkw66dcK3J6IgCsv18b1sxQvUGCFb/TfmV2oWmyHps9JHwAO55+vR/tX3H//oEjMS
         Ij66pcZhR3r33tU+zIjxuIoIGU38BLZxJ0wCqexK3tpiGXQtfHMLkSvM+qYuugOF3l7J
         x6SReqmUeVIjfS34IOx6tZwW3+1+ybhC4QzpKAuF0FbRnNSAHKNukQF57ew/yHJJMZI0
         eackhLYhnQ7vJcdMd/FejByWw/joSLzTqzWITg2YRjmCVOPMSr6/yG/h4wGRU/S1Bbq9
         1D1XvvX+QNFUfIj3+Hi15SD2y7ojmAAWnxPAyYWTxnVKdZCKubTU1Q/wCE4y5is5gS25
         kToQ==
X-Gm-Message-State: APjAAAUzftuJRlujlYky6UVBOTpX+L40fvLwUaEYJ1TVtxgOzxmvRVxU
        y96MSFp4OLYzL/g5Pkvd1AJ4ow==
X-Google-Smtp-Source: APXvYqzjuWYGP5CVydefv3aAYM4Zf7GeakbWEIFeuKC0sgKLKckuazE4qo+gNK3oOsra0rup9w7uiQ==
X-Received: by 2002:a17:902:968f:: with SMTP id n15mr13304176plp.191.1571888344349;
        Wed, 23 Oct 2019 20:39:04 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id b17sm9759144pfr.17.2019.10.23.20.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:39:03 -0700 (PDT)
Subject: Re: [Kgdb-bugreport] [PATCH] kernel: convert switch/case fallthrough
 comments to fallthrough;
To:     Joe Perches <joe@perches.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
References: <f31b38b9ad515a138edaecf85701b1e3db064114.camel@perches.com>
 <20191021090909.yjyed4qodjjcioqc@holly.lan>
 <bff0a1c4fc69b83c763ffbce42a0152e1573499a.camel@perches.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2808c960-6178-17b8-23d7-a6945987a658@kernel.dk>
Date:   Wed, 23 Oct 2019 21:39:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bff0a1c4fc69b83c763ffbce42a0152e1573499a.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/23/19 12:49 PM, Joe Perches wrote:
> On Mon, 2019-10-21 at 10:09 +0100, Daniel Thompson wrote:
>> On Fri, Oct 18, 2019 at 09:35:08AM -0700, Joe Perches wrote:
>>> Use the new pseudo keyword "fallthrough;" and not the
>>> various /* fallthrough */ style comments.
>>>
>>> Signed-off-by: Joe Perches <joe@perches.com>
>>> ---
>>>
>>> This is a single patch for the kernel/ source tree,
>>> which would otherwise be sent through as separate
>>> patches to 19 maintainer sections.
>>
>> For the kernel/debug/ files:
>>
>> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>>
>> Will you be putting this in an immutable branch once you've collected
>> enough acks?
> 
> No, I expect Linus will either run the script
> or apply this patch one day.

Please coordinate and get something like this run/applied a few days
before -rc1 to cause the least amount of needless merge issues.

-- 
Jens Axboe

