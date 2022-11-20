Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9574BC4332F
	for <linux-block@archiver.kernel.org>; Sun, 20 Nov 2022 07:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiKTH3e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Nov 2022 02:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKTH3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Nov 2022 02:29:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43111ADA6
        for <linux-block@vger.kernel.org>; Sat, 19 Nov 2022 23:29:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id me22so5634177ejb.8
        for <linux-block@vger.kernel.org>; Sat, 19 Nov 2022 23:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhaA28SrbPMMmFWQjGS1ZDklxowb9TkOu4xMxzc8d8s=;
        b=THTybPzTOccPoBPrtNh/yFrEN8Fn3JOm27nd3lag4ZfqVRfRnBT2SzHjZsifyLRLLC
         Dl7XIGh8hMZOmmq4BkRdMctUfNnUkX0WSPdpZb4VI6BeaWAPV3FLLOQxaBAIi6C7svFR
         QKlfkp9s2XLfqo50f7b45ZQUAYUTkFFpS38Mtpt8xp9gSSjcWNVGw1lnGzpdT79zSOT9
         Sn1DTf+W4vJDBKO5kYHQ0bkBozIbwk5rACSJCS8EdMHkzLqzsqtF7HNRq0W5dm0AoZe5
         ybKImoUBHS2wqpBuD0d8c2UiqajIZ2l59z+Dhrg623CEd1m8aJA44xdisMr0Wl8fWxNm
         eK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhaA28SrbPMMmFWQjGS1ZDklxowb9TkOu4xMxzc8d8s=;
        b=bKrZKxcvFpfMS2Jfj8hd9Ef2H2U3ompTPPYjMb1V7PXKGE69TwzAMBzQ1GXeUH0N8B
         13Gdb2WpDOXMRCiidRwVq++gOclCr+2uLkpJZaKGldQ15NnA+nRpcjd/zj1/BSPCwcE+
         lTHe4cOOVKOi+1Y4/MgukaTgqXGr2BLPQXe6piLaY9ee0RBLbBeRcCB4C5mNXTGJJrq4
         VMNACYG2QW/5N4GGTiFD3tldl9jobU81/3UDvxfL8VvlfmMaSPNgjn9YxS3txc+FLhIa
         PsdcVR48rOdkeHkr6yBlk8FgLwcGxt3oGQ8DHAN5mWifeXpdkNdQADgGKLgq6+J1Jt66
         02gA==
X-Gm-Message-State: ANoB5pk5eVtBG/LzEbhWswTNE36mQtmDv9iocX8guOzL94uGBPMK2a4b
        D3cKEsKImh4/iZDg11ZeieL6Bw==
X-Google-Smtp-Source: AA0mqf5opWFpeAqRtfpfduqQL0eR4TzB+zc8IRQD96xlLhkkOIOElywDwZ1p/u4yl+uIZ2c3eLTgpg==
X-Received: by 2002:a17:906:8d86:b0:78d:4742:bb62 with SMTP id ry6-20020a1709068d8600b0078d4742bb62mr443963ejc.43.1668929370113;
        Sat, 19 Nov 2022 23:29:30 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906300c00b0078194737761sm3670640ejz.124.2022.11.19.23.29.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Nov 2022 23:29:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V6 8/8] block, bfq: balance I/O injection among
 underutilized actuators
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <PH7PR20MB5058FFC62E46AB2AE3AB0F38F1019@PH7PR20MB5058.namprd20.prod.outlook.com>
Date:   Sun, 20 Nov 2022 08:29:27 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rory Chen <rory.c.chen@seagate.com>,
        Davide Zini <davidezini2@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB99E53F-886D-4193-9B38-32452E70A35B@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-9-paolo.valente@linaro.org>
 <PH7PR20MB5058FFC62E46AB2AE3AB0F38F1019@PH7PR20MB5058.namprd20.prod.outlook.com>
To:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 10 nov 2022, alle ore 16:25, Arie van der Hoeven =
<arie.vanderhoeven@seagate.com> ha scritto:
>=20
> Checking in on this series and what we can communicate to partners as =
to potential integration into Linux.  Is 6.1 viable?

