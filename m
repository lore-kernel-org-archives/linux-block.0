Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF64AC48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8105020656
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWxSH4mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfFYFLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:11:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38009 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfFYFLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 01:11:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so1432101wmj.3
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 22:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PduoSKu8sPiNegkYO3bqqtdawnIyeTL/dUu74PX8DKQ=;
        b=DWxSH4moBEvA7NQkj4Xr4YGFJdVKCCF92SJ0KpiEUftws5P5uGSSYG2U93emGEyUQG
         tyLEcIQ5FJKypItg0g0sCToLop68T8k8y3OXlPlbp+eZ1Zh2mK+IayKL6yJunvBh+Uaj
         M3y7+jDhZE0qjDEUcIhH0bykIOsK2Ui5pwDsT6fcsADvNWZR3AV5WbWZ6cs10u8gmI32
         xwIhOEdr4xBr6+NLGcrkjHfvSddFXX9e2Z+1TCh3fSzIYTWzIPdAUm7zwFa5LqnZTxex
         ORqsGI3Q0l1QTPKabO52/pS7YHYAJ8iQpRRi44ro95R8uMfWyYzjo72WP+O2dqmfOEaZ
         evhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PduoSKu8sPiNegkYO3bqqtdawnIyeTL/dUu74PX8DKQ=;
        b=ZkvxJSjJ8y62rzCbmJsuLHOLA8R7tc1y8qJBj0Jg7kCxuyl0KZGyhyT+pFdNtw1UKn
         hhJ7QSnC7TrixVozb/hv0r7rDnaUC/kFHJcjXTajqRe7yawxIWp1uNDOtqbOIINdMmvF
         n96poSTaT+0gZznrsGGxdS+gs6DJqkeq865rcjInWX5rMVuHrnXlYcZlL51PAR1mE5nl
         BEJJyJzHopH6AQ225DUPU7CT0W2bsvmPn3saycHT18rSiRfVfRXw1YQS0wnkAxAImTmx
         UCn/ZXbiWfUAMQp92c5roWM1ne866YXrvcVlawU7Bao2h/QyIbFG+EgiJcVIPYeHZKtS
         j6NA==
X-Gm-Message-State: APjAAAUUiaIl6ngye1mipYogkdUrQM80BdZ52miaQHVbrkRW++X3q78n
        PCms+H2rWLvVUe7jdzfVrDRzGA==
X-Google-Smtp-Source: APXvYqzJPPmrufSxswoeUaD/pht7tvlR2mR266yKciE1AL136cqVJyVnOXb/aQ45Ih1EN+F5PBE7VA==
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr18586322wmj.176.1561439492444;
        Mon, 24 Jun 2019 22:11:32 -0700 (PDT)
Received: from [192.168.0.101] (146-241-102-168.dyn.eolo.it. [146.241.102.168])
        by smtp.gmail.com with ESMTPSA id l124sm1404431wmf.36.2019.06.24.22.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:11:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX IMPROVEMENT 0/7] boost throughput with synced I/O,
 reduce latency and fix a bandwidth bug
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <f3e2d759-911b-f593-9ec5-b6b7a94df71c@csail.mit.edu>
Date:   Tue, 25 Jun 2019 07:11:30 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FC8946F-AFB9-4BD8-A778-ECDB1464D9DC@linaro.org>
References: <20190624194042.38747-1-paolo.valente@linaro.org>
 <f3e2d759-911b-f593-9ec5-b6b7a94df71c@csail.mit.edu>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 24 giu 2019, alle ore 22:15, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 6/24/19 12:40 PM, Paolo Valente wrote:
>> Hi Jens,
>> this series, based against for-5.3/block, contains:
>> 1) The improvements to recover the throughput loss reported by
>>   Srivatsa [1] (first five patches)
>> 2) A preemption improvement to reduce I/O latency
>> 3) A fix of a subtle bug causing loss of control over I/O bandwidths
>>=20
>=20
> Thanks a lot for these patches, Paolo!
>=20
> Would you mind adding:
>=20
> Reported-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Tested-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
>=20
> to the first 5 patches, as appropriate?
>=20

With great pleasure!  (sorry for adding you only as tester in the
first place)

Thanks,
Paolo

> Thank you!
>=20
>>=20
>> [1] https://lkml.org/lkml/2019/5/17/755
>>=20
>> Paolo Valente (7):
>>  block, bfq: reset inject limit when think-time state changes
>>  block, bfq: fix rq_in_driver check in bfq_update_inject_limit
>>  block, bfq: update base request service times when possible
>>  block, bfq: bring forward seek&think time update
>>  block, bfq: detect wakers and unconditionally inject their I/O
>>  block, bfq: preempt lower-weight or lower-priority queues
>>  block, bfq: re-schedule empty queues if they deserve I/O plugging
>>=20
>> block/bfq-iosched.c | 952 =
++++++++++++++++++++++++++++++--------------
>> block/bfq-iosched.h |  25 +-
>> 2 files changed, 686 insertions(+), 291 deletions(-)
>>=20
>=20
> Regards,
> Srivatsa
> VMware Photon OS

