Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA26C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 14:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86CA2083E
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 14:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGcIY12W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFKOJB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgFKOJA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 10:09:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6661C08C5C2
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 07:08:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y13so6633675eju.2
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ywxAzDifu4/Lt4nUclP2yZ7GdJmm8BVW01PZ3M/CpuU=;
        b=dGcIY12W7IQN/4zKQpo+enj84L9FnrrJ4Z4DvDO8uXvIyn7V9tjmYK4R83qhrEaKN8
         gXV4S0MoR27uqIQqyWnNdXa4Ri0i5itrlxLkUREhGvKw87qMZGc46/baDbSYaxg3TaPw
         iC9ts+ubPddq0s0nLTHJ66HnPNUn/117dPJBLfTzmPbzRrr/fft6Eerf3KL08hRSDRNh
         b9VEvKLp3qzK6/XXTJqbakQbLCgL53KKEykSJ9QRdNw+qR0VKGGB5GCAc6AEU/FDBndh
         VwxtmmFGBuk6QnNT9C2FwKrrIqirRFP8uFI/eQ5KIWiU7Lg/fTsoY1S6s8inQc1401I3
         npIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ywxAzDifu4/Lt4nUclP2yZ7GdJmm8BVW01PZ3M/CpuU=;
        b=Uey7sBgKdg/GNz1YOnIiLXabBCw4vIisKoWoFLnqDrgX3rTNUcbMNYXeOhiuLX1WYx
         iMwfDYRr8ys0SWQVNFL0WnVgWLOqwi0jdtPv7D8bbZ0l3CoumNk4hHr4mIgm5pnLh2dz
         TAn2yIKIO7sLsMWeeFl0n5sFBffUWR/6zz87i6AG1CM12NO+KFb55s3D+jSX2H8lhniZ
         4t/rDGHk2yvPPZfCGcu//JtXIjSme72CGe0DIMYw+kHQA7hSHOXvXSq4n4RaSlSrPTsc
         PqeF6qaHw7ndSTogCiDQ+45gs8B6HPrmeJ8x8e7o4S4aO9VeZ5KhgXKyF2WUgjVTY8WN
         nzQA==
X-Gm-Message-State: AOAM530wl4HB1B9pAaSquMB02N+eikqAbP1l17rHjtc+5rlFlpvSy7iv
        7U0ok22DZxU8QSYdX5dPWlC3lQ==
X-Google-Smtp-Source: ABdhPJzHCFEYHDE6Y7f7Zi15DPw4zTS2b17SG2jrg9z9gfMVBuW/Q5+jGH7XSAHxsu3sm33u9sB3mg==
X-Received: by 2002:a17:906:7acf:: with SMTP id k15mr8830436ejo.410.1591884536972;
        Thu, 11 Jun 2020 07:08:56 -0700 (PDT)
Received: from [192.168.0.2] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id n16sm1918051ejl.70.2020.06.11.07.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 07:08:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/3] bfq: Avoid false bfq queue merging
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200611083149.GB18088@quack2.suse.cz>
Date:   Thu, 11 Jun 2020 16:12:15 +0200
Cc:     linux-block <linux-block@vger.kernel.org>, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF7DA035-BC93-42D2-B0B6-8ECC3273DEBC@linaro.org>
References: <20200605140837.5394-1-jack@suse.cz>
 <20200605141629.15347-1-jack@suse.cz>
 <FC3651A1-DB65-4A77-9BFB-ACAB80E54F3E@linaro.org>
 <20200611083149.GB18088@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 11 giu 2020, alle ore 10:31, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Thu 11-06-20 09:13:07, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 5 giu 2020, alle ore 16:16, Jan Kara <jack@suse.cz> ha =
scritto:
>>>=20
>>> bfq_setup_cooperator() uses bfqd->in_serv_last_pos so detect whether =
it
>>> makes sense to merge current bfq queue with the in-service queue.
>>> However if the in-service queue is freshly scheduled and didn't =
dispatch
>>> any requests yet, bfqd->in_serv_last_pos is stale and contains value
>>> from the previously scheduled bfq queue which can thus result in a =
bogus
>>> decision that the two queues should be merged.
>>=20
>> Good catch!=20
>>=20
>>> This bug can be observed
>>> for example with the following fio jobfile:
>>>=20
>>> [global]
>>> direct=3D0
>>> ioengine=3Dsync
>>> invalidate=3D1
>>> size=3D1g
>>> rw=3Dread
>>>=20
>>> [reader]
>>> numjobs=3D4
>>> directory=3D/mnt
>>>=20
>>> where the 4 processes will end up in the one shared bfq queue =
although
>>> they do IO to physically very distant files (for some reason I was =
able to
>>> observe this only with slice_idle=3D1ms setting).
>>>=20
>>> Fix the problem by invalidating bfqd->in_serv_last_pos when =
switching
>>> in-service queue.
>>>=20
>>=20
>> Apart from the nonexistent problem that even 0 is a valid LBA :)
>=20
> Yes, I was also thinking about that and decided 0 is "good enough" :). =
But
> I just as well just switch to (sector_t)-1 if you think it would be =
better.
>=20

0 is ok :)

Thanks,
Paolo

>> Acked-by: Paolo Valente <paolo.valente@linaro.org>
>=20
> Thanks!
>=20
> 								Honza
>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

