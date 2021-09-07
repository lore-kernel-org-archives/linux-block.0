Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F276C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A99D61106
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 09:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbhIGJLR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244799AbhIGJLQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 05:11:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18031C061757
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 02:10:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h9so18340406ejs.4
        for <linux-block@vger.kernel.org>; Tue, 07 Sep 2021 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n5+hR87J9jGsWkS18UhQx1xHYTAbX3jyL7zc+byYnoE=;
        b=J6WXwrXM6MdanWnIZTBBErxz8LsqiBupx2Hk+Qs04dCov+47QRyfhsn0Whb+ii1Ir7
         CZinwkkKrXjXlx1t7HWzAg74O1S0dghPmdZy9FQY9atom9A6shfizVVmq2oy/iiXN9Gw
         6HyJAAWLK96z6VzsWqPWuJj/Bg4F/2MHmHSAhIvdnz8AM1QIJgqYh+LfQJx4ZjfgWPK7
         3czXE3s/2HG+EU+KsT0Xe9L/PRrAqYDD2vUmMMDbYmeOK/jIrnHPWw5WGMqTClwMSkYH
         tKhFW+zIycZxNlyacYrdDxXy+f3SYv7DEGG1W+214oadaY13qnBnyZzLuEGSi1kEfHA9
         70Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n5+hR87J9jGsWkS18UhQx1xHYTAbX3jyL7zc+byYnoE=;
        b=OjrMa8ChqtcyY9ECRBVhpd/kwblHE6mscithAobqk2i8aiG98GZliadMrq1WItdg3x
         Y0dX5oKZ81AKn7TUeFSV0omy+Oeo1KmudNUX7Ddlk3n4hE8Vjv+yGuQf4kBYzzg8ah9G
         g1NUfbO69R3VhXyboDHxJS3pryKXR6qr65DobGa8fwxuSbM3TB+7RXWRV9WZ275X3rqy
         1PGqgbuC45xv4PZSAtNXMdbYT/88hMkYcgVRAyuoB8BBci5OZWPce7HvTuAE7uypM1da
         iY/TNdxipwZL1hPO7OQAheeliO4FJrDZCrFcXt+VHIUAGk2vSCZ2J1C2gIWcfoHNOn6j
         493w==
X-Gm-Message-State: AOAM530ZvMndivt6w2iJyei5pkHaieVhRRCnI4iqMSzsdsFf5If8ksXO
        2DzLIFXYJyF/ehttjcic9CyzLg==
X-Google-Smtp-Source: ABdhPJy/YBmN91bP9G+ttPy7MX183v9h/jDq0tqOedtJk2zJwFGmDKT/uiQ89oLmV+arDTeAnMIjEw==
X-Received: by 2002:a17:906:681:: with SMTP id u1mr17366604ejb.499.1631005808680;
        Tue, 07 Sep 2021 02:10:08 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id w13sm6525460ede.24.2021.09.07.02.10.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 02:10:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 2/4] block, bfq: do not idle if only one cgroup is
 activated
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <da0e53b4-e947-9c91-832e-36da67037f0f@huawei.com>
Date:   Tue, 7 Sep 2021 11:10:02 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1ADC992-11AE-4511-9033-D233CBCA6F26@linaro.org>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
 <20210806020826.1407257-3-yukuai3@huawei.com>
 <21FA636D-2C21-4ACD-B7DE-180ABB1F3562@linaro.org>
 <da0e53b4-e947-9c91-832e-36da67037f0f@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 2 set 2021, alle ore 15:31, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> On 2021/08/27 1:00, Paolo Valente wrote:
>> Why do you make these extensive changes, while you can leave all the
>> function unchanged and just modify the above condition to something
>> like
>> || bfqd->num_groups_with_pending_reqs > 1
>> || (bfqd->num_groups_with_pending_reqs && =
bfqd->num_queues_with_pending_reqs_in_root)
>=20
> Hi, Paolo
>=20
> I was thinking that if CONFIG_BFQ_GROUP_IOSCHED is enabled, there is =
no
> need to caculate smallest_weight, varied_queue_weights, and
> multiple_classes_busy:
>=20
> If we count root group into num_groups_with_pending_reqs
> - If num_groups_with_pending_reqs <=3D 1, idle is not needed

Unfortunately, if active queues have different weights or belong to
different classes, then idling is needed to preserve per-queue
bandwidths.

Thanks,
Paolo

> - If num_groups_with_pending_reqs  > 1, idle is needed
>=20
> Thus such changes can save some additional overhead.
>=20
> Thanks
> Yu Kuai
>=20
>> In addition, I still wonder whether you can simply add also the root
>> group to bfqd->num_groups_with_pending_reqs (when the root group is
>> active).  This would make the design much cleaner.
>> Thanks,
>> Paolo
>>> -#endif
>>> -		;
>>> +	return varied_queue_weights || multiple_classes_busy;
>>> }
>>>=20
>>> /*
>>> --=20
>>> 2.31.1
>>>=20
>> .

