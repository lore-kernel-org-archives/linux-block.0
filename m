Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EF9C433EF
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 09:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03296124F
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 09:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhKEJqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhKEJqS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Nov 2021 05:46:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14D2C061714
        for <linux-block@vger.kernel.org>; Fri,  5 Nov 2021 02:43:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g10so30862153edj.1
        for <linux-block@vger.kernel.org>; Fri, 05 Nov 2021 02:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8y0VPNTgZTQu+dDzGDg65lSnAXwX3wAhedjIn63SFis=;
        b=w//9n3nZXdo8cn4DbNCGWA60EEYekv1YXuuQVjstNwBtmac5v9FUNd/2UnACveH2NT
         A1Dnsbh2TvQTXtA+LHFE+IbGfjF6+/rX89Gxx1Bf4rYqcQjchwhqvkt8E7X+yvQmeYSh
         17BiIVWs3vJfc0TjWohrO3grAg/2GXJwB9a5Ni8bcbcbb0XsUjvXCT41xyosrU3pQuFx
         Nx6ggQPuwmM2VpCh7wBS21JY/mojOFXFC0zCgPUd5ltOkm7XxxPn9diqBP3SEkCCHzwd
         /vpqmoTdx00bVs0SkAZE3W92GuacqQQBYgFvJzN0+Nk2GR9QJa2mVq1O4endMz6HqqYO
         eTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8y0VPNTgZTQu+dDzGDg65lSnAXwX3wAhedjIn63SFis=;
        b=mTYRnvzzDkl1gkroDEMjIYRoeqHwJXk7cLIvcZgGT3crwHlBT8JmkgVQ+jE6mTuEtt
         +M9tZRpXlPdcTYmqErM5Cle5YOV71bfsaCtIsxELr0bxc0ycku0TpYUSREVzMXHXig6d
         o7aBN7lZH33dUjQuX/cmAgkjU9QKfOteRopam1EbLTYI/Bhucz61ShRy/oVXjkCyccbX
         DbCfkTulqdZawoCsJp/IrvdcCMvMvb0lZs5RGilO/vAUc5hKI6aodW4FdairYtp/VswV
         ULARyVy/hwhKN2A1uwoDnpsr6wC4ZdFNn596R2hLrVkAVsmqiLbcLhcjVZlQt2nxsyzM
         uiSg==
X-Gm-Message-State: AOAM531MXZ60ED5ZZkUPn0Yo61Q8hSgjeAyfDV2roLmbFRUbxPQwoegL
        ftI74M08La3NHxn/D7E+Bm6Au+3gHr6qbw==
X-Google-Smtp-Source: ABdhPJwktA9Y8lWyerWMAWGQ8BcXfHsdg/o2tttP3ijSbh5pOuQWMvxtewR1sCS1sh7iuc2dD922rw==
X-Received: by 2002:a17:906:26ce:: with SMTP id u14mr72600752ejc.559.1636105417498;
        Fri, 05 Nov 2021 02:43:37 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id r22sm3766564ejd.109.2021.11.05.02.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Nov 2021 02:43:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: block: please restore 2d52c58b9c9b ("block, bfq: honor
 already-setup queue merges")
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <a66f5127-8b0b-d21a-eda5-73968255b52c@kernel.dk>
Date:   Fri, 5 Nov 2021 10:43:34 +0100
Cc:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <672815A0-3C5B-4DCD-9583-24497FC31D5D@linaro.org>
References: <65495934-09fe-55b0-62a9-c649dc9940ba@applied-asynchrony.com>
 <a66f5127-8b0b-d21a-eda5-73968255b52c@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 4 nov 2021, alle ore 15:41, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 11/4/21 8:04 AM, Holger Hoffst=C3=A4tte wrote:
>>=20
>> Hi Jens,
>>=20
>> a simple no-code request:
>>=20
>> Commit d29bd41428cf ("block, bfq: reset last_bfqq_created on group =
change")
>> fixed a UAF in bfq, which was previously worked-around by =
ebc69e897e17
>> ("Revert "block, bfq: honor already-setup queue merges"").
>>=20
>> However since then the original commit 2d52c58b9c9b was never =
restored.
>>=20
>> Reinstating 2d52c58b9c9b has so far not resulted in any problems for =
me,
>> and I think it would be nice to bring it back in early just to get
>> feedback as early as possible in this cycle.
>=20
> Adding Paolo.
>=20

Yep, now that we have the fix, we should restore that commit.

Thanks Holger,
Paolo

> --=20
> Jens Axboe
>=20

