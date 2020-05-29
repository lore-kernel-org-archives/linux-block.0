Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A45C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 06:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609B32072D
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 06:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="G3Q6Iq9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgE2Gtb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 02:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2Gta (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 02:49:30 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59664C03E969
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 23:49:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k11so973476ejr.9
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 23:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3MdeqVyB7qqljYQy1e+2+zaRWsAJCR017mMr9VXzZ4Y=;
        b=G3Q6Iq9gGZmpk3gidKEg293iTpRBe03usgIvHj/o9dYqlqSG2a2o4i/vuUH7o39HZz
         JbdjNQE1oDQp48dIw7wnU50wo0HT0NKGFSt0TGg/8B5IveZL9DPStnl0r+Xdog7qU9jR
         JDEWI+nf7Yn3KBqZY9jPM26baohAPXo3S9ofUNsFYpzEbHwdN3GymLvNCrYtj0dJWPwq
         BYAJzAhNsORPoyCBEt9U8tnLJRSD5UzHVbY7ts/3vbWk/ae6W1DaCCmOu366sQewdSP+
         erERilRbZYTrjNCWlFek0u/X/9WCByrGA2NVsC8+5UCd4aJF0pMx+dBM4FMLfpFeWcYN
         qZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3MdeqVyB7qqljYQy1e+2+zaRWsAJCR017mMr9VXzZ4Y=;
        b=hJ7LJd23Q9cU1UaVuhywhzLIOEWTnW7WD8iIpnZZA4jMWpjYjNtHFSw9bZmRknbqoq
         DBkr440oAZqLO3WEqv+1Vx2l9lXbEZU2oiIyDmcx+N3DMLFAETqnbnooIVnnl83F0n/h
         Zxj14vOg4N6SX6PDCfPTMQ2sOEvCy/4yIwE6S3h9wdUO5MZhlXmJKrmSc67rQfJO2Jdx
         DH3PIdcrb6r++mLxOxDKcUToC2TulKE8WXuK9FHxJbSPqLz7OAVX0+CVW3OBQ29Hoe4r
         w+T60OIIf/tezGtyy6E35crlLkBqSgeg2HElS2BL8Lrk87QxUUQyT9TP9LMgVhpVnDGV
         jgDw==
X-Gm-Message-State: AOAM532+/6N0VzDgipnESBWXMf6SKsD98Ax/aVot9fXuVavYozWRLN2Q
        frB96+jsCcGG6TI2jDrrbrV5iatkiFk=
X-Google-Smtp-Source: ABdhPJwZLmIufYpWK0ymII3E3TftzSSzUlARdwH313AxcjBpnKCEsE/uvlbDTxzNnEsQNgLkfnPhqQ==
X-Received: by 2002:a17:906:7f84:: with SMTP id f4mr6117632ejr.482.1590734968104;
        Thu, 28 May 2020 23:49:28 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id bd10sm5966118edb.10.2020.05.28.23.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 23:49:27 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: Fix reference count leak in
 pblk_sysfs_init.
To:     wu000273@umn.edu, kjlu@umn.edu
Cc:     Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200527210628.9477-1-wu000273@umn.edu>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c67132e2-e684-74b8-2809-98e80fc944e6@lightnvm.io>
Date:   Fri, 29 May 2020 08:49:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200527210628.9477-1-wu000273@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/05/2020 23.06, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
>
> kobject_init_and_add() takes reference even when it fails.
> Thus, when kobject_init_and_add() returns an error,
> kobject_put() must be called to properly clean up the kobject.
>
> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>   drivers/lightnvm/pblk-sysfs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
> index 6387302b03f2..90f1433b19a2 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -711,6 +711,7 @@ int pblk_sysfs_init(struct gendisk *tdisk)
>   					"%s", "pblk");
>   	if (ret) {
>   		pblk_err(pblk, "could not register\n");
> +		kobject_put(&pblk->kobj);
>   		return ret;
>   	}
>   

Thanks, Quishi.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>

Jens, would you kindly pick up the patch?

Thank you, Matias

