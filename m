Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9441C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 17:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DED20880
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 17:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjyIXlM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfDHRBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:01:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41031 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbfDHRBb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 13:01:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so17273222wrq.8
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iqf43cq8RemTopCE0ufXfp+TKKTu8jJvXQ5PxPdROIg=;
        b=HjyIXlM9NVEpWRMBzLiUCUaHmiTdQNUC1LlZDaO1rJUZ/tc/4vFmRZuF5iD4KRzbw3
         NqLt/XWzwexoTi/mRyEaJlSjMz7tfZSZSiQW6gwZuDcKsMocDhaPg49g3qyYGtV5L+vr
         30cUUKqYXqOqb7V0imdhatthehWPWwxrD1/G1mYL3uKkQ2Iqd8YglOzcorT5FEEbRwAM
         3cGwADzx1jMH3V9Jn8ZQ8KWi2Oy/yrjZM28UjMvlWOpxCr5D9N2woP1IDACfw18yF+hc
         AQWBEFoK0BBAuDK8XfM4xYNLCXfCOlrMRA1Ex50JJQmSH/tno6gWlTUE0oJ/ew0wfqoi
         uXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iqf43cq8RemTopCE0ufXfp+TKKTu8jJvXQ5PxPdROIg=;
        b=WSl4oPYnKhGclU+1hf+Xc0P0mbuXy5wSFF0BwcdiI7dS9szDR2l74DBwoXrLEMelj3
         SHMWkS3bHhwoOxq1FBHqWvGV/Qjb0pcvDIN/PEsq4x1i0Svp3fMNjschOdqoeJiseya+
         LiIWRyEY1ioQIBjlMLGvZ93ws7zylPCdP3Tmf3+LtiA6qryHS7qwbGTmkJ+Txh8S3QO7
         drwI61zbkt02TI/4yNZTAQtovlPUbLvG7/BRjgR8C4+VS+t24IPZr0Gtu79babxXxrg6
         wwPmHQxEz8sgigcnpIHS1MBiBVFmvczsNbO7OqMujkRBCpWXgBiNxFcyzVqWNoz68SnN
         3gkg==
X-Gm-Message-State: APjAAAXmtprMboqEF23GZDqFGyp15lKIA1UddNQ9v1q4sTZAajEns/Uw
        Sh338jq2FELt67faOW6BpzryXA==
X-Google-Smtp-Source: APXvYqwWdxX2q/Ds/K8IgAvLrxajOXIANeP6HE60KBuItPfhifSpFiyOpGhcA+XdxVSEuVYAh4fvbw==
X-Received: by 2002:adf:ee91:: with SMTP id b17mr18169609wro.234.1554742883959;
        Mon, 08 Apr 2019 10:01:23 -0700 (PDT)
Received: from [192.168.43.112] ([37.161.65.57])
        by smtp.gmail.com with ESMTPSA id u8sm30288100wrt.69.2019.04.08.10.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 10:01:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <ef1481e8-c664-5f17-4a19-bb90daabc0b7@kernel.dk>
Date:   Mon, 8 Apr 2019 19:01:18 +0200
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net, mkoutny@suse.cz
Content-Transfer-Encoding: quoted-printable
Message-Id: <377E06A7-14D7-4AC6-AD07-AEB691E00DEA@linaro.org>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
 <20190408150430.GB23021@linux-x5ow.site>
 <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
 <20190408150828.GC23021@linux-x5ow.site>
 <5283A08F-FD6F-4A9C-841D-B49CE9B4CF1F@linaro.org>
 <ef1481e8-c664-5f17-4a19-bb90daabc0b7@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 apr 2019, alle ore 17:17, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 4/8/19 9:14 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 8 apr 2019, alle ore 17:08, Johannes Thumshirn =
<jthumshirn@suse.de> ha scritto:
>>>=20
>>> On Mon, Apr 08, 2019 at 09:05:19AM -0600, Jens Axboe wrote:
>>>> I did consider that, and that would be doable. But honestly, I'm =
having a
>>>> hard time seeing what issue we are attempting to fix by doing this.
>>>=20
>>> Yeah, I guess the real fix would be to update the documentation and =
the
>>> expectations user-space has. Including eventual re-write of some =
udev rules or
>>> whatever is facing these files. But to me that sounds more like a =
systemd or
>>> even distro thing than a kernel thing.
>>>=20
>>=20
>> Unfortunately the user-space people I have interacted with find crazy
>> to have to change their software to call bfq.weight the weight of a
>> group.  And are not willing to do it [1].
>=20
> Then you need to educate them.

I'm not sure that educate is the right verb (I don't like the current
messy solution either).  But I'll do my best to inform people when
I'll have the opportunity to do it.

> Some of the issues were called out years
> ago, at the time when we could have potentially renamed.

Yeah, a good window was 5.0, and at that time we tried with a more
general solution.  But we failed.


> A rename now
> will solve nothing.
>=20

I see your point, but I don't agree this rename would solve nothing.
The real bad thing is not having done this before.  Changing names
that nobody uses, to names that everybody already uses, but wrongly,
would instantaneously improve the situation a lot.  And it is what
userspace already asked explicitly for [1].  Without this simple
change, it will take a lot for all the inconsistent documentation
spread around the world to be synced.  And for all legacy software to
be changed, assuming it will all be changed.

Paolo

[1] https://github.com/systemd/systemd/issues/7057

> --=20
> Jens Axboe

