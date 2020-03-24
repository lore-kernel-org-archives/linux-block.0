Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80978C43331
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 16:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AB420775
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 16:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3mvgmp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgCXQv2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:51:28 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38036 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgCXQv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 12:51:28 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so1711552pje.3
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2020 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hpNBEA5Ss5EiH/7nWCn4791OQ+bRfXtk241A28CxB38=;
        b=C3mvgmp6onD93YzirKUR6rAQJKLbihfc4LW59rZuk8P22ldjO+6nUB1iyw91rLG038
         7A01+u0EmfuNCBmrzOjPe+xa3FJg14VoRESzy605+Ne+f93jPBVrbTdm2FfD4vnd0Frf
         q8JEPtfSCkfKLjpmGuftVF7NpIZfkQSE+MaTBD2RMlo4Ud0UY0/kSxkXmoWGUXRgKjeE
         FG8+L/YmCkm5Pv5tbJrNS9s+iK4g03dquN+dMBtWSFzdzJDHDkDsaMCbbioJA373CzJF
         6VFzWGdjrzZrWiowNSPwT6iThh7Mbu6nZ68Hx4o3/PawdJcYPxymHXNvocy+3k5lQIu0
         pjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hpNBEA5Ss5EiH/7nWCn4791OQ+bRfXtk241A28CxB38=;
        b=G79T2etHxh8XeGk2LEaYfk9TO1OsmHdLgt+1z8AodFs89s7gJkhXJAdEDOLVybTCDA
         vtjFbsNntZPxH/5JCIgBYy9oalzKU0jPdQ6c9FaxoBxr2BeREWvhOu37oUdB96+0Y4TY
         QIY6dqPqzh+jw2+0S45TZWRd5Zt9DZ3HEtm1DBLOZACYTdunqkTvvzep3qbUJpCAdtrr
         N/j+1D+No/wSuBBWVAp8egYD6LJml3JPBZM1U2oQf5/YRf8G74Eo41FfBMJtOSGxp6Ge
         124ZlmCV1dgMHwKl4wjORE+I62NdBZz2+9DoGNA7knEaMxkerEHqPQajPxQER4cJDFKF
         A+gQ==
X-Gm-Message-State: ANhLgQ2ruYWjLqNQWDsQZ2hgiv1TLyvg+DRkPIWXu4z22W6AaBaHY9+y
        oihOJa0lf32ZBhJEd9IFusXbjak6
X-Google-Smtp-Source: ADFU+vts5r0e6B2HJowp9EKGkXmm0jmQzBBRpAhlkCo5C5JxxPGHyK/s/7DCHGuINI5+oSryJxNseQ==
X-Received: by 2002:a17:902:868d:: with SMTP id g13mr26479470plo.317.1585068687379;
        Tue, 24 Mar 2020 09:51:27 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a? ([240b:10:2720:5510:a182:288:3ffa:432a])
        by smtp.gmail.com with ESMTPSA id m11sm2739481pjl.18.2020.03.24.09.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:51:26 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
To:     Keith Busch <kbusch@kernel.org>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
Date:   Wed, 25 Mar 2020 01:51:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2020/03/24 9:02, Keith Busch wrote:
> On Tue, Mar 24, 2020 at 08:09:19AM +0900, Tokunori Ikegami wrote:
>> Hi,
>>> The change looks okay, but why do we need such a large data length ?
>>>
>>> Do you have a use-case or performance numbers ?
>> We use the large data length to get log page by the NVMe admin command.
>> In the past it was able to get with the same length but failed currently
>> with it.
>>
>> So it seems that depended on the kernel version as caused by the version up.
> We didn't have 32-bit max segments before, though. Why was 16-bits
> enough in older kernels? Which kernel did this stop working?
Now I am asking the detail information to the reporter so let me update 
later.
That was able to use the same command script with the large data length 
in the past.
>
>> Also I have confirmed that currently failed with the length 0x10000000
>> 256MB.
> If your hitting max segment limits before any other limit, you should be
> able to do larger transfers with more physically contiguous memory. Huge
> pages can get the same data length in fewer segments, if you want to
> try that.
>
> But wouldn't it be better if your application splits the transfer into
> smaller chunks across multiple commands? NVMe log page command supports
> offsets for this reason.

Yes actually now we are using the offset parameter to split the data to get.
For a future usage it seems that it is better to use the large number 
size also.

