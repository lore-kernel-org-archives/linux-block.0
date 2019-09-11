Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E090ECDE27
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 08:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D75D2085B
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 08:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T10RJz72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfIKITA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:19:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45340 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfIKITA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 04:19:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id l16so23349146wrv.12
        for <linux-block@vger.kernel.org>; Wed, 11 Sep 2019 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R6bNyRB3okcLgmMwzrbkbbFt8yg4QtbotOgZ2XtiVFQ=;
        b=T10RJz72P4bazLOmVQcxgR86fu6+qGr1JftyGJUuSDSuJccnd7vnWx7F+SNdOVW//i
         dOaN5N9S5adBx5TFmelByaEo4t5VgpA2m00JbgDiWz854afZSstaupDlHffRMzRX7BW2
         ZVep8klfo0LjL8jDbGF9aBeqfc5LA2Gvq+MrL4GAcIk2e5Z6wy+EzBeW9rGl2x0GJFdL
         ENacUnjM+CLhVcMXW45xALoU7qPPovZHx4xK9O8WUkQgISEOMTordF9jLBmq07SbwTX1
         IPhe76cE//tEyQNVvZ2aEZ2AgtdRegAuQFcgTKjoEz53rrrZUSW8mjDTQLaM34MgxpoN
         /dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R6bNyRB3okcLgmMwzrbkbbFt8yg4QtbotOgZ2XtiVFQ=;
        b=pfZD6P7Ot+YW3CIPIZWgD9tmm2zCkxuK632/pxjuv4FYV9tQmaBA18eFlK5y7LJVGX
         vxuR89PmZamA1oVprrEGONZ+Fmbni0bm4sk59H+fpRpB3XXEb32Pp/3vRG8ESKbihaBK
         yAtgp6ykOKeiHY2b46zETNqEUi29uChuEA6rV9dV4rCgaHO6aSDU9CMTDgGIl71iSG/I
         jEhH5WvyS4smjdiam6m3xNoCU3WngfRctYMNB1z58zb6ZHomexMptGSD/UK0U6nuhcRk
         AcpyzU1RLmqgyQa8k6g2ne7PGR6W68gZxr+SW+dsGLDlZbbasSu3khl473y5GQ/KDrRB
         rXRQ==
X-Gm-Message-State: APjAAAWpZJXJEJogbFY2LsJTVQDAoGbQij/Li5ozstwoHk+6xhQ5fRq6
        aDmjiFRobywYCl5tJP2VzDKwPA==
X-Google-Smtp-Source: APXvYqyaxsKPBE9EBNbij/laaS2aOwsuKWjup0/f8wFbbig3B2MTtBQMOp7JkuMQ9CVJLVGmj4pNvg==
X-Received: by 2002:adf:dec2:: with SMTP id i2mr13353996wrn.92.1568189937470;
        Wed, 11 Sep 2019 01:18:57 -0700 (PDT)
Received: from wifi-122_dhcprange-167.wifi.unimo.it (wifi-122_dhcprange-167.wifi.unimo.it. [155.185.122.167])
        by smtp.gmail.com with ESMTPSA id h125sm2539418wmf.31.2019.09.11.01.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 01:18:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
Date:   Wed, 11 Sep 2019 10:18:53 +0200
Cc:     =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, clm@fb.com,
        dennisz@fb.com, newella@fb.com, Li Zefan <lizefan@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A69EF8D0-8156-46DB-A4DA-C5334764116E@linaro.org>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 10 set 2019, alle ore 18:08, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Michal.
>=20
> On Tue, Sep 10, 2019 at 02:55:14PM +0200, Michal Koutn=C3=BD wrote:
>> This adds the generic io.weight attribute. How will this compose with
>> the weight from IO schedulers? (AFAIK, only BFQ allows proportional
>> control as of now. +CC Paolo.)
>=20
> The two being enabled at the same time doesn't make sense, so we can
> just switch over to bfq when bfq is selected as the iosched.  I asked
> what Paolo wanted to do in terms of interface a couple times now but
> didn't get an answer and he posted a patch which makes the two
> controllers conflict, so....  Paolo, so it looks like you want to
> rename all bfq files to drop the bfq prefix, right?

Yep, mainly because ... this is the solution you voted and you
yourself proposed [1] :)

[1] https://patchwork.kernel.org/patch/10988261/

>  I can implement
> the switching if so.
>=20

That would be perfect.

Thanks,
Paolo

>> I see this attributes are effectively per-cgroup per-device. =
Apparently,
>> one device should have only one weight across hierarchy. Would it =
make
>> sense to have io.bfq.weight and io.cost.weight with disjunctive =
devices?
>=20
> It never makes sense to have both enabled, so I don't think that
> interface makes sense.
>=20
>>> +		.name =3D "cost.qos",
>>> +		.flags =3D CFTYPE_ONLY_ON_ROOT,
>>> [...]
>>> +		.name =3D "cost.model",
>>> +		.flags =3D CFTYPE_ONLY_ON_ROOT,
>> I'm concerned that these aren't true cgroup attributes. The root =
cgroup
>> would act as container for global configuration options. Wouldn't =
these
>> values better fit as (configurable) attributes of the respective
>> devices?
>=20
> Initially, I put them under block device sysfs but it was too clumsy
> with different config file formats and all.  I think it's better to
> have global controller configs at the root cgroup.
>=20
>> Secondly, how is CFTYPE_ONLY_ON_ROOT supposed to be presented in =
cgroup
>> namespaces?
>=20
> Not at all.  These are system-wide configs.  cgroup namespaces
> shouldn't have anything which aren't in non-root cgroups.
>=20
> Thanks.
>=20
> --=20
> tejun

