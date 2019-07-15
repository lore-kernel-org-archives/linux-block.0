Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34652C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08062212F5
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKB52CWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfGOKxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:53:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34566 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbfGOKxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 06:53:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so16601627wrm.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9QeR05ggwCJbQR+oKm0lK2M+jB4GX6f5Mlo/cT/UFgc=;
        b=ZKB52CWfpTKQ2s8245fa7YfZFpjWvZGUxCLmENqWhk6/dX0MN374+ru37HkmBNmq9P
         QT9q2O9dOFsem8ap6QcNS0jcENpTLsacIgNQ+Oj7VJsxn1HK+qZnXueN4XTmcx9WLQcC
         Gh0esGQ/JVdlhtdeRccvRkGT1ODYgRAmWwW3w5Rwtve14z8dRbA6ov4oK7g3UWJHa+m2
         O+fav6ug3FeVgnRmipJDqc5bxEzwqIgEWJ5VzOyi4T78AHj4K3QV6Vkgd7CF48cC/iot
         x8Wdb3iWNTk008tvFe2pUYxH+1VgxhrK94Npq1V8aHjzF+uTtCfl05/TjR83PiTBSDAS
         /0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9QeR05ggwCJbQR+oKm0lK2M+jB4GX6f5Mlo/cT/UFgc=;
        b=t2wvxcRVpELbEdYRxDvY8/aCszfGentL4R58CMK7RZX0od/1ZBh2rZ0xHi908Zkx+N
         SCYYBw7JccBgq4sTlgVyXgw2SKJ6qRaK7+eJvapKMsOE30wOH2WlDGyrPfxfisl6Fsh/
         5VPCIeUwa3JAHY4+Whrvraji4vnwy7/adxoeQjFPEfMlOWTYglveuwctOs8g94qpo2dp
         wlmD5//ZbfTseJf3eFXG+s2AYXJ3nIu789pZDc3FeqJ1tirmT4DwqktwBreF4A+Xq8wF
         QzJKGKHO+lZD+fal4mOeNqoPCr66qF7v2ygxh1wKSkSCEc0YgLe2aagOvz8B44hrNnPD
         wJDA==
X-Gm-Message-State: APjAAAX67VuE/x1Q885LUbvkgAUC4lt9Hr1Z6+QCQ/bm/Tk1BLP/3mF1
        OIBHVpq7Q5SGaRHc48h9rbvYaA==
X-Google-Smtp-Source: APXvYqxX0jr3Tfyps9J72HASrfrzfl8Z+9+nLFqpJl5898EToLTkmekHNR4zdr84b2PVw1oD3i8rOg==
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr28229277wru.125.1563188022056;
        Mon, 15 Jul 2019 03:53:42 -0700 (PDT)
Received: from [192.168.0.101] (146-241-97-230.dyn.eolo.it. [146.241.97.230])
        by smtp.gmail.com with ESMTPSA id e19sm22821146wra.71.2019.07.15.03.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 03:53:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX IMPROVEMENT 1/1] block, bfq: check also in-flight
 I/O in dispatch plugging
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <2c15c4bc-145d-fb0d-ae5a-2a8ce36f977b@applied-asynchrony.com>
Date:   Mon, 15 Jul 2019 12:53:38 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <B064EF63-B7F6-4BA3-BA0A-FF9579893971@linaro.org>
References: <20190715093153.19821-1-paolo.valente@linaro.org>
 <20190715093153.19821-2-paolo.valente@linaro.org>
 <88e3c1e1-224f-a9a8-0875-848ba23b6fbf@applied-asynchrony.com>
 <B0406DB0-1003-4610-8A75-F3D7614C616E@linaro.org>
 <2c15c4bc-145d-fb0d-ae5a-2a8ce36f977b@applied-asynchrony.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ops, my fault of course. I submitted the patch I made on top of the dev =
version of bfq. Preparing a V2. Sorry.

> Il giorno 15 lug 2019, alle ore 12:49, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
> On 7/15/19 12:18 PM, Paolo Valente wrote:
>> Didn't I simply move it forward in that commit?
>>> Il giorno 15 lug 2019, alle ore 12:16, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>>> Paolo,
>>>=20
>>> The function idling_needed_for_service_guarantees() was just removed =
in 5.3-commit
>>> 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve =
I/O plugging").
>=20
> Argh, sorry - yes you did, it failed to apply because the =
asymmetric_scenario
> variable was already gone. Fixing the patch to just return the =
expression so that
> it matches 3726112ec731 worked.
>=20
> All good!
> Holger

