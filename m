Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A661C46467
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 18:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjAPSWr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjAPSW0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 13:22:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5683A59C
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:09:26 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vw16so6784370ejc.12
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMh+ag8vr1xnoV0VXFDBTyfjJzh0NwEeniwxIxd/A40=;
        b=R2Sm3nuFTkPJut01DoV2RheH9x3+eGtgZbLkhTbP9rKrq7UTNNK+pmh26R+NZ9Soq4
         6MuYLCjPvFOx/eg2M4Gv5hDgUATKdZT55J/aTFGPkNVQo8buVIw/z7jApHS/dPvNnSht
         mLrP2fsQDvZT/mGcvpotcOybR68VwxbIUxu3JymdNt2xKt7KpFTpX7nm5sjLmsphu5q3
         1lemg3DpTGw/NUCUDdLmjO+mVurQJXCzzmtGlGNjq1M7mVkBMopTK+GHsqMwmOBu/guO
         BLapKsEatLAdqu/hgDFeeziIbEZV5pcGh96gYvlMPTZ/F6Jkqan7ZUKZ4Kk8G1mwqSK0
         YImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMh+ag8vr1xnoV0VXFDBTyfjJzh0NwEeniwxIxd/A40=;
        b=JpEB5Vd4svbU2QDe4tofMz+tsej2MC2vuxOgzt5SXwG4CM4pAqGHx4/YWtHOBE5VBA
         D6P5Od74vp6EsI++wYftC7dmHjzTQX7NIZibF6nQqo5sKN/RfUZgZGJ0XOUf21f101gd
         cqSMD3wjY/eAsaBl1TUISFVtRMVMBtS0CxpOb7XFDGEMnm1STls+QeAkrCVFmjOYnsNf
         L9YlxuGjkNqfoZ81vhMta8EPMFopAvpo/SK6CWxigvo+zuxMFpqf4ZuQADyOMK9PhL+O
         +pTQxzNQQPS8cQC9BYUWmVcdmcAZH2xPe6NiRAGCKZG9dtPKEMxn3E91aeRnFdoqC1IZ
         cjiQ==
X-Gm-Message-State: AFqh2kqpCpwy+JqJYXXfTn5p2YzF3u9ElcxFHpBIOqIHeIHSSkCq3feD
        cmZZ2veRksWNcYov592siHnA/w==
X-Google-Smtp-Source: AMrXdXtbmoQvHe7gKOBIxs8Lw0/nzZxF1CwnNnLTCO+8jOU582ZIrY8sWvohCz4BEniyDw94GQS3vA==
X-Received: by 2002:a17:906:264f:b0:86f:b99c:ac8d with SMTP id i15-20020a170906264f00b0086fb99cac8dmr6110224ejc.44.1673892564713;
        Mon, 16 Jan 2023 10:09:24 -0800 (PST)
Received: from mbp-di-paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170907778600b0086b0d53cde2sm4028360ejc.201.2023.01.16.10.09.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:09:24 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V13 REBASED 0/8] block, bfq: extend bfq to support
 multi-actuator drives
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20230116130341.lci7hixndnxvjuhz@quack3>
Date:   Mon, 16 Jan 2023 19:09:23 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>, glen.valante@linaro.org,
        damien.lemoal@opensource.wdc.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D3BE66C-8E36-4D32-BEF3-B500133CA66B@linaro.org>
References: <20230103145503.71712-1-paolo.valente@linaro.org>
 <20230116130341.lci7hixndnxvjuhz@quack3>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 16 gen 2023, alle ore 14:03, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Hi Paolo!
>=20
> On Tue 03-01-23 15:54:55, Paolo Valente wrote:
>> Here is the whole description of this patch series again.  This
>> extension addresses the following issue. Single-LUN multi-actuator
>> SCSI drives, as well as all multi-actuator SATA drives appear as a
>> single device to the I/O subsystem [1].  Yet they address commands to
>> different actuators internally, as a function of Logical Block
>> Addressing (LBAs). A given sector is reachable by only one of the
>> actuators. For example, Seagate=E2=80=99s Serial Advanced Technology
>> Attachment (SATA) version contains two actuators and maps the lower
>> half of the SATA LBA space to the lower actuator and the upper half =
to
>> the upper actuator.
>>=20
>> Evidently, to fully utilize actuators, no actuator must be left idle
>> or underutilized while there is pending I/O for it. To reach this
>> goal, the block layer must somehow control the load of each actuator
>> individually. This series enriches BFQ with such a per-actuator
>> control, as a first step. Then it also adds a simple mechanism for
>> guaranteeing that actuators with pending I/O are never left idle.
>>=20
>> See [1] for a more detailed overview of the problem and of the
>> solutions implemented in this patch series. There you will also find
>> some preliminary performance results.
>=20
> Sorry, I didn't find time to look into this earlier. I've just had a
> high-level look into the patches and I have one question: Did you =
consider
> a solution where you'd basically duplicate all of the scheduling for =
each
> actuator (thus making them effectively independent devices from the =
point
> of view of BFQ)?

Yep, I did.

> =46rom the first look it would look like somewhat simpler
> solution than splitting all the BFQ queues and implementing special
> injection mechanism for other actuators and perhaps lead to better
> utilization of the actuators. OTOH the latecy and QoS for tasks using
> multiple actuators would be probably worse because it would be =
basically
> determined by the busiest of the actuators.

Exactly, that's why I had to keep all queues in the same bucket.

Thanks for both asking and answering! :)

Jokes apart, thank you a lot for having a look at this contribution,
Paolo

> So I'm asking mostly out of
> curiosity :)
>=20
> 								Honza
>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

