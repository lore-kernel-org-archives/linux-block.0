Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6AEC352A1
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 08:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiLFIEv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 03:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiLFIEu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 03:04:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6474015FF7
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 00:04:48 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vp12so4231272ejc.8
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 00:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHwTX8uUU8wyVwOtLeOordYupKzPY3lgNz4rBQLwQcw=;
        b=WOWC3EhjrE2daVz0rtjp6qGuCK1OI/pdZYCfKao3Q+gKPArwVUzl6fClo/33jwSPTG
         XTKG4NoXXT2rK7orvGeSA0xCiOhSxSgABexR55+iJfEXp3HCN7bBEk7OWvOUlif6qyIG
         Z0XL451AJ455HgraXKnEisqOmGhccx4VPxLYMorw7HXBGIbHDNQmU+XyGXwq1PKvrUgH
         zpUPn+yj1G7IhoCEsTlm8hwaTW0Ne+MVmXdH+VxpVBBBkZP7Zs/SS7zYqpYLPGyny/Ve
         YE093oGE1ZdyyepjrN1aSnOT0K/WV7DFzP1aALZI6uNvphsXQxz7Kfz++mdSuiYvWKvP
         yDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHwTX8uUU8wyVwOtLeOordYupKzPY3lgNz4rBQLwQcw=;
        b=g2cLAh3tLqIGNnWjn+uL3WDULP3Wh2hr/IQgq5gGEH1oxwCBUQ12bXUYUwIuShKEpM
         qfVL8IFxH6PuqDqMG/MK359bGlB+jgBdCEpzS3FbEv8Hai/Tg9w8MMIJ04xwINewuWiE
         KIoJJvnEhhU1sdOTh1l8oyh+k8xIW3NG2PmxA+T3SfvW3aViYxiLyzHfUbBfioiqm0wE
         3a306dC31Ppms52W3PbvtG0miI9eSBXS5w82bB4oKVh0qo0eNWIcK8cZqHdO+bs6YR7f
         1fUgxvdnckIyIfN0TlrpQH6PIy8J9eIi6O/Yd11A1dcWNfJAjePAi5ZtRcoinfnAnf6T
         MZKw==
X-Gm-Message-State: ANoB5pk22mxExAo/hWOtqT0wjOD4sq4niLEUdV3iypqgROJKBi6ZiZ+z
        NkXmRnv53ya+lQO5TngU7eqDnA==
X-Google-Smtp-Source: AA0mqf5eKOUcnsRQb5eI/O/2xwha/y658G5r2OQrayi3ABflIJ+lFtMCMagIuT9Ab9VKoPmuLcDj2A==
X-Received: by 2002:a17:906:ce2b:b0:7c0:cc7e:c783 with SMTP id sd11-20020a170906ce2b00b007c0cc7ec783mr12875736ejb.133.1670313886945;
        Tue, 06 Dec 2022 00:04:46 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090632cb00b007c0b6e1c7fdsm5633665ejk.104.2022.12.06.00.04.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:04:46 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V6 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <14cea0aa-2f0b-117a-4568-c80ca0513eec@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 09:04:45 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEFE8587-7834-4686-B3C3-E2375668E680@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-2-paolo.valente@linaro.org>
 <14cea0aa-2f0b-117a-4568-c80ca0513eec@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Il giorno 21 nov 2022, alle ore 01:18, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
...

> That said, creating 2 helpers
> bic_to_async_bfqq() and bic_to_sync_bfqq() without that second =
argument
> would make the code more readable and less error prone I think.
>=20

I'm not sure yet about this, because, in some other place, the function =
is invoked like this

bic_to_bfqq(bic, is_sync, act_idx);

where is_sync is a bool.  With your proposal, we would lose the
wrapper and have to turn the above line into an if/else. =20

So, if ok for you, I'd leave this further change for a second time, as
it is somehow unrelated with the main goal of this patch.


...

>>=20
>> 	if (bfqq && bic->stable_merge_bfqq =3D=3D bfqq) {
>> 		/*
>> @@ -672,9 +677,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct =
blk_mq_alloc_data *data)
>> {
>> 	struct bfq_data *bfqd =3D data->q->elevator->elevator_data;
>> 	struct bfq_io_cq *bic =3D bfq_bic_lookup(data->q);
>> -	struct bfq_queue *bfqq =3D bic ? bic_to_bfqq(bic, =
op_is_sync(opf)) : NULL;
>=20
> Given that you are repeating this same pattern many times, the test =
for
> bic !=3D NULL should go into the bic_to_bfqq() helper.

Actually, this would improve code here, but it would entail a useless =
control
for all the other invocations :(

As for your other replies, I have applied all the other suggestions in
this reply of yours.

Thanks,
Paolo


