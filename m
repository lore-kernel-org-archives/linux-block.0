Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE4C433E6
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 20:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB97F64F33
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhCRUnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhCRUmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 16:42:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09704C06175F
        for <linux-block@vger.kernel.org>; Thu, 18 Mar 2021 13:42:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m3so2213436pga.1
        for <linux-block@vger.kernel.org>; Thu, 18 Mar 2021 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DWaSlg6oRWJqHUVbQpRW1jMSvQBI7bpCNdpPwyZ5tv8=;
        b=E5IBzCjxOylBWqbMJk+0k7tNFv+BhGw0bpB1rKkTnMVqomQZgrru2n5DE2ak1zFWw8
         vsL2fzTeU0zdwAvpDPu+D0nLASjWg5UgVDAklH3niWuqWsmxPqBRc1Nr4kUmZhZlHn/7
         u+P5qyDz5QnR2KiC9QqPCvboQAkGrsK6wq0EiLm9H0zUFoLxTIDjCn59Mzz1ifddar11
         zvIHPbQMNB+DePF0PU5tQ7sytS4dRaibhDjUZpIg/sZiel+Udaudzg8NEXzZVNBW88jZ
         wz5GXmV1P4GAOuj/7frp5jycae+fNSOslqw37zcLJ5HyApHwfRBLtiSLiBD6SGCMSDv8
         +v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWaSlg6oRWJqHUVbQpRW1jMSvQBI7bpCNdpPwyZ5tv8=;
        b=eelnOTOhh/Wl4+dNhzCKSUYOfJ51xVb4Z0JEa+yq11sJQfJBhgoME7Hq4WIKnFuIyz
         wvCnZvKj60Ym+onD2NOk+E/4NcF1zEvYdzmcwrnEj/9wr7trLgPmoSLnn1KnJn7fvPXQ
         Bq/tUFF2Zs6zlan6LLLzZz/PX7q5umSh0mwIT1WzbjZy5Fmm9w2oKdtfclPkudjU2q4z
         gruzFRl1BUKk06dr7N/sGfjsaOtfChcRqCPVhyxEgErO8GZ97WL6kcvL5AHrTTM99XE2
         s3PcyUn55k/fXJuSt2ZD3z9pS0b0B1wxwiOrYR9qvvfFxzs6UJfn73puOqNIKl+UV3U6
         A0aQ==
X-Gm-Message-State: AOAM532mVvuXW7a5O44+LaGKl3eFAc1HobYMhnr5ZBc0ndiX8U4JuT7Q
        HIINOCT+pfWNYqjb/mgkvAqabg==
X-Google-Smtp-Source: ABdhPJwottvNmX24kN/kLJmNJK5xak//3AaeHe0lM3N2xPXIsboak8d6CXZqWF+UEXJWS8xIonsk1w==
X-Received: by 2002:a63:905:: with SMTP id 5mr8396543pgj.337.1616100156472;
        Thu, 18 Mar 2021 13:42:36 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gm9sm3078201pjb.13.2021.03.18.13.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 13:42:35 -0700 (PDT)
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
To:     Colin Ian King <colin.king@canonical.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318151626.17442-1-colin.king@canonical.com>
 <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
 <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d32641ca-e34a-2bfd-9b86-28c95546f434@kernel.dk>
Date:   Thu, 18 Mar 2021 14:42:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/18/21 2:24 PM, Colin Ian King wrote:
> On 18/03/2021 20:12, Jens Axboe wrote:
>> On 3/18/21 9:16 AM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The 3rd argument to alloc_workqueue should be the max_active count,
>>> however currently it is the lo->lo_number that is intended for the
>>> loop%d number. Fix this by adding in the missing max_active count.
>>
>> Dan, please fold this (or something similar) in when you're redoing the
>> series.
>>
> Appreciate this fix being picked up. Are we going to lose the SoB?

If it's being redone, would be silly to have that error in there. Do
we have a tag that's appropriate for this? I often wonder when I'm
folding in a fix. Ala Fixes-by: or something like that.

-- 
Jens Axboe

