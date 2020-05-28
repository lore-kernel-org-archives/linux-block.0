Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D3C433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 06:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39EA2073B
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 06:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="AvzTFCIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE1G2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE1G2g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 02:28:36 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48179C05BD1E
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 23:28:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s19so22196746edt.12
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5MkFrDgF5VspAmYHCjE3L+lmTwqFXhsdmwItUzmmYmQ=;
        b=AvzTFCIHVx3qfAhRrsnAgFy2dWlhXhf4W3nNrKWTSpdP/0vWamueZnjT+6Qs8JAro3
         5rjN8JXoaG2c4HdCxOcNy99MI2yU/5vz6+7j+ClH+CytbQYkhcPSeCHTkZI4spzSxCBJ
         juz7Wh3eEzYXfttxG4mP3rNmCJwrNae088M3lSqsJeV7jlbM/q+hsoPw6+rYpyyc/mjJ
         CcZKDi//5Xi7MHxG3GKhC+ywBJQTD1NFoA3h5VyuvCpKSriDvVQ3j6y+ncf8aZJzPq/O
         2tv1dd9+pgN8blm5WB6UwrsZ9dYHkDSJf5TJl2bph0yxJKyybUKP9grgfWjJEwX7zc9z
         0FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5MkFrDgF5VspAmYHCjE3L+lmTwqFXhsdmwItUzmmYmQ=;
        b=k3tSMgzmbhPGYxyAVzpxyjCr6Fknog3qdRrjtjYDLsu31etAXQ/iudnsRweCddq5PD
         IiXiSxNuCiDS0Of9enttpadv9NzRGjyDWrPnuh8VI193TcnIK12+MKUYU8h8nqiupdzU
         pQGz9CnvAnrqj7uDcMcU+i5AxvM5dhzRsTLD6lyPo+DtUGNSy3Hbha1RDTcx45vkCbKf
         k8Vv/3jxSiN1vfa//hlSqD+fugb41sPa3K0smbxEFvBfjQBHgAlyaYLzVxX0zrEtysXY
         O5stuyBNUeHDRCwQXjJdKk63C0olAqdOT7QBf3uMejfJWY7nQmgoidihodVi9P1ksvzs
         bv5Q==
X-Gm-Message-State: AOAM533EXoP4fSUJLOwZ1TvCCri0XsFyyrHe4NoqQSO5hcf6Qzau3GyX
        GQN8eezQg4OZL+sHZNrHn33bmg==
X-Google-Smtp-Source: ABdhPJyc8HLOjeL5rh9/6pD/emZOr32Ehyiz+rzW7XmdKPV7S2MgDdVX043h26V6pipPZ4iBM1fI5A==
X-Received: by 2002:a50:ace4:: with SMTP id x91mr1503734edc.361.1590647314911;
        Wed, 27 May 2020 23:28:34 -0700 (PDT)
Received: from localhost (ip-5-186-121-52.cgn.fibianet.dk. [5.186.121.52])
        by smtp.gmail.com with ESMTPSA id b21sm3999199edt.15.2020.05.27.23.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:28:33 -0700 (PDT)
Date:   Thu, 28 May 2020 08:28:33 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Matias Bjorling <mb@lightnvm.io>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias@cnexlabs.com>,
        Jens Axboe <axboe@fb.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lightnvm: pblk: Fix reference count leak in
 pblk_sysfs_init.
Message-ID: <20200528062833.clbghpoqizjvl7g4@mpHalley.localdomain>
References: <20200527210628.9477-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200527210628.9477-1-wu000273@umn.edu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27.05.2020 16:06, wu000273@umn.edu wrote:
>From: Qiushi Wu <wu000273@umn.edu>
>
>kobject_init_and_add() takes reference even when it fails.
>Thus, when kobject_init_and_add() returns an error,
>kobject_put() must be called to properly clean up the kobject.
>
>Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
>Signed-off-by: Qiushi Wu <wu000273@umn.edu>
>---
> drivers/lightnvm/pblk-sysfs.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
>index 6387302b03f2..90f1433b19a2 100644
>--- a/drivers/lightnvm/pblk-sysfs.c
>+++ b/drivers/lightnvm/pblk-sysfs.c
>@@ -711,6 +711,7 @@ int pblk_sysfs_init(struct gendisk *tdisk)
> 					"%s", "pblk");
> 	if (ret) {
> 		pblk_err(pblk, "could not register\n");
>+		kobject_put(&pblk->kobj);
> 		return ret;
> 	}
>
>-- 
>2.17.1
>

Looks good to me.

Reviewed-by: Javier González <javier@javigon.com>
