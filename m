Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06589C433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE4F206A5
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="mOqFNUsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406838AbgFYTxg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406798AbgFYTxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 15:53:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81542C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:53:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s28so5162427edw.11
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fGJN00+oSs5u74cinEnWXytzJqtOzHTgYYmqXopZTb8=;
        b=mOqFNUsyhTWNshKxsHdT4zr3toXZGKzfZVlq8LeuRbD1PLu52ZWTAptL85XBbNSnaL
         WBafXfN8pWShB9WJ0heViTx9XVTsEGQCcw11pY1cKusCgoFh3TS+qbaLSj6VroktC7FC
         iTd8RDRcx20GoaL764vMekZkVlJPQOT25r2aAwSgPZLq1wvQmNCCRL1HPjJFNfnrbvx1
         CyOx6K33PZI/+ro3kwudu0HSw9jW5vDEfEOsBhnK1cZJ/549w6ZsWxAdw7uaZK53U/C/
         Br7W5n4QkTEBiL4qKvvOHgnnBS4yJEhYRT+z2i348mGf3DO9+6tv0zDmUHRawGNZOlZt
         bWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fGJN00+oSs5u74cinEnWXytzJqtOzHTgYYmqXopZTb8=;
        b=lmuMraEZvGsQfbB5Jo1/ldUxfQ5VFqWKww+zV7fYhCopdPOjcnpvHrZYHXhoRW75X0
         q5kgPZQFhRNyUuuW4ATtuPR5BWzyJigIf0jmoQeSR22A9IGWhUXxPL4y0mqZWI5uR/nr
         WZgS9D1BRMWwWjzotAncqIQ6fiSQ5nYYFvqYgHeNImB1Veg1jd1cyrYc6b7fiaLYCm1F
         KVfPyHAolYQ/6WHoASQQZb14YNJXBoZp+ZSXl7l28HYKPMiztCasEU6ZfU/aUcNaYL8j
         6tT7Hy9xPf/5aNKc7FO06QcoJ7+7dwoDk3CP/k9AIuBZYGQPLPYBBQLfAfT4grx6Dz+w
         u1Qg==
X-Gm-Message-State: AOAM533xJQ61KtiFz9ewqVDAxIhQBBxgvEgA++Fs1GhKz9hSG+bROeBF
        Nj6SscVS+oHkZ6TA34TA+1nD3w==
X-Google-Smtp-Source: ABdhPJyGscUstxDAe5xUnqJJ/piEgiYlLdTbyUbPNQMyRWwv4oQGF9SY3WdjZuKlHYHup47cypauoQ==
X-Received: by 2002:a05:6402:22f0:: with SMTP id dn16mr28524979edb.83.1593114814126;
        Thu, 25 Jun 2020 12:53:34 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id lj18sm9744723ejb.43.2020.06.25.12.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 12:53:33 -0700 (PDT)
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
References: <20200625122152.17359-1-javier@javigon.com>
 <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
 <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
 <20200625193929.eitl3th2mn2mlxu2@MacBook-Pro.localdomain>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2c075399-36ff-58bc-e29f-36157c852e05@lightnvm.io>
Date:   Thu, 25 Jun 2020 21:53:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625193929.eitl3th2mn2mlxu2@MacBook-Pro.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/06/2020 21.39, Javier González wrote:
> On 25.06.2020 16:48, Matias Bjørling wrote:
>> On 25/06/2020 15.04, Matias Bjørling wrote:
>>> On 25/06/2020 14.21, Javier González wrote:
>>>> From: Javier González <javier.gonz@samsung.com>
>>>>
>>>> This patchset extends zoned device functionality on top of the 
>>>> existing
>>>> v3 ZNS patchset that Keith sent last week.
>>>>
>>>> Patches 1-5 are zoned block interface and IOCTL additions to expose 
>>>> ZNS
>>>> values to user-space. One major change is the addition of a new zone
>>>> management IOCTL that allows to extend zone management commands with
>>>> flags. I recall a conversation in the mailing list from early this 
>>>> year
>>>> where a similar approach was proposed by Matias, but never made it
>>>> upstream. We extended the IOCTL here to align with the comments in 
>>>> that
>>>> thread. Here, we are happy to get sign-offs by anyone that contributed
>>>> to the thread - just comment here or on the patch.
>>>
>>> The original patchset is available here: 
>>> https://lkml.org/lkml/2019/6/21/419
>>>
>>> We wanted to wait posting our updated patches until the base patches 
>>> were upstream. I guess the cat is out of the bag. :)
>>>
>>> For the open/finish/reset patch, you'll want to take a look at the 
>>> original patchset, and apply the feedback from that thread to your 
>>> patch. Please also consider the users of these operations, e.g., dm, 
>>> scsi, null_blk, etc. The original patchset has patches for that.
>>>
>> Please disregard the above - I forgot that the original patchset 
>> actually went upstream.
>>
>> You're right that we discussed (I at least discussed it internally 
>> with Damien, but I can't find the mail) having one mgmt issuing the 
>> commands. We didn't go ahead and added it at that point due to ZNS 
>> still being in a fluffy state.
>>
>
> Does the proposed IOCTL align with the use cases you have in mind? I'm
> happy to take it in a different series if you want to add patches to it
> for other drivers (scsi, null_blk, etc.).

I think the ioctl makes sense. I wanted to have it like that originally. 
I'm still thinking through if it covers the short-term cases for the 
upcoming TPs.

