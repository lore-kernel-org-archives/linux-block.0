Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45CFC433FE
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKSBOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiKSBOK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:14:10 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB416B9EA
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 16:12:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 8F2422B05A6B;
        Fri, 18 Nov 2022 19:11:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 18 Nov 2022 19:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1668816709; x=1668820309; bh=Zh0+uHjgzY
        D7ldqTEsbNdbOwiFL6yteWUBYRj+CHcgI=; b=rNSOHdLHJDT+FAS3o7AFaN7RrI
        U5G3OqxCI6R32QYiSVFC20y/pcozVLtPoaZhBxvqS7FfwL8rm9nB6tqOvUc9B7F0
        X7+JcHlttK3gXf5BahGK3tyaSf/rHrMscN1K52hP4czWkF11tg8kMn9PEo8DN0xA
        01fHZReI4WBFk8JqthPiwnR3bwnSrb821N3Udr3ddVE9TBpzl2qcpKGQGkp/GrjR
        koaiJS2+rji1932HaM0S0rZa7FthmR+5QzMGK70h1F8w6boovmle3KBqMi1iA3Jz
        yiJsp/Y8ZR4lKrWjJ5p6vh1yRyg8/Ubl9LHmTYcvDbjPGUU4VfWf9Vqx/8yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668816709; x=1668820309; bh=Zh0+uHjgzYD7ldqTEsbNdbOwiFL6
        yteWUBYRj+CHcgI=; b=o9yHfHMWbXgOisMI++TPg78I9D8JT39PhWE2KJwQ7Xib
        JBmHJW2/XR0TYJMMFSDezAegORGZW3vgRdDfPZ2km8lBZAPk8PFIZ0ObVrEPERNZ
        6uLTD1KUMCRgbXfyxyVqvFsf0gQ02wCV01wOHIPPk+kFTtiL+WZJ5QqmMij8Fbym
        kTXRIAgGCIfucM6a0OYOyqoFdzNc7G6Ji1AktkakqE7GZmCdzbU2eIPxvgARlHU8
        d+s3NE4r4Kv4dPXdrR54nGCkHE3feu/5JLybsT0zGSqJVNUL9QmpdoXvy111/3Ne
        ZRoYx9W8QEq40BSbA4NORvdCwF36oUQgSXF4D2zfAg==
X-ME-Sender: <xms:RB94Y2FIlJnFBeLH65LR4DrcV0YEBGUsKjn4TobFW5LJod4nBCegEw>
    <xme:RB94Y3UTjLwo1ePSb2pIZyQ-mlVLYqdJeVvRJKTCMky_aFWCWPuaB2jp21J3JuroC
    Pya4-vEmAxFUkJnkx4>
X-ME-Received: <xmr:RB94YwK_W34PjLXPtOdKJ-_AH-CmC_9KUK7G2MBrtv6CMm5vAHb7VWhKu9ArLxPfnMza3vLQMC9UdDEC6ojVo-YCcjAxEBMd2qPSs-J_Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedugddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesthdtre
    dttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgv
    rhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhedthf
    etvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:RB94YwGMZ1FHsUh_IsKxLWqgLyNwCc5WOYWUiD48Rkryp4g1P8w28Q>
    <xmx:RB94Y8VGD9xJrnhhvZuwFdXAcLiCgHZv5ITPtpmFYSyR5waofdkkBA>
    <xmx:RB94YzO8mAAB8xknEB7xCcmeYbftr51PJxTEmGl7vyDuXhNCgT2KQg>
    <xmx:RR94Y-KHmP7d6_yHpoGS1kE2VfZIIaALbAbVfk-uZSK5HdBrMuoZnBVsYrc>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 19:11:48 -0500 (EST)
References: <20221024190603.3987969-1-shr@devkernel.io>
 <20221024190603.3987969-6-shr@devkernel.io>
 <20221116132904.516884bc7eec135cfcd326a7@linux-foundation.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 05/14] mm: add bdi_get_max_bytes() function
Date:   Fri, 18 Nov 2022 16:10:43 -0800
In-reply-to: <20221116132904.516884bc7eec135cfcd326a7@linux-foundation.org>
Message-ID: <qvqwo7t39519.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 24 Oct 2022 12:05:54 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> This adds a function to return the specified value for max_bytes. It
>> converts the stored max_ratio of the bdi to the corresponding bytes
>> value. It introduces the bdi_get_bytes helper function to do the
>> conversion. This is an approximation as it is based on the value that is
>> returned by global_dirty_limits(), which can change. The helper function
>> will also be used by the min_bytes bdi knob.
>>
>> --- a/include/linux/backing-dev.h
>> +++ b/include/linux/backing-dev.h
>> @@ -105,6 +105,7 @@ static inline unsigned long wb_stat_error(void)
>>  /* BDI ratio is expressed as part per 1000 for finer granularity. */
>>  #define BDI_RATIO_SCALE 10
>>
>> +unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi);
>
> We don't use unsigned long long much.  If you want a 64-bit unsigned,
> use u64?
>

The next version will use u64.

>> +EXPORT_SYMBOL_GPL(bdi_get_max_bytes);
>
> Is this symbol to be used by modules?

The next version will remove the export.