Hi Arie,
definitely too late for 6.1.

Jens, could you enqueue this for 6.2?  Unless Damien, or anybody else
still sees issues to address.

Thanks,
Paolo

>=20
> We have at least one big partner whose launch schedule is gated on =
these changes.
>=20
> Regards,  --Arie
>=20
>=20
> From: Paolo Valente <paolo.valente@linaro.org>
> Sent: Thursday, November 3, 2022 9:26 AM
> To: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; =
linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Arie van =
der Hoeven <arie.vanderhoeven@seagate.com>; Rory Chen =
<rory.c.chen@seagate.com>; Davide Zini <davidezini2@gmail.com>; Paolo =
Valente <paolo.valente@linaro.org>
> Subject: [PATCH V6 8/8] block, bfq: balance I/O injection among =
underutilized actuators
>=20
>=20
> This message has originated from an External Source. Please use proper =
judgment and caution when opening attachments, clicking links, or =
responding to this email.
>=20
>=20
> From: Davide Zini <davidezini2@gmail.com>
>=20
> Upon the invocation of its dispatch function, BFQ returns the next I/O
> request of the in-service bfq_queue, unless some exception holds. One
> such exception is that there is some underutilized actuator, different
> from the actuator for which the in-service queue contains I/O, and
> that some other bfq_queue happens to contain I/O for such an
> actuator. In this case, the next I/O request of the latter bfq_queue,
> and not of the in-service bfq_queue, is returned (I/O is injected from
> that bfq_queue). To find such an actuator, a linear scan, in
> increasing index order, is performed among actuators.
>=20
> Performing a linear scan entails a prioritization among actuators: an
> underutilized actuator may be considered for injection only if all
> actuators with a lower index are currently fully utilized, or if there
> is no pending I/O for any lower-index actuator that happens to be
> underutilized.
>=20
> This commits breaks this prioritization and tends to distribute
> injection uniformly across actuators. This is obtained by adding the
> following condition to the linear scan: even if an actuator A is
> underutilized, A is however skipped if its load is higher than that of
> the next actuator.
>=20
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Davide Zini <davidezini2@gmail.com>
> ---
> block/bfq-iosched.c | 18 +++++++++++++-----
> 1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index db91f1a651d3..c568a5a112a7 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4813,10 +4813,16 @@ bfq_find_active_bfqq_for_actuator(struct =
bfq_data *bfqd,
>=20
> /*
>  * Perform a linear scan of each actuator, until an actuator is found
> - * for which the following two conditions hold: the load of the
> - * actuator is below the threshold (see comments on =
actuator_load_threshold
> - * for details), and there is a queue that contains I/O for that
> - * actuator. On success, return that queue.
> + * for which the following three conditions hold: the load of the
> + * actuator is below the threshold (see comments on
> + * actuator_load_threshold for details) and lower than that of the
> + * next actuator (comments on this extra condition below), and there
> + * is a queue that contains I/O for that actuator. On success, return
> + * that queue.
> + *
> + * Performing a plain linear scan entails a prioritization among
> + * actuators. The extra condition above breaks this prioritization =
and
> + * tends to distribute injection uniformly across actuators.
>  */
> static struct bfq_queue *
> bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
> @@ -4824,7 +4830,9 @@ bfq_find_bfqq_for_underused_actuator(struct =
bfq_data *bfqd)
>        int i;
>=20
>        for (i =3D 0 ; i < bfqd->num_actuators; i++)
> -               if (bfqd->rq_in_driver[i] < =
bfqd->actuator_load_threshold) {
> +               if (bfqd->rq_in_driver[i] < =
bfqd->actuator_load_threshold &&
> +                   (i =3D=3D bfqd->num_actuators - 1 ||
> +                    bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) =
{
>                        struct bfq_queue *bfqq =3D
>                                bfq_find_active_bfqq_for_actuator(bfqd, =
i);
>=20
> --
> 2.20.1
>=20
> Seagate Internal

