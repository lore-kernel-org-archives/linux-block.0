Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FDC433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 02:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F83061937
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 02:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhELC4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELC4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 22:56:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0AC061574
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 19:54:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 10so17639002pfl.1
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 19:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NYV3v2B5SOCRJ/sEBBuMPyQsLiSkHeAecHDVVcuPNII=;
        b=M7UG3BnjOSVEhTF+Z05R1Z05XduD7s/mF0xiFT1ZOSZhZmuNo1y3bxg9wyPXPxbtv9
         qufOW1Gw6p9RQVtKmzNy7+wTVlyOQOr1dApeRdoHVAbZNX2ZyMjDvMRMNtVje1prby+F
         5Vcxw1EfeOO/6BbOpXkqKyQCKlMjLokJTSCyakfstNV+YZH7rOcObtgrtUtJYWzGS8dB
         Sr2V3Ty1tHwvTwgD5uX4Vr7vmRJGBqHTLnPMogXYYMchCP04MRbSyHkakkZjfN9uOFbx
         sIl/6eUOsUyMGN8VflBdQjsCmbOR114TEh5cGwK5Q8AwW8UwBIcfWhW3DmIr54r0+ddU
         jWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NYV3v2B5SOCRJ/sEBBuMPyQsLiSkHeAecHDVVcuPNII=;
        b=kneduNQzvZybSP+a1BZz7Iv0ZeaAby+uEELmBRpJNuTfVyPnqIF5zrIcBm+Yvjxq35
         Cgvr6NmMBHTctoTigoIwXzVIlu2BQLSNl0kIdcNfFwrHP0FxoAkc0h/VkvsL6sTN7Gw3
         qh634+Z3081vwYS3lNFyWZlktbPHFGaQgjkV2FD43Rf2PS22stKq4LGpFJ9V9U4cU+VF
         f0AvnLIbrWpGmNzuln+bLWKVPeIyV1OyqH0Ujr4HlI2xAXcoT+bxFhHk/9Y2mpVIRlL9
         VVis9kmqL3vG7xOmbMDglu9YRKktTwksxogdXeZMwqUlL3OyJBSosXr5l1iB8VxgHTW/
         5aqA==
X-Gm-Message-State: AOAM531YIjK4oxLjbAuADrC/OE/+lHOH6XZLBsXRel9FF378kxtjs4j5
        AFB5SK5GiEQJIjlB20CZ+K4mpw==
X-Google-Smtp-Source: ABdhPJw0ILzs0xM8QxYf0JbnCtDwiyO2nX5p0ggJ3wZslisMyrQlKjbTyWna7BUBVLv2OQLQdCleoA==
X-Received: by 2002:a62:8804:0:b029:253:6745:908c with SMTP id l4-20020a6288040000b02902536745908cmr33127774pfd.16.1620788098631;
        Tue, 11 May 2021 19:54:58 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id j27sm15178516pgb.54.2021.05.11.19.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 19:54:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: remove unneeded parenthesis from blk-sysfs
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <20210511155319.1885277-1-mgurtovoy@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f339892-4d25-e870-258f-525c99f691e7@kernel.dk>
Date:   Tue, 11 May 2021 20:54:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210511155319.1885277-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/11/21 9:53 AM, Max Gurtovoy wrote:
> Align to common code conventions.

I think this is a remnant from when they were macros. Applied for 5.14,
thanks.

-- 
Jens Axboe

