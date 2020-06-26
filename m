Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA374C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E45920836
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="aiAK/tW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgFZG0T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFZG0T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:26:19 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33642C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:26:19 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e15so6044264edr.2
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k9vzA2Sgr7pZTav9AqdNguX09fGHlD9BrNDa/e+1XN0=;
        b=aiAK/tW03+8F8XcWg6QUOOejPQrGfXeQpyRHszENJXb4Az8CReLO3XnuzzPWD/4zsq
         VqwXo4N1AEkpu69+P+qom5+dqdQolsZZ4VQEQ1mT4JQq4Yte6GgwioX7P3QcQpNSyncd
         b4/yWkf6l7ifJCK7P0m+Vdg/haktCuqF3kTx1FBXHkNq9YwUzhjUy87uKAj++mYtzoS7
         28vT2joWqXA4zznXv1mDvHO2aJt2a3X16BzTDUvwj8JuPBroKXt+9b8EPY1WnwJlmk7U
         7fMbBxiaO9QXDrYwD3hR8SzUDHj1tDQ/z8NepEejgm9IZcPpJWDxzUFmY9jCuHZzVrtm
         Jl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k9vzA2Sgr7pZTav9AqdNguX09fGHlD9BrNDa/e+1XN0=;
        b=IRZcUlBswACM+522d9RNOwhTVcvvvz84M+w36LGuRquUwpUPV8jeChA1RAIixP9np/
         q1FAeCd0U2PfYK3F9Mf5G6BedPGalQo9wdNKfsGtWr8OM+MBki9hIKPBTwnZXwj1Skrz
         HUvGAGA7MQx/1R50UOBfRzRxTWNnLDw+YS9PozJ/+PukC+AxDmd0s7L213+Ox4k+HBoU
         ww+IPnhHd2QxxSpMXFBHkYZzE3uFXCDj9oBlZbpz5V/+RpybRe8CmojCzRDfW9ttOcfG
         Bh27nDp9vAe0GYummPmjUIYROTwzrInmLL1CuCxi3SW6mfdHf2KNi0sVMVNqNLCuZsv9
         egBQ==
X-Gm-Message-State: AOAM532hsbMVMSQdrjmahsodQ+KDRWZx6/NLF3UcyyC/utLcfGw189/L
        fJ+CTA8eykB70UiL+cSoSiyPgg==
X-Google-Smtp-Source: ABdhPJylJHZy0o/JgfVoIlK1EuAMe4WEPJl2gf3egNwYjEuDfbFAdP7iE8/9KPUp7EtmvxGBAunYmg==
X-Received: by 2002:a05:6402:1803:: with SMTP id g3mr1714657edy.377.1593152777854;
        Thu, 25 Jun 2020 23:26:17 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id q21sm18095668ejd.30.2020.06.25.23.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:26:17 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:26:16 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
Message-ID: <20200626062616.4xhaj6awtre4zxxf@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
 <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
 <20200625193929.eitl3th2mn2mlxu2@MacBook-Pro.localdomain>
 <2c075399-36ff-58bc-e29f-36157c852e05@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c075399-36ff-58bc-e29f-36157c852e05@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.06.2020 21:53, Matias Bjørling wrote:
>On 25/06/2020 21.39, Javier González wrote:
>>On 25.06.2020 16:48, Matias Bjørling wrote:
>>>On 25/06/2020 15.04, Matias Bjørling wrote:
>>>>On 25/06/2020 14.21, Javier González wrote:
>>>>>From: Javier González <javier.gonz@samsung.com>
>>>>>
>>>>>This patchset extends zoned device functionality on top of the 
>>>>>existing
>>>>>v3 ZNS patchset that Keith sent last week.
>>>>>
>>>>>Patches 1-5 are zoned block interface and IOCTL additions to 
>>>>>expose ZNS
>>>>>values to user-space. One major change is the addition of a new zone
>>>>>management IOCTL that allows to extend zone management commands with
>>>>>flags. I recall a conversation in the mailing list from early 
>>>>>this year
>>>>>where a similar approach was proposed by Matias, but never made it
>>>>>upstream. We extended the IOCTL here to align with the 
>>>>>comments in that
>>>>>thread. Here, we are happy to get sign-offs by anyone that contributed
>>>>>to the thread - just comment here or on the patch.
>>>>
>>>>The original patchset is available here: 
>>>>https://lkml.org/lkml/2019/6/21/419
>>>>
>>>>We wanted to wait posting our updated patches until the base 
>>>>patches were upstream. I guess the cat is out of the bag. :)
>>>>
>>>>For the open/finish/reset patch, you'll want to take a look at 
>>>>the original patchset, and apply the feedback from that thread 
>>>>to your patch. Please also consider the users of these 
>>>>operations, e.g., dm, scsi, null_blk, etc. The original patchset 
>>>>has patches for that.
>>>>
>>>Please disregard the above - I forgot that the original patchset 
>>>actually went upstream.
>>>
>>>You're right that we discussed (I at least discussed it internally 
>>>with Damien, but I can't find the mail) having one mgmt issuing 
>>>the commands. We didn't go ahead and added it at that point due to 
>>>ZNS still being in a fluffy state.
>>>
>>
>>Does the proposed IOCTL align with the use cases you have in mind? I'm
>>happy to take it in a different series if you want to add patches to it
>>for other drivers (scsi, null_blk, etc.).
>
>I think the ioctl makes sense. I wanted to have it like that 
>originally. I'm still thinking through if it covers the short-term 
>cases for the upcoming TPs.

Yes. You can see that some of this is intended to support at least one
of the TPs that are in the TWG. It is also suitable for a couple TPs we
are working on internally and expect to bring to the group.

But please, do make sure it covers TPs that you know will be shared in
the TWG.

Javier
