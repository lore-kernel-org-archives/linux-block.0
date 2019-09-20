Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D02C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E74F20665
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 13:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UEGHzk2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfITNFM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:05:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46922 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfITNFL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 09:05:11 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so2768252ioo.13
        for <linux-block@vger.kernel.org>; Fri, 20 Sep 2019 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5857UdtPy5LB2Qj3lCJ6EALsf9VjY4ozTOyQCCtBGw=;
        b=UEGHzk2GzwFGmTZh0bMvpjw+ZTxI4UuQ46JyhNc+Q7HgzhT1dG+11UmOyBzCpzQY4s
         lk0MHF/15pJ7XjuqR2/lGIxxUGl9/8RAU8Zu5Q4+A87uAvB2t13t+QAbeQO1Q1fw1gBB
         ZKRFpb6au1iAuYTH0VI59bC2ky2zo+61KNrjyIPqi73XMkKrZgsxPm45Xx+1wRaiL1S2
         EHtqIVjnodF5mn1wkgbC470zLtNPMNlVg1obE8ddgNMN+j1iSUHapYTYLu1PtWAJJqQJ
         GQmXaQJEI/B66NhZgBExVjFcbXoSZMcvweZ9GTrE3E9tluhNTRhuaRzM1nZr/e08JnmB
         1pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5857UdtPy5LB2Qj3lCJ6EALsf9VjY4ozTOyQCCtBGw=;
        b=mRGrO9MuV3rwt1fCc31GnAGPYIXq1oZwWzp2dp+jEwqx7BmRSttTJDr7+fB/wwHMcD
         VAWv3to0OhyHEXVy2NDEf0MaygKFX7zJ9L6wg9xTYs+7vtvQyhmr8nv1gRI2T+UijtKr
         UcdKFJKnlTQ26U3NcUMKkNNLbMBWJfMWDQbOxsghfagAKy6sh5h7gHziC2Z1O3JIzoER
         SyMMZOY6vd7+zyYX5R38ad7XdBJSRomiUk27YdSnc7tjLwjJkdiCk6ZmpYnBSShvu+Wn
         sPenaptRpAvOEnP8LiUmOVjV9ZVIg6zIqp+uOzLGhaV9Gy5Yp1l8OhKhspEdnT8aQydk
         +Rwg==
X-Gm-Message-State: APjAAAUlzXduLAo5ZzMcejvyDn23IOcBN8G4PmfrpwObI1mzFncCSMPu
        chkfoKQXpPgLa13DdVksy+4T3Q==
X-Google-Smtp-Source: APXvYqz5yXouKOTZlRsl2vibdMPIsushtwZaeMaqyPL5+VKJgbmnNBDavKKhox5RFzmBV1D/zcgCHg==
X-Received: by 2002:a5e:8218:: with SMTP id l24mr13613162iom.56.1568984709226;
        Fri, 20 Sep 2019 06:05:09 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m5sm2293192ioh.69.2019.09.20.06.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 06:05:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
To:     Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org, Angelo Ruocco <angeloruocco90@gmail.com>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
 <20190917213209.GK3084169@devbig004.ftw2.facebook.com>
 <4D39D2FA-A487-4FAD-A67E-B90750CE0BD4@linaro.org>
 <20190918151948.GL3084169@devbig004.ftw2.facebook.com>
 <4F416823-855F-4091-90B9-92253BF189FA@linaro.org>
 <A87FEC8A-3E1A-4DC8-89F7-5FAF63CF5B47@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de7664b1-6f47-8a7b-b231-727336c0ef85@kernel.dk>
Date:   Fri, 20 Sep 2019 07:05:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <A87FEC8A-3E1A-4DC8-89F7-5FAF63CF5B47@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/19 12:58 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 18 set 2019, alle ore 18:19, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>>
>>
>>> Il giorno 18 set 2019, alle ore 17:19, Tejun Heo <tj@kernel.org> ha scritto:
>>>
>>> Hello,
>>>
>>> On Wed, Sep 18, 2019 at 07:18:50AM +0200, Paolo Valente wrote:
>>>> A solution that both fulfills userspace request and doesn't break
>>>> anything for hypothetical users of the current interface already made
>>>> it to mainline, and Linus liked it too.  It is:
>>>
>>> Linus didn't like it.  The implementation was a bit nasty.  That was
>>> why it became a subject in the first place.
>>>
>>>> 19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight cgroup parameter")
>>>>
>>>> But it was then reverted on Tejun's request to do exactly what we
>>>> don't want do any longer now:
>>>> cf8929885de3 ("cgroup/bfq: revert bfq.weight symlink change")
>>>
>>> Note that the interface was wrong at the time too.
>>>
>>>> So, Jens, Tejun, can we please just revert that revert?
>>>
>>> I think presenting both io.weight and io.bfq.weight interfaces are
>>> probably the best course of action at this point but why does it have
>>> to be a symlink?  What's wrong with just creating another file with
>>> the same backing function?
>>>
>>
>> I think a symlink would be much clearer for users, given the confusion
>> already caused by two names for the same parameter.  But let's hear
>> others' opinion too.
>>
> 
> Jens, could you express your opinion on this?  Any solution you and
> Tejun agree on is ok for me.  Also this new (fourth) possible
> implementation of this fix, provided that then it is definitely ok for
> both of you.

Retaining both interfaces is arguably the right solution. It would be
nice if we didn't have to, but the first bfq variant was incompatible
with the in-kernel one, so we'll always have that out in the wild.
Adding everything to stable doesn't work, as we still have existing
kernels out there with the interface. In fact, in some ways that's
worse, as you definitely don't want interfaces to change between two
stable kernels.

I know it's not ideal, and some better initial planning would have
made it better, but we have to deal with the situation as it stands
now.

-- 
Jens Axboe

