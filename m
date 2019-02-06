Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF5C282C2
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE075217F9
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 17:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zujoRw3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfBFR4p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:56:45 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38390 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbfBFR4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 12:56:45 -0500
Received: by mail-it1-f193.google.com with SMTP id z20so8262503itc.3
        for <linux-block@vger.kernel.org>; Wed, 06 Feb 2019 09:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KJdCduGQXkMCaFAWwR05XHxaYoJ8ahmV6XEx6DRT85U=;
        b=zujoRw3hA5lZ0EuuDAjilCtsAA/SXnb3s1gVfLsCkEK70LjKUC7WDufGRqdiHwJCgw
         MGRxJ77EnpvFbV52pzLV2UAYqVnIyrldvChqL2A8n79DaQi1QB/sY8cnfYoEtDKSZFs3
         rMI//RKd6MpB/SKb8I5OuV9q/Er30aMuj2t0X4oyQ0SsIEo6uai6qFakv3h3yPXuzONI
         OF1+tjjbPGdqzjf4SIJ0fVfjhFA7wvSy/qr0YLw+Cl5ZvDLlSRbpnEN9tPi69rMj0Bd0
         hsSvH8RJa4gJqGU4Pv/t/lyZeIKAlXbRDCmFJVfxH7WKbPkBPrxPiWf3ARSc1gjg2gIy
         5Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KJdCduGQXkMCaFAWwR05XHxaYoJ8ahmV6XEx6DRT85U=;
        b=cM4AzfukBF+rsSWzBr/nniu/NfgvucsQGEdPYVR9OHPy0QsgdsDQsgyAmx7WfWjviY
         Jd1mYIQZbaQXDGeB8OhfqpNrxbvosSGuW9UUvG3vaCH8frl8wdOQMSK+AIUD4tWgmpVZ
         GQHJWWB/EzB65GnY8GLkegmmABJvPzMMGFD2MjXQrI7gevHRDhkuBQwHpLwEjIIgeV4Z
         pTSf5qjzjBr48HHNk7YbwBUtFglUk9wCzpH6ID1v49wc+Y2twBfOybDLc9wopKCPvEca
         plN/jslXXSBnfEL1ddFGjjdgKfTqYxEAitzlGflqYM4wqFBkGZzSz1LFMsJ0FE5w5c6p
         Mwaw==
X-Gm-Message-State: AHQUAuZF05y9ME8H6iJxNqLe/yjLuAsIgkWVSkLa8Skq8AR/jySKOFim
        /dADj2c57fR079AwU+tbjP83Bg==
X-Google-Smtp-Source: AHgI3IYsCPzU8eBhDsRnUAGA0lVJ1y7J/qtZ5f1lV1/mNuOAvrLXN1eqniDLGmu13k5UnfPV/+KoLg==
X-Received: by 2002:a6b:dd04:: with SMTP id f4mr3406007ioc.248.1549475803938;
        Wed, 06 Feb 2019 09:56:43 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h64sm4175618itb.14.2019.02.06.09.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:56:42 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-fsdevel@vger.kernel.org
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-14-axboe@kernel.dk>
 <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
 <20190204025612.GR2217@ZenIV.linux.org.uk>
 <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
 <0d2e5085-32ff-e86e-d628-6000071fd132@kernel.dk>
 <20190206010104.GV2217@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <608c1102-5818-e38c-cfc7-b1cec5a1ecb4@kernel.dk>
Date:   Wed, 6 Feb 2019 10:56:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206010104.GV2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/19 6:01 PM, Al Viro wrote:
> On Tue, Feb 05, 2019 at 05:27:29PM -0700, Jens Axboe wrote:
> 
>> This should be better, passes some basic testing, too:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=01a93aa784319a02ccfa6523371b93401c9e0073
>>
>> Verified that we're grabbing the right refs, and don't hold any
>> ourselves. For the file registration, forbid registration of the
>> io_uring fd, as that is pointless and will introduce a loop regardless
>> of fd passing.
> 
> *shrug*
> 
> So pass it to AF_UNIX socket and register _that_ - does't change the
> underlying problem.

Maybe I'm being dense here, but it's an f_op match. Should catch a
passed fd as well, correct?

With that, how can there be a loop?

-- 
Jens Axboe

