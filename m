Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237FFC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF0E2054F
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hkFlMfZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF0E2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeLGQY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:24:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54028 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGQY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 11:24:57 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so7711784ita.3
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vkM/Cy0+xCGuwkGgvZ0UnR6aj7kpMWOy82Cs4iHY+e4=;
        b=hkFlMfZZ5dg+2PQycHpsFw+EiXjDQ6oWHY2IoVwJyP7DnXm4sm+b6i338p/cWACXcE
         REcoxV9eHmJ4gFObDcAdd+BHLgJM0ZWrxonYOo1rDtgkRtNvCBn86U+SZ3TYOOW9ZBjc
         jV7AgW2maZXyu5LA7ybWeEXtMcJNi0eMliRSGW97vi5PMOrW9JxEeIgrcmZUyW2MCXbQ
         yFVikDLD2iSdInA+Jk0Gpt06/N2FH4gJ1oWgyLjac4AGLRemBHzwEfA/47j5izhNCuLN
         tBo/NctylqMUW9sLcPO9HhTGwm2M5knfb0LvFkzKc1voaFQJEnfWpgSFGqrNuKTTNTMk
         Fcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vkM/Cy0+xCGuwkGgvZ0UnR6aj7kpMWOy82Cs4iHY+e4=;
        b=o3skXcmE86CT/Q0/0AL4kvn63RC0CkXwbRfL94ATzh+pefuftEg8UQ5NX0VJNMj7bP
         ubIEXIZfIDEfUlEDQvFyvA3DHMHJZoQetM/+z3fK6AAF6smARUBdyVqZy7VMCtMv9uos
         ggwryoSsI0+iv7K25X1yYgEwciF8TYXjWOZi094FgcxivOVSpeIs8SaVzLoFIpdeFopW
         LYIdwu/+Io37CueCuTE2OJr4r//RyoxamBmVQf1WMAQY9lnixOOao8p668wd5ztfxdoA
         tHi0wthYPtlnQuyQSAfwrzuQ3FRc9+nHA0FlhoWrNP3uctO2E8Mk7g7knd1E6Uwm3hLr
         1xpA==
X-Gm-Message-State: AA+aEWZj42PlZwkZXvgdwF/xVJKQSqXX7QJDc3ZMz6VmTAzXyHddLKmi
        4U/acqMAjt/cMVwSP6XQCXp/FQ==
X-Google-Smtp-Source: AFSGD/W1eDcQJBOS1xk1vzQznK7wRwZKFMMS0zBp0pIqJ4Q0Aval7jofT2DxIUPvY5c6gjWXheolrw==
X-Received: by 2002:a24:c40b:: with SMTP id v11mr2445637itf.73.1544199895780;
        Fri, 07 Dec 2018 08:24:55 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 72sm1842627itw.16.2018.12.07.08.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 08:24:54 -0800 (PST)
Subject: Re: [PATCH v3] blk-mq: punt failed direct issue to dispatch list
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
References: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
 <1544199585.185366.303.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <693ac87a-ebb5-2e4e-25e5-92a1d3865c8f@kernel.dk>
Date:   Fri, 7 Dec 2018 09:24:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544199585.185366.303.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 9:19 AM, Bart Van Assche wrote:
> On Thu, 2018-12-06 at 22:17 -0700, Jens Axboe wrote:
>> Instead of making special cases for what we can direct issue, and now
>> having to deal with DM solving the livelock while still retaining a BUSY
>> condition feedback loop, always just add a request that has been through
>> ->queue_rq() to the hardware queue dispatch list. These are safe to use
>> as no merging can take place there. Additionally, if requests do have
>> prepped data from drivers, we aren't dependent on them not sharing space
>> in the request structure to safely add them to the IO scheduler lists.
> 
> How about making blk_mq_sched_insert_request() complain if a request is passed
> to it in which the RQF_DONTPREP flag has been set to avoid that this problem is
> reintroduced in the future? Otherwise this patch looks fine to me.

I agree, but I think we should do that as a follow up patch. I don't want to
touch this one if we can avoid it. The thought did cross my mind, too. It
should be impossible now that everything goes to the dispatch list.

-- 
Jens Axboe

