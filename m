Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A567C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B60321873
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cc5xq1Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeLRSUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:20:01 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35908 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeLRSUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:20:01 -0500
Received: by mail-wm1-f41.google.com with SMTP id p6so3518059wmc.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vSHsHjjZD+P52/JnFwbPWh1jnt2NYGO1YQJj86+ufxc=;
        b=cc5xq1KsZmgCztFXlqpeh/3Fza7USyS8p0bhTa4Ji3yVHa+tsjHd8yIQbnek7WdoVD
         NLyIUp13hn/Aq4IDmI7JQ4mnPcZBaw/HEqMXzmVn5SMqKQDs5kiKcz1WDP51vVi2ffwX
         4y6zboYDwVxO7WZDalSqaka39ZQ2mQBqOXl+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vSHsHjjZD+P52/JnFwbPWh1jnt2NYGO1YQJj86+ufxc=;
        b=VklUKoAO7wHbxm7rBjU84eUnRVkzJG1DQ0hYu2tRBx+USO2gEZOlZIi0StR+qhY2Sp
         HvjZluB/VRC6hExR86d6uTHwLSyS7YBRI2NEB25KCDuw1oF8AxPR6Kd+wb7voCpdkoag
         eOqU5KAFKMI5Rdqx0PAFM8Mm/6W/DhaSQ7e1I9HJ2jxJMcCwcpK5COtZ0w4u5qH3B3Tn
         4ORFHSYvH43L+tPiBtrdqfrbsxebS6Y8QIpa5QvK+EBEFZnw7z2CV57FddQj/RC4lf5A
         g508M4AAWowxDy6nQspQnyItBSrb+bJoXj0Xn5RaJqKfkO5LUchIroLi8vivqkz7ahY/
         Nk/w==
X-Gm-Message-State: AA+aEWZGawstdD81d73W0bPoP2zXFGFI57el2j2ULjFv1SKcSklAhX/X
        vh8WwXUADTTG1ZpSvdXGTtpvQg==
X-Google-Smtp-Source: AFSGD/UJ9nAGrb+sD/636RojQ9uvfOza8H163BHKNza8333zavLilv3WcO+qx/t3g+EadI9aK61lOA==
X-Received: by 2002:a1c:8cd0:: with SMTP id o199mr4022531wmd.56.1545157199392;
        Tue, 18 Dec 2018 10:19:59 -0800 (PST)
Received: from [192.168.0.100] ([84.33.66.6])
        by smtp.gmail.com with ESMTPSA id n82sm2989023wma.42.2018.12.18.10.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:19:58 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Unintuitive scheduling results using BFQ
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <eb245572-a504-37d6-dd15-d1b502816940@kernel.dk>
Date:   Tue, 18 Dec 2018 19:19:57 +0100
Cc:     Madhav Ancha <mancha@tower-research.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0CEF3DD1-E360-4366-A756-78274F306AE4@linaro.org>
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
 <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org>
 <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
 <C8B5F877-6F4B-46AD-9AC9-BAE91C754A5F@linaro.org>
 <CA+XCsb8eiq7w-W5ecPNdnqvrv1dU4Vkq=HfKCG=MoQi_CekPBg@mail.gmail.com>
 <255AD47C-65DD-4F22-9E64-8DF9DD81B83B@linaro.org>
 <eb245572-a504-37d6-dd15-d1b502816940@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 18 dic 2018, alle ore 19:08, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 12/18/18 11:04 AM, Paolo Valente wrote:
>> static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
>> {
>> -	return !bfq_varied_queue_weights_or_active_groups(bfqd);
>> +	/*
>> +	 * For queue weights to differ, queue_weights_tree must contain
>> +	 * at least two nodes.
>> +	 */
>> +	bool varied_queue_weights =3D =
!RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
>> +		(bfqd->queue_weights_tree.rb_node->rb_left ||
>> +		 bfqd->queue_weights_tree.rb_node->rb_right);
>> +
>> +	bool multiple_classes_busy =3D
>> +		(bfqd->busy_queues[0] & bfqd->busy_queues[1]) |
>> +		(bfqd->busy_queues[0] & bfqd->busy_queues[2]) |
>> +		(bfqd->busy_queues[1] & bfqd->busy_queues[2]);
>=20
> I don't think this does what you want it to, looks like these should =
be
> logical AND and OR.
>=20

Absolutely, sorry. Fortunately, the end result is still correct :)

I'll fix this mess in the final patch.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

