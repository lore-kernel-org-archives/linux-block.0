Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C2FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 21:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGOVrr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGOVrq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 17:47:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F2D2B247
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 14:47:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso7317813pjj.5
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s18Fllh+gB6Jtpr+Ov6lqWWsOKas/ShUMI9wmr9imiE=;
        b=kt2ywWzJguHIlFYeD1kzJ1YCEy1ZlJBGDyPxy8TwI9f5RYY+BhK30WiL6U/IcMv2zQ
         /1vRBVzoebzeb1euKSejpD5lA7OPINT6SkZ2Bk8ciZhnQzQkw96ZDM9XScicROT4ALHl
         YV/fq7jBURIpwtr4P9Ev7wcru9f0wZ+hrkAuvwD4nQgVem2UlurEvEGoNQMRm2EY4ABq
         YOQCFtSUqto2q9t/tMKUFNi+QfEZxa9FqeY+k9n5FF6rAmWTBx5I2hJIlW71DOxjTBqy
         88Xp6iwg/4GC4q7qnuCiNO5NptgCkNF6CYXMNZ7hDUkQCYToVaNSXpilqPsZDa3T/pet
         J3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s18Fllh+gB6Jtpr+Ov6lqWWsOKas/ShUMI9wmr9imiE=;
        b=pxOu9pkYA5Am4xquIvYeGRaIQ1xv4LW8mTLb8IIJwiU/1St+7DXDq37jSDLDWeqI1q
         b4RDtgS/VPWm5oJ/s4rLk5DC/tHj2c+Iy9FTHKHL1oGwpy4lkI0ir5VerF2oWUdsv/ou
         9yxLMl3uJsbK0e8A8w0LBihjEqGcCGZicyjlzNS9tCXSkO6o7VKJPcpIUrtn2IB/lswO
         hNaDGC9i22z3Lwy0k20LIopxH7OfH4GQP6cSrTWzI0heTM1sjjocg+Rpq3AIjo0bqPPO
         wYso1hiBXWUfIBmOCV4U3LJpbiw57z6iS0ULt574gxO21f+9vGlbbtccIl+dhEYv4aO8
         vgYw==
X-Gm-Message-State: AJIora/cbHYDUnjJ3EMbML0P/YANVm6tZwiMtUsFg8Kgk/2PNcgukAwp
        piWorFN/OCPOna797YrVvURAaA==
X-Google-Smtp-Source: AGRyM1u7dqwQl7BVwsbXGj4ln4y2G4XR8MrNgmo1CpOIpFByG8MREhIt5lLf2iwdZKWL2dK/3ZdUGQ==
X-Received: by 2002:a17:903:2285:b0:16c:33dc:8754 with SMTP id b5-20020a170903228500b0016c33dc8754mr15832799plh.126.1657921664549;
        Fri, 15 Jul 2022 14:47:44 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t126-20020a628184000000b0050dc7628148sm4376258pfd.34.2022.07.15.14.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 14:47:43 -0700 (PDT)
Message-ID: <2c6541c2-d55b-4fbc-ec03-3b84722b7264@kernel.dk>
Date:   Fri, 15 Jul 2022 15:47:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file
 op
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, casey@schaufler-ca.com,
        joshi.k@samsung.com, linux-security-module@vger.kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, a.manzanares@samsung.com,
        javier@javigon.com
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <a91fdbe3-fe01-c534-29ee-f05056ffd74f@kernel.dk>
 <CAHC9VhRCW4PFwmwyAYxYmLUDuY-agHm1CejBZJUpHTVbZE8L1Q@mail.gmail.com>
 <711b10ab-4ac7-e82f-e125-658460acda89@kernel.dk>
 <YtHeDa+rqXCFsd97@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtHeDa+rqXCFsd97@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/22 3:37 PM, Luis Chamberlain wrote:
> On Fri, Jul 15, 2022 at 02:00:36PM -0600, Jens Axboe wrote:
>> I did author the basic framework of it, but Kanchan took over driving it
>> to completion and was the one doing the posting of it at that point.
> 
> And credit where due, that was a significant undertaking, and great
> collaboration.

Definitely, the completion bit is usually the longest pole in the
endevaour.

>> It's not like I merge code I'm not aware of, we even discussed it at
>> LSFMM this year and nobody brought up the LSM oversight. Luis was there
>> too I believe.
> 
> I brought it up as a priority to Kanchan then. I cringed at not seeing it
> addressed, but as with a lot of development, some things get punted for
> 'eventually'. What I think we need is more awareness of the importance of
> addressing LSMs and making this a real top priority, not just, 'sure',
> or 'eventually'. Without that wide awareness even those aware of its
> importance cannot help make LSM considerations a tangible priority.

Not sure if this is a generic problem, or mostly on our side. uring_cmd
is a bit of an exception, since we don't really add a lot of non-syscall
accessible bits to begin with. But in general there's for sure more
action there than in other spots. I'm hopeful that this will be more on
top of our minds when the next time comes around.

For uring_cmd, extensions will most likely happen. At least I have some
in mind. We might want to make the control more finegrained at that
point, but let's deal with that when we get there.

> We can do this with ksummit, or whatever that's called these days,
> because just doing this at security conferences is just getting people
> preaching to the choir.

Don't think anyone disagrees that it needs to get done, and there's not
much process to hash out here other than one subsystem being aware of
another ones needs. Hence don't think the kernel summit or maintainers
summit is doing to be useful in that regard. Just my 2 cents.

-- 
Jens Axboe

