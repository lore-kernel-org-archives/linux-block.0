Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34551C433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 23:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF5364E63
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 23:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhBQXLZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBQXLX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Feb 2021 18:11:23 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0EC061574
        for <linux-block@vger.kernel.org>; Wed, 17 Feb 2021 15:10:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o63so9470462pgo.6
        for <linux-block@vger.kernel.org>; Wed, 17 Feb 2021 15:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wA4XwYh+wHKKd16pOOn5qhq//bzGCZsvMloL5aDv8r4=;
        b=tinze7EzOEpzWCux7wt/66cTgJhc9Bgdd3A6uKnSGsQ+RNtQW3cLOei+Zw4MgyMSJ6
         Lfw+t+dRjiGOLmd84ouSQUQeYV6TJeMpAKrO+iiFUssKGOFQPZmxEkHqUShJru1teUSt
         uzj/H3TaKcakJ61Qy6ETwxJMVpNUNjiquQxRRN8BfqMj9AjOo5e48X9y+0TfpElx6WNt
         tPZXmLR3d2sbcjetzaoh8vYrCP8X9UZNkdV83j8NWssf/zW0twV1cxXDvhT/b2XlPAKs
         qaFDxWQX7yEnHme2mFqALnzKwYoM99sKCB+xLdpUDa/gJeFAYKS876MPrKDUwcJN/zDe
         Q/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wA4XwYh+wHKKd16pOOn5qhq//bzGCZsvMloL5aDv8r4=;
        b=e+Ljt7+mpeto9qo1b2qEKqAmaDNVTHyzi5iTLiZNRh9w501717JD/3RGlQNwBHqXoX
         WMvYdM/+fudG+vS2WmxOtYyzXkT2sP3lbADVqEraz2XaiRnG94850VzEDsgn9Uz3lnNW
         MTItPXzwIM98gd00jpLQw2Sfm3oC+ArxzAd6a71hLoxZU3p/vsiAgdXB8n2cFmzsh9ct
         EOV/xJTNM0nwDMeAmU3pN/Fxoq5zZRpJ/ulcP9bIs0mRvkrFgc0zagZbwPkcROOUbF1A
         oQrh8kPsIle/wsPPt3nz4SuBWsdW95vIqooDyKzNPeiN7gAIC35V9oHddmD1vpWDmFu3
         6NwA==
X-Gm-Message-State: AOAM530jfxiSDx0oUQSebXJ3mjVKZh4wGRdILliCRlKAX2fmNBMvQjLE
        eWgRVSyvQ+/dyIqDc4aSv9omTEP6uzmXuw==
X-Google-Smtp-Source: ABdhPJwiCtYmby5qpZKG2OfGnI/U07yuLNIThS3SLlOEkHgtbqrot4kCfR3H656hX6BxzuIt6DeKhw==
X-Received: by 2002:a63:b55:: with SMTP id a21mr1445222pgl.409.1613603442108;
        Wed, 17 Feb 2021 15:10:42 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e1::19db? ([2620:10d:c090:400::5:5c48])
        by smtp.gmail.com with ESMTPSA id a24sm3821276pff.18.2021.02.17.15.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 15:10:41 -0800 (PST)
Subject: Re: [GIT PULL] Block driver changes for 5.12-rc
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <2026e767-054e-00ba-46bd-716eb827a600@kernel.dk>
 <BL0PR04MB65148E7A098A395694E93EDFE7869@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9884d35a-489c-9b04-6d47-bcb7a7e44e5f@kernel.dk>
Date:   Wed, 17 Feb 2021 16:10:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB65148E7A098A395694E93EDFE7869@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/17/21 4:09 PM, Damien Le Moal wrote:
> On 2021/02/18 8:02, Jens Axboe wrote:
>> Hi Linus,
>>
>> On top of the core block branch, here are the 5.12 driver changes. This
>> pull request contains:
>>
>> - Removal of the skd driver. It's been EOL for a long time (Damien)
> 
> Jens,
> 
> Looks like this PR is missing the patch to revert commit 0fe37724f8e7 ("block:
> fix bd_size_lock use"). Will you send it later ?

Yes, since that's not applicable before both core and drivers have been
merged.

-- 
Jens Axboe

