Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5999C10DCE
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 11:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEEC2076F
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 11:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oe3sHENH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCRLHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:07:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52254 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgCRLHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 07:07:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so2764522wmo.2
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2020 04:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2GgzefCkHgQryfh05yVOXaqfrd16ZLleM2vVoWi7qKM=;
        b=oe3sHENHLGinBcd6lMWtD0RoK45nqnzlQr19MySzk1H++IPzrafqn2QGKUgroirtAL
         2lq94YtnruHw3iuab3e4AriYG2hEDA3sSolOFoDaKQO/bQhD2FD96GTdUwwCmputjbKG
         g7lSYEHuwJu3WcZnQI9lIerjoQsv7upSxnLDekOD6qxMw84AKQEbNa92xHr9PfIQ3dl5
         mIslOu/fiy47HYjRmxFu8oKAr7ybJSc4LKfDOGS1WidoyvshWGBgzbLDQgHcH7v1zN28
         Y8o+y9bN5HwKnk6rN6N08F9Lz2wJMZBFYKJIDoQfJl51GthyZZ4KYQMAz1WwReFN8TlI
         dKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2GgzefCkHgQryfh05yVOXaqfrd16ZLleM2vVoWi7qKM=;
        b=pivTo2foZbo01RMH3UtA+d9c6HOZwbn1CgDM7USwcp/4T8BRhrgK20c5DTPB3iKvoH
         GDgPYSnuM9UjYiM48ADWXyu1Q2rlfRblSvW0nmMqHbEaXz7YVhZXe3LVvjrwPpzJGpoI
         9XNeaaqtLWAM//nwuzgTGy4TaeSRZjZY0SKn8si9PfO+j1bb7s0G4Bc10nwN6OkwMtKt
         Oao4KxDSQem0xsC0NI3WLliPk+GwnGJQbQDbMPVH2VSpy9xhfeDo5ulr0I8Q6DuuRKog
         IpPqmIX4smX+VlVgdTFSwSHM4yoUWoOZJ4dS9lExPmODDcCD6Bqbwq6eRthZG1o5JUL0
         Rw9Q==
X-Gm-Message-State: ANhLgQ01Ntzna9VDBL7vfPy0zjMqRCEEwaUZQQi7SefGXJJ6ImZIFbzQ
        ZVK/s8AlDB7ZtNP7ivpgclakug==
X-Google-Smtp-Source: ADFU+vvbOF4UPZ6d4YXj7X2uq/HVQ+u1hCqRdJ2NoMl/CAIeeiaxA9jFtRCN5cOgU3/Z12AVgesd0g==
X-Received: by 2002:a1c:9693:: with SMTP id y141mr4595944wmd.23.1584529619351;
        Wed, 18 Mar 2020 04:06:59 -0700 (PDT)
Received: from [192.168.0.104] (88-147-64-186.dyn.eolo.it. [88.147.64.186])
        by smtp.gmail.com with ESMTPSA id a186sm3427803wmh.33.2020.03.18.04.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 04:06:58 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] block, bfq: fix use-after-free in
 bfq_idle_slice_timer_body
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <241f9766-bfe6-485a-331c-fdc693738ffc@huawei.com>
Date:   Wed, 18 Mar 2020 12:07:37 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>, renxudong <renxudong1@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7FFF605-BAA8-42C1-B648-1D5BA17D1286@linaro.org>
References: <6c0d0b36-751b-a63a-418b-888a88ce58f4@huawei.com>
 <C69604D5-CBB7-4A5F-AD73-7A9C0B6B3360@linaro.org>
 <0a6e190a-3393-53f9-b127-d57d67cdcdc8@huawei.com>
 <4171EF13-7956-44DA-A5BF-0245E4926436@linaro.org>
 <241f9766-bfe6-485a-331c-fdc693738ffc@huawei.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 18 mar 2020, alle ore 10:52, Zhiqiang Liu =
<liuzhiqiang26@huawei.com> ha scritto:
>=20
>=20
>=20
> On 2020/3/18 16:45, Paolo Valente wrote:
>>=20
>>=20
>>>>> 	spin_lock_irqsave(&bfqd->lock, flags);
>>>>> -	bfq_clear_bfqq_wait_request(bfqq);
>>>>> -
>>>>> 	if (bfqq !=3D bfqd->in_service_queue) {
>>>>> 		spin_unlock_irqrestore(&bfqd->lock, flags);
>>>>> 		return;
>>>>> 	}
>>>>>=20
>>>>> +	bfq_clear_bfqq_wait_request(bfqq);
>>>>> +
>>>>=20
>>>> Please add a comment on why you (correctly) clear this flag only if =
bfqq is in service.
>>>>=20
>>>> For the rest, seems ok to me.
>>>>=20
>>>> Thank you very much for spotting and fixing this bug,
>>>> Paolo
>>>>=20
>>> Thanks for your reply.
>>> Considering that the bfqq may be in race, we should firstly check =
whether bfqq is in service before
>>> doing something on it.
>>>=20
>>=20
>> The comment you propose is correct, but the correctness issue I =
raised
>> is essentially the opposite.  Sorry for not being clear.
>>=20
>> Let me put it the other way round: why is it still correct that, if
>> bfqq is not the queue in service, then that flag is not cleared at =
all?
>> IOW, why is it not a problem that that flag remains untouched is bfqq
>> is not in service?
>>=20
>> Thanks,
>> Paolo
>>=20
> Thanks for your patient.
> As you comment in bfq_idle_slice_timer, there are two race situations =
as follows,
> a) bfqq is null
>   bfq_idle_slice_timer will not call bfq_idle_slice_timer_body ->no =
problem
> b) bfqq are not in service
>   1) bfqq is freed
>      it will cause use-after-free problem before calling =
bfq_clear_bfqq_wait_request
>      in bfq_idle_slice_timer_body. -> use-after-free problem as =
analyzed in the patch.
>   2) bfqq is not freed
>      it means in_service_queue has been set to a new bfqq. The old =
bfqq has been expired
>      through __bfq_bfqq_expire func. Then the wait_request flags of =
old bfqq will be cleared
>      in __bfq_bfqd_reset_in_service func. -> it is no a problem to =
re-clear the wait_request
>      flags before checking whether bfqq is in service.

Great, this item 2 is exactly what I meant.  We need a comment
because, even if now this stuff is clear to you, imagine somebody
else getting to your modified piece of code after reading hundreds of
lines of code, about a non-trivial state machine as BFQ ...  :)

Thanks,
Paolo

>=20
> In one word, the old bfqq in race has already cleared the wait_request =
flag when switching in_service_queue.
>=20
> Thanks,
> Zhiqiang Liu
>=20
>>>>>=20
>>>>=20
>>>>=20
>>>> .
>>=20
>>=20
>> .
>>=20
>=20

