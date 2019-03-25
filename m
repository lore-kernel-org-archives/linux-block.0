Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18362C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D734C207DD
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="VNzJ0KIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfCYLNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:13:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36961 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfCYLNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:13:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id v21so7149190edq.4
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUvUvZ9MohxaphU9AAI2vJjXo6Sp+2imnIn4wA3zSnw=;
        b=VNzJ0KIBva7F86IXJ6nBCXESy2O84ZSEitF0MUd/ayLBlGZ8TDXvVXRqFlOruSaXcx
         ctn/XpZxxtbKe3qsm0UOQhavSQti8LEaQUd2kXO24MtqD5reK9j29+9FO5FPm+pl4y8E
         QQM7gpwDbuLjDvjvUtzMzOv3+vXL++9EkjpC7tewQO6/K/Wb6agRLdIpS69cQjo0mMgO
         EaQT/UXJpOi6RvQkC5OJetcoMLAA0zrVHeqKXNBvrMFp10MU5tx3UK53Bk9MeruXHX+P
         lbxP2dN6Il1xgbRqRI8bm4D0oAeOZkmn2dfnXf1gtdOMBN6FzQ8IUc9fH2xG/UBGuWCo
         349Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUvUvZ9MohxaphU9AAI2vJjXo6Sp+2imnIn4wA3zSnw=;
        b=ko0WIUdRdBVJaOClMOdvkJEUQvT8kcoXlcPoqMKPgGxA/sGqJj+07c8Dhc6K6V6ovS
         Q5cYMWZNJQavQft/35QNyNc+QcpAVFEjeihLRpBO49RONWwqCmGDEPfK9/MLYK9uAMUG
         RvbOLQHKwOWMPc7EX8+P04t3/7jTmCzPTgD29fiIHvUo2XPPwh82XIvvr/ZTqh1hUV7j
         jXuE2zloFpKpIHoqWRVFWNfBM56PMD06i8bCLe5hfqasucMmdgNDpd6LRMipBuIH+IsY
         nI0kVdPm2rX0A7Kuf4PbaBykCLf3BJmbLp5shBx5Pa9eqUm2r9KYViJbIvaLgBEbzti4
         0QJA==
X-Gm-Message-State: APjAAAVVzpeTY6AE/QOupntC+R9DimpSXokUQCegauNhSsLkMzCbTi7V
        lYqexbHrqCcL9unpEvHjHGC+EJ+n4RE=
X-Google-Smtp-Source: APXvYqzFXFHitHSpvmHNXQZe6hJrdaG+ZAIXhoF6J+aVyXQ47bkTsnw9qFOMszgGgJ+ljNj0YwdvRg==
X-Received: by 2002:a17:906:5946:: with SMTP id g6mr13981910ejr.58.1553512401631;
        Mon, 25 Mar 2019 04:13:21 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id p12sm3448574ejr.58.2019.03.25.04.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:13:21 -0700 (PDT)
Subject: Re: [PATCH v2 10/16] lightnvm: pblk: kick writer on write recovery
 path
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-11-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <21671414-5c88-4cdc-ee28-c5d46acb5b28@lightnvm.io>
Date:   Mon, 25 Mar 2019 12:13:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190322144843.9602-11-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 3:48 PM, Igor Konopko wrote:
> In case of write recovery path, there is a chance that writer thread
> is not active, so for sanity it would be good to always kick it.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Reviewed-by: Javier González <javier@javigon.com>
> Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-write.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 6593dea..4e63f9b 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -228,6 +228,7 @@ static void pblk_submit_rec(struct work_struct *work)
>   	mempool_free(recovery, &pblk->rec_pool);
>   
>   	atomic_dec(&pblk->inflight_io);
> +	pblk_write_kick(pblk);
>   }
>   
>   
> 

Thanks Igor. I've updated the description a bit.

"In case of write recovery path, there is a chance that writer thread
is not active, kick immediately instead of waiting for timer."
