Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B089C10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 16:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A16206BE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 16:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ekad0ujQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgCMQdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:33:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42865 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCMQdz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 12:33:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id t3so4495133plz.9
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2020 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WAR+PkLDpelAyMosPtmZsR2DY8lTDEGC8Cnq0G4FpWw=;
        b=ekad0ujQqTyM8XjVO536NS3sIeuSxFA/F41Mw65cxyDS9cZKNNcs9pRlagr/CUx3iw
         taZpfgdZpvfS2GcoPx7ZI2VBoA+BxPxMujhAb0BIturXJ9LHOPmJcJENkF2yLfNMtwxQ
         wIt9hjVDdENj6u20oBtRmvCugARLDbwe+6gsODq+AHrNz4UBDtJxKGx4IfS+VhgGI0sK
         537KjluGxyeVD+13Vd8Qckl3BV6u9TOlVmNf7hJap4I9C2idSr21n6+bezY1f+sICsJc
         ZtLkbO3bcRqRxZTbllcMBwVZz6xg2zeQozrlHPCf27K5moJgcy2v+u0dDCU8mnnCywKu
         +BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WAR+PkLDpelAyMosPtmZsR2DY8lTDEGC8Cnq0G4FpWw=;
        b=MfCVuT6rSlYgfIy0P910ubjuVah3epbgss035SU5pRZpCjnV1735nKOrM6R3bj9kbh
         8mI5xGrW6e96QOlrjnW6FEoZE+rZ/2UOquwSqjWwUEP7l35xdPR0Tf/v9XaW02jFoWvy
         3ZLdwc3CnAcf/kDjrdnwk9rZhOvYNaJ82OsDzmZfWuC2q+ldfzmVxcUopmjwJclIvz+G
         feXWxtzfC8+4N5K0dmiJnLY60tLb4Q7lpUVz5rllCTJK8KhRxVOJLdu4p9y6+08OfRV7
         Ps7iW0DKev/IA+85exzhSJVV5dQ7fFpVv3tTl6LV9j7q1UndjTniCi92IzmsLiveKX7k
         m+bw==
X-Gm-Message-State: ANhLgQ0XsAmwbAekKPTFlcdxRv7+9P33svdnCRa2XYQ749gxkDPVt111
        OQLzgDvJlonU5jFKkRIpEY+jUr8QJJkSMg==
X-Google-Smtp-Source: ADFU+vtED5IJFacAk1l5ExiG3s4LIvkZESOeeGu/rHDVQMElW0uhlXQ8y+neRwJRA+Vxiug3rnQuhA==
X-Received: by 2002:a17:90a:d34b:: with SMTP id i11mr10044454pjx.180.1584117233645;
        Fri, 13 Mar 2020 09:33:53 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id e14sm8027009pfn.196.2020.03.13.09.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 09:33:53 -0700 (PDT)
Subject: Re: [PATCH] sata_fsl: fixup compilation errors
To:     Hannes Reinecke <hare@suse.de>
Cc:     Guenther Roeck <linux@roeck-us.net>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org
References: <20200313151722.74659-1-hare@suse.de>
 <50f5c462-e68d-ad99-4a76-bb72a126d43d@kernel.dk>
 <04f74bbf-7957-2e79-5236-1f8ee0549d99@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d622aab1-33c9-2640-0613-18b90c939c38@kernel.dk>
Date:   Fri, 13 Mar 2020 10:33:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <04f74bbf-7957-2e79-5236-1f8ee0549d99@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/20 9:27 AM, Hannes Reinecke wrote:
> On 3/13/20 4:21 PM, Jens Axboe wrote:
>> On 3/13/20 9:17 AM, Hannes Reinecke wrote:
>>> Fixup compilation errors introduced by the libata DPRINTK rewrite.
>>
>> How many more are we going to uncover? There's no excuse for not
>> having even compiled this stuff, seriously.
>>
> Well, I did, but I don't have a full cross-arch setup here.
> Will be setting it up for any further libata updates, promise.

If there's something you can even compile test, you should (at the
very least)

- Eye ball those individual patches very carefully
- Preferably get setup so you can

Looks like basically all the files you didn't compile had stupid
errors, which makes me think that the rest probably did too, but
you caught those since they actually compiled. That should be a
very strong hint that you may have the same typos in those, and
that you should examine particularly those carefully. Mistakes
happen, but this just appeared to be super sloppy.

-- 
Jens Axboe

