Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0120C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 09:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6156120871
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 09:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0iPU07/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6156120871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeKSUJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:09:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40027 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSUJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:09:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so27046725oth.7;
        Mon, 19 Nov 2018 01:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/5KBi0cm0UZGRmOnPPYVeGoLrG4FVrLsOwakUAWUfVg=;
        b=T0iPU07/Em0+Vs+RlaPd7CSr9UZiOuq9GoKrTOodZ5EA2fkmqJn/rP00kc979aPRwF
         fds1qPJJNmwMaFAd/6u/tobMkVJlaOApkSHCLMoGLqA7ZvULavCcUSmERSjB5BI3tp9F
         j21OL1KixuYPCJPQyZ8mHb1OetiaEinRNDnG2b1VFGz7tfKc9OEgr+Ldxm6vkac0JUCi
         NhhMtPErIfFeuA17gSbGOPF4T+25jVXHhdLSbwMqOD90XWh+D0d07ASbJXgezpL4lAqz
         XtWJMkrVxTPSeTS4UQF5Ka1YDdYD2SKswKDh7qIjS+Tkl9UI/nWspHqfMLx8wSmXU5bY
         regQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/5KBi0cm0UZGRmOnPPYVeGoLrG4FVrLsOwakUAWUfVg=;
        b=PqMsCPcYSMl6f2cBWi8BPrFZbHF+ZL3fUQoIXni2IoDjiXh3hqmEBpOsrmUSVU8bb/
         3NsHpAlHQN53YFFI1bBWj1bBD0AMdZxSAGN2S4mnuMo/aBCz0UCXCjljMBVoeVexx/sJ
         qWxwGoPbHHuGutoqxjxpskk8IYAUlDtcnwcUozDlKObw5T6D/K7xqkSc5BqTpe6ol8PZ
         HdHDkOgr+Em8zvYydqLp7r9wPDkh2XBNFIWE2kU5tlnh5MSBO14BCKjbcUnaaBtkTOr6
         U4RRFh4gEf7N1K2Oz5zJeH+FhODqRW/cK/JjLrFYrg5Lo9DdBSFEaBRBKPM+RDL3XfGG
         Zb5g==
X-Gm-Message-State: AGRZ1gJ8L3D6XhTUCR39K0Aun/mA8mzAKiACUtR4m5Sr3x/hR+86qI0/
        QASIwiV9Lz43ByopEl7I0PNg0XFOptqe5VRWKNc=
X-Google-Smtp-Source: AJdET5djjmS6uPotJ5Kk5PEcr/1ZqYugmBAaZJ9sscnM+UTyuE89yNjcsIImZFqQq2tMTZOzIVjwyrjEYB2cNgozqqI=
X-Received: by 2002:a9d:3d61:: with SMTP id a88mr13467168otc.103.1542620784857;
 Mon, 19 Nov 2018 01:46:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:2819:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 01:46:24
 -0800 (PST)
In-Reply-To: <79a2da26-669a-359c-3832-354ec2b47231@kernel.dk>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name> <E8A20452-A73C-4A31-B5EC-48EFB9937832@linaro.org>
 <e85cfae0-7743-8c51-c2c9-0855c26f868e@kernel.dk> <CADiTV-37tqWsbxmeZJsqq+pqSqxN-_L9+T9R+PmBBJhfO-G09g@mail.gmail.com>
 <79a2da26-669a-359c-3832-354ec2b47231@kernel.dk>
From:   Angelo Ruocco <angelo.ruocco.90@gmail.com>
Date:   Mon, 19 Nov 2018 10:46:24 +0100
Message-ID: <CADiTV-0Yxo=WagKPGcJebk+XQvPNxFjpyvVZmOKE2PPjFzv7pQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "'Paolo Valente' via bfq-iosched" <bfq-iosched@googlegroups.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

2018-11-15 17:30 GMT+01:00, Jens Axboe <axboe@kernel.dk>:
> On 11/15/18 4:54 AM, Angelo Ruocco wrote:
>> Hi Jens,
>>
>> I have rebased the patchset against the for-4.21/block branch, but I
>> can't test them properly because the compiling process has an error on
>> a different file. In particular:
>>
>> include/net/xfrm.h:1465:3 error: unknown type 'spruct'
>> include/net/xfrm.h:1465:30 error: expected ':', ',', ';', '}' or
>> '__attribute__' before 'auth'
>>
>> To be clear, and so that you can check I haven't made some trivial
>> mistakes: I have added/fetched the remote [1] and then simply rebased
>> against the for-4.21/block branch.
>
> I think you have memory issues, a 'p' is just one bit away from a 't'.

That was indeed the problem.

Thank you,
Angelo

>
> --
> Jens Axboe
>
