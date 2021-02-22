Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD5DC433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 07:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555EE64EC3
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 07:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBVHgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 02:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBVHgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 02:36:08 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A35C061786
        for <linux-block@vger.kernel.org>; Sun, 21 Feb 2021 23:35:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q10so20546831edt.7
        for <linux-block@vger.kernel.org>; Sun, 21 Feb 2021 23:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Iji0WeR6vKM0Z3iG2537zAB1TJYq/UVFyP+dbtL51mM=;
        b=gdM+aXHSKTgLU0VG/7m4Z9ee0ftRGE+Fcpc+3RgwVP+bydhQsEquyBLpCYaM/8nvkQ
         crCLEEdZ2vWAK43tmtv1gAGOdHly3FDlOHtcLhScMlHT1OCauRfrrsRm/BcrjiCc9Det
         fIplMLMa3fuv7rHpfrJaygVvqXF3kAmaQjZgCHsmomRlel8DmeXvK+yjSEm+yBJA+JYa
         95x5y9f3gxiU+WUMuduwhNqD5AW45XiB2ogz+Dt1FcSb18177yJXIW7xVsKWnDk92IBA
         g61jpVQ7xU+GSHZRukzzxQtfhTQYCtlZWYPou/cVbIOrY8jBRJWp/Iw5o9Mmbl5VKWXG
         lCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Iji0WeR6vKM0Z3iG2537zAB1TJYq/UVFyP+dbtL51mM=;
        b=T131omLQPs3zM7Me3E9OSGx4h0Mq3v/NH51OswWDQce3v0KJbIwMeSRpQzKU4o5LdA
         aqEy55cg+RRAMh2ypUz4yvUChbX/PTbCfJB0e34K5myhSM/RP/OUp3WMQ69V1P69bXrr
         epUJ3KiLM7pF3Q81/npjnEbwW4RnDVF5c9+locpscOPXTqoA/xRuKUzLIXmxZD4W/hbO
         2cDJoz8MQO/kcMLQxy1+Xi5AOhdzD91t5z41r5f1jcpUc5MaSHkJAKvX6lpZxNjayNbR
         KN07PJePDGd2eGvFA2UvDUwvJcf3W//M8PvhYbeQyNWcVROjMUwf24ynV1Toi0el/nyz
         mAag==
X-Gm-Message-State: AOAM5334i68gPNk8jmTpTOzBQw8Fl88zQ8N2NNGyuaUpsUMF5002sMCV
        8Bgqe0Vh3pGNzKXLsVJrNahyxQ==
X-Google-Smtp-Source: ABdhPJxpyr7tn4lZ8nte4KPNPbXnvhS7eTEHIlc4MDPkNXkz3gfaudtSV7GKlAUlG3dMs2tOMcuMaA==
X-Received: by 2002:aa7:c54b:: with SMTP id s11mr5247917edr.82.1613979327131;
        Sun, 21 Feb 2021 23:35:27 -0800 (PST)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id bo12sm9708094ejb.93.2021.02.21.23.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 23:35:26 -0800 (PST)
Subject: Re: [PATCH] lightnvm: use kobj_to_dev()
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.indradead.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210222060650.45373-1-chaitanya.kulkarni@wdc.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1bae7eca-c41a-28ed-f575-e9891b4ce45d@lightnvm.io>
Date:   Mon, 22 Feb 2021 08:35:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222060650.45373-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/02/2021 07.06, Chaitanya Kulkarni wrote:
> This fixs coccicheck warning:-
>
> drivers/nvme//host/lightnvm.c:1243:60-61: WARNING opportunity for
> kobj_to_dev()
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/host/lightnvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index b705988629f2..e3240d189093 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -1240,7 +1240,7 @@ static struct attribute *nvm_dev_attrs[] = {
>   static umode_t nvm_dev_attrs_visible(struct kobject *kobj,
>   				     struct attribute *attr, int index)
>   {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>   	struct gendisk *disk = dev_to_disk(dev);
>   	struct nvme_ns *ns = disk->private_data;
>   	struct nvm_dev *ndev = ns->ndev;

Thanks, Chaitanya. I'll pull it in.

