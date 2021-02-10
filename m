Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC57C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 11:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2F364D99
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 11:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBJLPj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBJLOC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 06:14:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72FDC06178B
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 03:13:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h12so2014258wrw.6
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 03:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ylXnAL5nrH5hqi9xQ5ruoY6NoTAGtDS//0pow3R9ejA=;
        b=cOaVoTLjKniO1+RCwXhpMGs84QivJKe+H6b5qbRUsbbX2ZvlfKzH0m0ML7u2JjRcYR
         ZHrnJ1esZKsOovCoHlv1tghQ0ZsHX4VZ+iuiLoBXuBUb6hghtq0VTJKn98ZIssC3bWI7
         PM2DBOmL30Jk18AQ5Dh774BnWXBKrnInWULmYdscr9XsxPeXGfh1tUOF2GampKCHk6vj
         CCwmNu4X25uhE8POOnS9c9LAepl+aPE+Of0qTBN2ZjXoDU/Zniv6JbnLdfTrNtN6J7NQ
         JqAD/uuvhnwAWpMPqk0ipYAVOgkJnHgWuEFp2OMKJ1YuGwB6fndynO28dRJ/eUGGmxye
         z7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ylXnAL5nrH5hqi9xQ5ruoY6NoTAGtDS//0pow3R9ejA=;
        b=aQIor8i60d24mC0TJexqRlwwRC6p7K2c0HQ5c/1vXhgIzMus7LYtH/FyKF71H9DZIw
         sssjx+e+e9O6dQO1HEkTyo7/Xr6FGcWPmkaov4zMmYW8NkbwkygU+BtnGnyDGXOnRdUE
         UOBRgPFkE+ByYmT8xBu+txFNeIp55bEQlneHOEPhNsdEgEvurHankfshf6ecdgQ9/hsA
         LoK6jzUuWdX07jHWiaQbDh74HeNkGXryrmYQb87JIDgrEApJpoXya6D0w8IuImrP2n8m
         2PwSIrwOkMUnPutlFVe5dv3l9bBs3+vOPuyE30FPx6kTPdIr1e/RDeTC28u60XOVH/Iw
         kBgw==
X-Gm-Message-State: AOAM530lvN2i2uJR8J9fMtANZY0jzqC+cqvm+M7N1uKHok/ILPzfE1/t
        q/ZUl8uI81MFgpbdpIUs76+7zau8c1HanQ==
X-Google-Smtp-Source: ABdhPJyVVSnriCmXHzlRk6cnZ/zh6Yhl8PjsKY+iqzqXmo6MMtWlIAbLci0odQfdo7kn5d7h56p2ig==
X-Received: by 2002:adf:92a6:: with SMTP id 35mr3050131wrn.193.1612955600544;
        Wed, 10 Feb 2021 03:13:20 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t6sm1976264wmj.22.2021.02.10.03.13.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 03:13:19 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] bfq: remove some useless logic of
 bfq_update_next_in_service()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1611917485-584-1-git-send-email-brookxu@tencent.com>
Date:   Wed, 10 Feb 2021 12:13:29 +0100
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4751549-78D9-4A84-8FB2-5DAA86ED39C8@linaro.org>
References: <1611917485-584-1-git-send-email-brookxu@tencent.com>
To:     Chunguang Xu <brookxu.cn@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 29 gen 2021, alle ore 11:51, Chunguang Xu =
<brookxu.cn@gmail.com> ha scritto:
>=20
> From: Chunguang Xu <brookxu@tencent.com>
>=20
> The if statement at the end of the function is obviously useless,
> maybe we can delete it.
>=20

Thanks for spotting this mistake.

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
> block/bfq-wf2q.c | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 26776bd..070e34a 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -137,9 +137,6 @@ static bool bfq_update_next_in_service(struct =
bfq_sched_data *sd,
>=20
> 	sd->next_in_service =3D next_in_service;
>=20
> -	if (!next_in_service)
> -		return parent_sched_may_change;
> -
> 	return parent_sched_may_change;
> }
>=20
> --=20
> 1.8.3.1
>=20

