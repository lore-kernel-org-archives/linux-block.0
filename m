Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A581C4332F
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 14:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLVOhe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 09:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLVOhd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 09:37:33 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDDE2937F
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 06:37:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id tz12so5325149ejc.9
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 06:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2XIoIHfnKgvqcssogABNOCMi32Z918v6EUDVlB125s=;
        b=Q1afl3GhhxaBkXo/0k89Cxod1CsNlTl0vHVlCoXrn7rQ5/awabLhOpn2Yhz/C62Dav
         ZIuzXMa2p6ovLW6XKhTuhEaP6/bu1i2jCXCS3/qSFWhvTte7UlruK5zNte7+CWtK/6vb
         N1o5GpF894FegLOTbJ76ZkFYD1Mr2kqfsKQblAI60LsZUttj7w3bX+l9Ska/NGqsNh5z
         xEltRa4PbEUOx1ZWhUfxBNeY++91GUV0fnW/CN12BMjHn8UyrguxS+Sx+1Y4xzDsceUW
         D9248TIHIxl6ZLpVRGC0TlGNYiJBBRA1WdBOShJixmuaulxYDcRlulPX/X3pQ1u+sQGT
         rNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2XIoIHfnKgvqcssogABNOCMi32Z918v6EUDVlB125s=;
        b=TuWzdA0LmEJvLjH/BO5lQly/0fwRO7xZlUHaCtg3EHqLsOsZup9KogeNmN5EQ7rWNv
         v7WqbdzlhTyg6yiJJnLSyIJRY+WUZbtg5Mepvf/XhD6rXvYHI0nff9QOwyAB3HQMlCEL
         iPis0mgU6gTrSUqevIlWQr+UHAey+kUJ4II1SEYQBqGaNlrZZD7NoqT2UOQM38gnpyzg
         OXBofUlJQ/sKJZTbXIFNZsRWmo5XW2JZZpkyH8cLcu7cHqd//HwfqcBton5jgnnsEdA9
         lMDeW8hvlwD7TTputqjWFCCORsDWaSPf4Hr0E2+Zg3LyCjlZCRWcAnFEmhkt5goLZ+mD
         d/ig==
X-Gm-Message-State: AFqh2kpyJE3fZ/ywKvWHpk/9m4efZfAZHdYCI9Hfo3BuguEokp9JCr+2
        iAYO0JJkIpmdbntd2QRbamWT9w==
X-Google-Smtp-Source: AMrXdXtMjdGbt/FP26D6ofaVLmCOstQp39FG44RLhVNrWx+5FzvZFFFJVDfjMBfiXq/nzyQFEvktXg==
X-Received: by 2002:a17:906:4894:b0:7c0:beee:2f06 with SMTP id v20-20020a170906489400b007c0beee2f06mr4945593ejq.52.1671719850704;
        Thu, 22 Dec 2022 06:37:30 -0800 (PST)
Received: from mbp-di-paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id e11-20020a170906314b00b007ae10525550sm313932eje.47.2022.12.22.06.37.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:37:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V11 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <017f3dbd-4586-490a-2f21-948586391515@opensource.wdc.com>
Date:   Thu, 22 Dec 2022 15:37:28 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6644B35-D439-4DB8-93DC-EF77D580FCA0@linaro.org>
References: <20221220095013.55803-1-paolo.valente@linaro.org>
 <20221220095013.55803-2-paolo.valente@linaro.org>
 <8a49432d-642f-cd58-8e4d-2b320aef5edd@opensource.wdc.com>
 <D429FA01-9510-41FF-AD85-F74EB8AD171F@linaro.org>
 <017f3dbd-4586-490a-2f21-948586391515@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 21 dic 2022, alle ore 13:27, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
> On 2022/12/21 19:27, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 21 dic 2022, alle ore 01:46, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>>>=20
>>>=20
>>> [...]
>>>=20
>>>> -static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
>>>> +static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync,
>>>> +			      unsigned int actuator_idx)
>>>> {
>>>> -	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync);
>>>> +	struct bfq_queue *bfqq =3D bic_to_bfqq(bic, is_sync, =
actuator_idx);
>>>> 	struct bfq_data *bfqd;
>>>>=20
>>>> 	if (bfqq)
>>>=20
>>> With your current bic_to_bfqq() implementation, you will *never* get =
NULL as a
>>> return value.
>>=20
>> I'm afraid this is not true.  A bic is associated with a sync and an
>> async queue, or with both.  So, in the hunk above, bic_to_bfqq =
returns
>> NULL if:
>> - either the bic is associated with a sync queue, but is_sync happens =
to be false;
>> - or the bic is associate with an async queue, but is_sync happens to =
be true.
>>=20
>> Of course, with these patches, the associations move from "with a
>> sync/async queue" to "with a set of sync/async queues, one per
>> actuator".
>=20
> My bad... The bic->bfqq[][actuator_idx] is an array of pointers... I =
was reading
> it as "&bic->bfqq[1][actuator_idx]". So please ignore. Apologies for =
the noise.
>=20

Great, then the last bit of action for me is to turn the offending
conditional operation into an if statement.  I'm going to do that and
send a V12 with this change, and with only this first patch still
needing your approval.

Thanks,
Paolo

