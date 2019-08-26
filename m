Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414CAC3A59E
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 06:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8DE2173E
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 06:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ko288Hno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfHZGgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:36:23 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:33373 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfHZGgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Aug 2019 02:36:23 -0400
Received: by mail-wm1-f44.google.com with SMTP id p77so13615847wme.0
        for <linux-block@vger.kernel.org>; Sun, 25 Aug 2019 23:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iVlNOvcGkxOW82lX/stt8mZNXgPWFfdeCPzC+y26i1w=;
        b=Ko288HnotBth8jQ1QLLaxPiIBMWT0CGuHCphEGfWiVxL3InXCHOVU/SvqRYl+8Uk7I
         maRDjlOXSxFfzYnf7uhq9Zva9futXeSmVAMYxChtvlzzMGTZEPl2c++crWSqiz+vYzQW
         /Cp3r2Uzy2vuRJ/YpuiMHfXMNBcmbxXQqfN6vuE7WQjy7ZLKu6bWXHe1bW5va0Zpsb3+
         24VCf/amP3DuZFxAtkt45Q2mSJSfihWLPi301wjgoam+Op4sqi1ZCxEN0VxTPwmi4xhQ
         AOGPUweB+T7vdpITeG+1HnPM4JAZH4qdY5b2eJyXWsk7G5mO6LrO3oWxUD+ZKN3G51bo
         EcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iVlNOvcGkxOW82lX/stt8mZNXgPWFfdeCPzC+y26i1w=;
        b=bS9qiAhs3URU5KTvorYm3M3Xbj6ZRFxbv8s4zfrMgQxhuJL1BxPYWr1pdXjOOM+naZ
         /2OXkq2qEiLYXGFC1sX7bIcDhMVbOFpwoNpx+cd/FQ4CV07rV5BrmDBpaVatJNiOzAtC
         lFGxLRgcvLeEGkpYQybjbM6Cvkwm+uNRYHsAskmobGbeIAqzE3ISn09aD4cvU78rWyFh
         L9Vp7YCt2HDBs6Bdf2E5ny9SonpD8fcOygA2FXj0d/12jxi7oD9TKhtfn1SXWgEuSief
         TJg38cRUDZ0Ym8lo6TiJ78RvlWHzIA4gTvW2whI3ILHZu1L7Ad/unobdPyCclJwySIlM
         i+Jg==
X-Gm-Message-State: APjAAAXQZRw2d2hl+nXDMg9fzJGW4unEBPMOYA5eWdJlpGVc0uqRR7DC
        9KJiDqCO/ZDtGSZK6oOHttgMqA==
X-Google-Smtp-Source: APXvYqxeDKmCc4R7qDu9NLMZxvNDLyI1C0C8kWTJH/SP6ir/91jdtAoyr5HCDj0WTBHBHifnG3U8zQ==
X-Received: by 2002:a1c:c1c1:: with SMTP id r184mr19660385wmf.9.1566801381131;
        Sun, 25 Aug 2019 23:36:21 -0700 (PDT)
Received: from [192.168.0.100] (84-33-66-180.dyn.eolo.it. [84.33.66.180])
        by smtp.gmail.com with ESMTPSA id x26sm8363112wmj.42.2019.08.25.23.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 23:36:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v2 3/3] bfq: Add per-device weight
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190821154402.GI2263813@devbig004.ftw2.facebook.com>
Date:   Mon, 26 Aug 2019 08:36:17 +0200
Cc:     Fam Zheng <zhengfeiran@bytedance.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Fam Zheng <fam@euphon.net>,
        duanxiongchun@bytedance.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, zhangjiachen.jc@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2F0BE1E-9CAA-4FBD-80D8-C18ECCE3FD4B@linaro.org>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
 <20190805063807.9494-4-zhengfeiran@bytedance.com>
 <20190821154402.GI2263813@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
do you think this series could now be queued for 5.4?

Thanks,
Paolo

> Il giorno 21 ago 2019, alle ore 17:44, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> On Mon, Aug 05, 2019 at 02:38:07PM +0800, Fam Zheng wrote:
>> Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
>=20
> Looks good to me.
>=20
> Acked-by: Tejun Heo <tj@kernel.org>
>=20
> Thanks.
>=20
> --=20
> tejun

