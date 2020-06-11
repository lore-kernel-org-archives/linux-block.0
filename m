Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D6AC433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 07:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD04207D5
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 07:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ud9Z4XFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgFKHLV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKHLU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 03:11:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B22C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 00:11:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m21so3153655eds.13
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 00:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r5wt2pQQFZjguSIYwergirOyu4I1I+efnrEUIqu9p8g=;
        b=ud9Z4XFRi+ElUv6UJYgwXaWt1LTU1Ap/HgpEbUfExb02NEREFSZDeLyXu6oqhKlew/
         81DQBM3ESgxpu7h8f8/jLEjzXYIpV8DY5VAILu2fMh1vMrG1jJJqE3ZNM8hXSc1ErSB5
         0N9isc9OYicVLPqiw2saETulq1LP4Z4fSYAGuQZ8k13nAaZ89GUHDz5ssu7qZjLlVgXm
         gzulL0CahpeVaZ++VpBfF+rtw90Xx149ciVqcmiG/eobRpiat1qrtBDqQ1N50yvbIHTZ
         V4y7BnV3+7Pze0rVMXSHccvlsfncV1gMCBUOagnVF8uZ9Vc0H1Cute1unnmgYAIacbcs
         QTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r5wt2pQQFZjguSIYwergirOyu4I1I+efnrEUIqu9p8g=;
        b=IjnwWWjUPvqb+LG7VpvNSC5DL74D9Dgv7oihCT3b/UPaoYMuDOY1+lt/lD6wLLxfKy
         Dc4AwvQLzDNq7TmaSZCqguJ9TK95VlvwO7/x4qkjhkWK8Pc52gJtsMCMgxrz9ebWWEAj
         7SpOihkK0I2gcE4PAkVkYZkuUJyJatMQ8GqrIK1UQT3Q5sQftTM7zwDCnVtcvQGpnA97
         PJFtCvJJlUdWNHorWx/K91t/zDF0EstwxDYIsTPwRmmzeqqNYy2eQdkeA5BUFLm2F/Kl
         q7AqY9TGgHmkNI0tv48VJb2k+QMw9K1kWP41LxM0zBbfM0pIkq+PBb4ittb3pCaANzAY
         0Kng==
X-Gm-Message-State: AOAM533+D9A8Zl31O4nXiHviuCSLi/OhKXuVvAOyEJE5u8UUpWkQ31p5
        nTluB7cmFKwRwhVDdTkItzZtkg==
X-Google-Smtp-Source: ABdhPJzJc3MaUqbwCPT24QpE5DligjoUuxJLGrrxCTS1e+GCI/7pCzjUTGVIgp/k9WfdfBuvp1wEog==
X-Received: by 2002:aa7:d6d0:: with SMTP id x16mr5950072edr.175.1591859478857;
        Thu, 11 Jun 2020 00:11:18 -0700 (PDT)
Received: from [192.168.0.14] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id la5sm1347338ejb.94.2020.06.11.00.11.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 00:11:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/3] bfq: Use 'ttime' local variable
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200605141629.15347-2-jack@suse.cz>
Date:   Thu, 11 Jun 2020 09:14:38 +0200
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7ADC14C0-9252-4C6C-9D32-2AAFD45FDF22@linaro.org>
References: <20200605140837.5394-1-jack@suse.cz>
 <20200605141629.15347-2-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 5 giu 2020, alle ore 16:16, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Use local variable 'ttime' instead of dereferencing bfqq.
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks!

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 50017275915f..c66c3eaa9e26 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5196,7 +5196,7 @@ static void bfq_update_io_thinktime(struct =
bfq_data *bfqd,
>=20
> 	elapsed =3D min_t(u64, elapsed, 2ULL * bfqd->bfq_slice_idle);
>=20
> -	ttime->ttime_samples =3D (7*bfqq->ttime.ttime_samples + 256) / =
8;
> +	ttime->ttime_samples =3D (7*ttime->ttime_samples + 256) / 8;
> 	ttime->ttime_total =3D div_u64(7*ttime->ttime_total + =
256*elapsed,  8);
> 	ttime->ttime_mean =3D div64_ul(ttime->ttime_total + 128,
> 				     ttime->ttime_samples);
> --=20
> 2.16.4
>=20

