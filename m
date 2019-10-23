Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34F6CA9EAE
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 05:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B919F2173B
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 05:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFQbUvYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbfJWFow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:44:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39082 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbfJWFov (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 01:44:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id r141so8674480wme.4
        for <linux-block@vger.kernel.org>; Tue, 22 Oct 2019 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yxvk4JK0S6fOQxsokBnmhH3TcJSOZWVYOtlV6nQoCzM=;
        b=IFQbUvYUvIHygSN9UBfOAvTiOyAzVBISTOa5oYkQV7XmGLlGYuvqaeduwqDjZf7K/e
         SQDZFmJeyHwpYRriWd5Nw2SSe3qrPJifJuCW0PwujfTLdYgFxe+mBVIu5EjjpfFDas4b
         ZFsJhWPjdQVgMj7ILlz3158WwsfWdOr4KiDokAQqJZsGMG+qn5d1YC6Ub6GHPn6fRbcR
         VjLGYvNaCMSA/huILsbMGgR/4rntEmKbyAOGT9zdGIt4ElfUIX9yDoehNxnQ1B8zRBjK
         D3+k9tktvAsX7k0YeKEdQ8+l3k2AFN/jC7+bAXc2YX9R2y8OKdKEqb0CDJ4jAEipvBZ0
         d9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yxvk4JK0S6fOQxsokBnmhH3TcJSOZWVYOtlV6nQoCzM=;
        b=Nx2uOdoV0IfpFyoyaQM29GUUkR9WJ6e7MK+y3y9QBTSfVGExUpkqGQeF25cz0PHLwW
         1Z/4GHgEZ1NEYlVL6rNL9WCqkM7EHGOz5PsUv8FivM2VkswLBC9TKv60+0yDUBN7vCT1
         FJNg9XscRqGX2pEkg0iSNu+sUXpVv6JSWKZgeOPtPTIgAkmkTiLkoDO9xwXQsh+fZpX2
         y403VFhYM5s1Z+elk9wkx8mtfzSYqMRADSai86QoXnJryZIfa+W9ESvZWbCzShxYj1h4
         pympJz+9Q3FMuqjvhnp/PYnmj0UZQ20APM4uRitEZBbya4FQnQ+f/r8wS5JcvKAph7el
         rC3w==
X-Gm-Message-State: APjAAAX55G0QVNrwm5Kcw7rTHDsqQvjIQ1ayAQp9If+PCbCej41dBVwN
        0ODT+ct4jGesC1YnCZmjpN99fA==
X-Google-Smtp-Source: APXvYqxWENcAhG3ml7y69a4emJVDFc6t3DUaWlnyAPA/Dv2uJdnijYtDiaKwsMRWVlPpsLWX9yZGeA==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr445601wmb.163.1571809489836;
        Tue, 22 Oct 2019 22:44:49 -0700 (PDT)
Received: from [192.168.0.102] (84-33-74-57.dyn.eolo.it. [84.33.74.57])
        by smtp.gmail.com with ESMTPSA id 200sm14202462wme.32.2019.10.22.22.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 22:44:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/2] block, bfq: make bfq disable iocost and present a
 double interface
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <19BC0425-559E-433A-ACAD-B12FA02E20E4@linaro.org>
Date:   Wed, 23 Oct 2019 07:44:47 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <94E51269-62DC-427A-A81C-3851ABC818BC@linaro.org>
References: <20191001193316.3330-1-paolo.valente@linaro.org>
 <19BC0425-559E-433A-ACAD-B12FA02E20E4@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping

> Il giorno 9 ott 2019, alle ore 16:25, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Jens, Tejun,
> can we proceed with this double-interface solution?
>=20
> Thanks,
> Paolo
>=20
>> Il giorno 1 ott 2019, alle ore 21:33, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>=20
>> Hi Jens,
>>=20
>> the first patch in this series is Tejun's patch for making BFQ =
disable
>> io.cost. The second patch makes BFQ present both the bfq-prefixes
>> parameters and non-prefixed parameters, as suggested by Tejun [1].
>>=20
>> In the first patch I've tried to use macros not to repeat code
>> twice. checkpatch complains that these macros should be enclosed in
>> parentheses. I don't see how to do it. I'm willing to switch to any
>> better solution.
>>=20
>> Thanks,
>> Paolo
>>=20
>> [1] https://lkml.org/lkml/2019/9/18/736
>>=20
>> Paolo Valente (1):
>> block, bfq: present a double cgroups interface
>>=20
>> Tejun Heo (1):
>> blkcg: Make bfq disable iocost when enabled
>>=20
>> Documentation/admin-guide/cgroup-v2.rst |   8 +-
>> Documentation/block/bfq-iosched.rst     |  40 ++--
>> block/bfq-cgroup.c                      | 260 =
++++++++++++------------
>> block/bfq-iosched.c                     |  32 +++
>> block/blk-iocost.c                      |   5 +-
>> include/linux/blk-cgroup.h              |   5 +
>> kernel/cgroup/cgroup.c                  |   2 +
>> 7 files changed, 201 insertions(+), 151 deletions(-)
>>=20
>> --
>> 2.20.1
>=20

