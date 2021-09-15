Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 07:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6890160F51
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 07:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhIOHiV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhIOHiV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 03:38:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D594C061574
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 00:37:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hx25so4116948ejc.6
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=415Blr3Q/Gqr6sE+2qW0icFFyR7iU8ysTZ1/UKJFKvk=;
        b=gS7tx1MuDrOQeAB0qPWwo5Rou2795lkeTLNHk1iErOumxHljeKE+36FKX0LkSmKG6L
         znZCynIIyUdX+ccYI01/s9IJafOENawwt4vokbUkPaxmdqxk1+TJdCcXGQJKAW+sH+Kc
         1klnd8l9rEYajeqnwymD+UYS5ySmE4qKU23Od9XrurcFWyBQu9ZHmlf+FJD+A8ScfSKI
         fxTolFKzO97rGtYq6KSzrR7J0B9kyNiVCIMGVcfT5qInc7vfJe6B0CEPLLlxV8zG/k42
         j7PdLXLNKWf7iF+RmXVYcayEIH7aM9ncbo7OLho/Rz6NyrR1FUWrRIEgzreAE5Al45CV
         Q3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=415Blr3Q/Gqr6sE+2qW0icFFyR7iU8ysTZ1/UKJFKvk=;
        b=SdYd7HZOGSKSKzjGq/xuH5SGh7lWe4Cb9e8eXbR1aUtm0x0Y/5Xe+cIBut7uePjNUO
         emVja1qoPzR3js5/zPX49Muna4zVaP8xqQzWjP5dIxZHE3YILkscFhQ0umpc+LCltrme
         +xtsv60ze2cqVXA88+oKn+NmRDexPPLDjjh/SFPRSM0BXvov/4VUrAchg1TmXXvNR+Js
         NEDW0ynSjsKi0hAiyfO4eH6gopcD1xxJunymK5euLYvQn4lB2hkZ1aKHn82XXhC/kC5T
         p7Rq+jwz1FM5NsEALKe3Eguqwj1qh42qqNW6o3+JzORj5BTdARF+QU6dwNFLw69DXauq
         K90Q==
X-Gm-Message-State: AOAM531LUrSRJdMt7VoxdFeAyoH9TrkWL5mpO+eWbzPoMJkCDnh+iOLd
        pVIqUGJMjnTyRty1gEBDp2//yQ==
X-Google-Smtp-Source: ABdhPJxEPsmiA59Fnh54y6VEPVQUfyGawMpxS8b0tugd2vhbZmZAyqpkOCTpQmHmEUVwk/N0fRRv0g==
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr22921688ejr.398.1631691421078;
        Wed, 15 Sep 2021 00:37:01 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t3sm6609895edt.61.2021.09.15.00.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 00:37:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 4/4] block, bfq: consider request size in
 bfq_asymmetric_scenario()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <143fa1a2-de5f-b18a-73d9-8e105844709c@huawei.com>
Date:   Wed, 15 Sep 2021 09:36:58 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <68A2B4C8-48A5-45F3-8782-2440C0028161@linaro.org>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-5-yukuai3@huawei.com>
 <8601F280-2F16-446A-95BA-37A07D1A1055@linaro.org>
 <143fa1a2-de5f-b18a-73d9-8e105844709c@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 7 set 2021, alle ore 13:29, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> On 2021/08/27 1:00, Paolo Valente wrote:
>>> Il giorno 6 ago 2021, alle ore 04:08, Yu Kuai <yukuai3@huawei.com> =
ha scritto:
>>>=20
>>> There is a special case when bfq do not need to idle when more than
>>> one groups is active:
>>>=20
>> Unfortunately, there is a misunderstanding here.  If more than one
>> group is active, then idling is not needed only if a lot of symmetry
>> conditions also hold:
>> - all active groups have the same weight
>> - all active groups contain the same number of active queues
>=20
> Hi, Paolo
>=20
> I didn't think of this contition.
>=20
> It's seems that if we want to idle when more than one group is active,
> there are two additional conditions:
>=20
> - all dispatched requests have the same size
> - all active groups contain the same number of active queues
>=20

Also the weights and the I/O priorities of the queues inside the
groups needs to be controlled, unfortunately.

> Thus we still need to track how many queues are active in each group.
> The conditions seems to be too much, do you think is it worth it to
> add support to idle when more than one group is active?
>=20

I think I see your point.  The problem is that these states are
dynamic.  So, if we suspend tracking all the above information while
more than one group is active, then we are with no state in case only
one group remains active.

Thanks,
Paolo

> Thanks
> Kuai
>=20
>> - all active queues have the same weight
>> - all active queues belong to the same I/O-priority class
>> - all dispatched requests have the same size
>> Similarly, if only one group is active, then idling is not needed =
only
>> if the above last three conditions hold.
>> The current logic, including your changes up to your previous patch,
>> is simply ignoring the last condition above.
>> So, unfortunately, your extra information about varied request size
>> should be used in the opposite way than how you propose to use it.

