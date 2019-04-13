Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57B3C10F11
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7AC2084D
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3X2r1Ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfDMPSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:18:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45742 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfDMPSL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 11:18:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so15717821wra.12
        for <linux-block@vger.kernel.org>; Sat, 13 Apr 2019 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OciDtIn65PlOwLvDZifReY0p6E/HwnmSaYd3L7Dqar0=;
        b=A3X2r1CteN4VuOOcC+HSLiR7z8LPi4BHDFk8LH70NWRjljv9dZYxFUiw74hPL5IpPP
         qsANQBT7DVD/F25wB+LYM0uC6JShdMznCP3/GRCW0oNwztENM89pLpJ7nqEcY8H85JQN
         9nvh+BoEdplgClp8URaCFhOvJNxoYXljdQBx+KOqxUPxqXCfn7QGiPKV8dccKgKuqyw9
         pw33YcJDB9+haOG74KLMA0D0rj8GfU+yydOwhCKUMDOz+raA2wkmeMuM5W1IyyMJoocW
         V2EQ+acwTG+wWOixvNViQp3mR5aTsr6ofxWWxQK3BRE0d42UhLhXD3TvrYhWZbjpjO1z
         Trag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OciDtIn65PlOwLvDZifReY0p6E/HwnmSaYd3L7Dqar0=;
        b=uaSR32kAsJhtQ+pdWyDaFP+hWlon8jmYAf/RE6XyUpl8HtcVb9v/7G56XVRMOVSsdn
         OMnLd2WwzxAKYksEsQ8MRrw7/Is41OddaGo1oUd1wExqaFLq52s6raB3PRMm0gKgqAv9
         Nazb5Bpx1DxF45CEBSdaBL1HhTh4e3Wno/ISQECfVOf3iL+zbV68M+JRy3XeRKskLdOo
         6cyX0WbWRhGN0EGqZnq9mtxiwsrf4jw3rtFG9cK0zYfFLduSxWB7IIm7svgb580Ibp3Z
         eLxlJR43pBJKzr3926yWS2mlTdBVk5/EKvhSa0sa2BhLdoNd2jv0Cboth08pXb9Uo1Eh
         124Q==
X-Gm-Message-State: APjAAAXL4EPmdKQCVoX81JcnUqYjGTCeRc+dZ+NrHlsmyjmD7ylAI4Jg
        uNClVxbzAE6kB9wjMUp9ng6jFg==
X-Google-Smtp-Source: APXvYqz1j+ZImvgGcH5k0zzm6MSj5sfpzvE7CtmrbQY7gx3q94ANtKSYUQDZxCQfRjXjyuM49rLc/Q==
X-Received: by 2002:a05:6000:1291:: with SMTP id f17mr36407715wrx.201.1555168689722;
        Sat, 13 Apr 2019 08:18:09 -0700 (PDT)
Received: from [192.168.43.112] ([37.160.87.184])
        by smtp.gmail.com with ESMTPSA id p6sm36237224wrs.6.2019.04.13.08.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 08:18:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: bfq: update internal depth state when queue depth changes
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <280d9cac-6373-8e90-dd52-11183db2e253@kernel.dk>
Date:   Sat, 13 Apr 2019 17:18:07 +0200
Cc:     Kai Krakow <hurikhan77@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        hurikhan77+bko@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C072E94A-C227-428D-A7CD-E804D6FF2CE6@linaro.org>
References: <013ca038-559d-0a56-4d49-366c7ec79ac3@kernel.dk>
 <CAMthOuPohGUM8gqxE8xoLdSnVaU2iEgOT60fqddWbsoDZSy0CA@mail.gmail.com>
 <280d9cac-6373-8e90-dd52-11183db2e253@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
I'm not finding this fix in either current rc or for-5.2.  Am I missing
something?

Thanks,
Paolo

> Il giorno 19 gen 2019, alle ore 15:36, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 1/19/19 4:13 AM, Kai Krakow wrote:
>> Am Fr., 18. Jan. 2019 um 18:34 Uhr schrieb Jens Axboe =
<axboe@kernel.dk>:
>>>=20
>>> A previous commit moved the shallow depth and BFQ depth map =
calculations
>>> to be done at init time, moving it outside of the hotter IO path. =
This
>>> potentially causes hangs if the users changes the depth of the =
scheduler
>>> map, by writing to the 'nr_requests' sysfs file for that device.
>>>=20
>>> Add a blk-mq-sched hook that allows blk-mq to inform the scheduler =
if
>>> the depth changes, so that the scheduler can update its internal =
state.
>>>=20
>>> Reported-by: Paolo Valente <paolo.valente@linaro.org>
>>> Fixes: f0635b8a416e ("bfq: calculate shallow depths at init time")
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>=20
>> Works fine here in 4.18 as far as I could test (running a full =
backup,
>> some compilations and Gentoo package upgrades, filling memory with =
web
>> browsers to force swapping).
>>=20
>> $ grep ^ /sys/block/*/queue/nr_requests
>> /sys/block/bcache0/queue/nr_requests:128
>> /sys/block/bcache1/queue/nr_requests:128
>> /sys/block/bcache2/queue/nr_requests:128
>> /sys/block/bcache3/queue/nr_requests:128
>> /sys/block/bcache4/queue/nr_requests:128
>> /sys/block/sda/queue/nr_requests:256
>> /sys/block/sdb/queue/nr_requests:256
>> /sys/block/sdc/queue/nr_requests:256
>> /sys/block/sdd/queue/nr_requests:256
>> /sys/block/sde/queue/nr_requests:256
>> /sys/block/sdf/queue/nr_requests:256
>>=20
>> Tested-by: Kai Krakow <kai@kaishome.de>
>=20
> Great, thanks for testing!
>=20
> --=20
> Jens Axboe
>=20

