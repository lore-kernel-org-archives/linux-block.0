Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF684C4332F
	for <linux-block@archiver.kernel.org>; Thu, 15 Dec 2022 16:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLOQyc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiLOQyS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2022 11:54:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E6C396D2;
        Thu, 15 Dec 2022 08:54:16 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 17so7544264pll.0;
        Thu, 15 Dec 2022 08:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZn+QJIG+pG2FMov/YvviioMJllEnj55mv0rTOwAEiE=;
        b=OgTU8ACnECzBXNTgrFTQtc97eoPsgGmtug2GqlsFNG4KyynZ9Cli72P8mSBQTLM9v3
         NE/VPRuXPU6mIMOm55/f2MBv9wc+fPQO3qNGoDvKdKAcvBFZAhv7tqlGKNHRjSCBBTKn
         Iefa/DsMDX8M5Jk2C+Del/o2N7aUjC3JWPHkEhjwhgMPogeZCWsG149Hd027dH3P7vWa
         FZrmWzLeI/wJO4E9nyL2LebGYy5Z3PPMESE93tC1hY/bAaWrP8P2iFijLfWQcRSb0FtQ
         Sz/Cex8iHrLmLA2WtV99BUV2Bue1+ZUvI667HeSWVpOAithkUB2YPgRqplIrambaeZ0L
         EcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZn+QJIG+pG2FMov/YvviioMJllEnj55mv0rTOwAEiE=;
        b=hafUjmB7YEWVT1aOc6vjgbmjXdj3e5YSrw5a/RqDwH4teSxAkNsNSAoNrkYi4xz0lD
         NoDMRvj3gSuYPYBbmOxvdX11vd9iLuEI11WbVl9FgZi2fdSq9QLN4q4rUtJDeW096Qy1
         AAQwlOvsO0PWhi2y3eVo4SL6/5AzHBoxYG47iCoqKDpadZYJy23Xk1u2sOsmNf6bwzXF
         uKk3ssNHCZx7swE6omMn5P24ea2yruGnlGFrh8PYbFRYkPS6tTeSyNuRHjioFucNaMt/
         b9Hf3I4Y4Zdk/awnUD6WL5FfakFZZzdWh2AO4pk7D0PhM2KVjKKJUJDREKN8a86N66Tg
         ISRA==
X-Gm-Message-State: ANoB5pkv89+OyjKVTxkZUqX6h6JfLPDBYEuYOyoOSu/SnB8vmQAciKac
        c4N68ZpY2xwGi9hyaOdvDg93EYse87So7g==
X-Google-Smtp-Source: AA0mqf6Lira6AyIybIY5JV+PGyuPz2Fvz9rbaC93AU4F9Y516G7igpd4UAuTGy88rKoYXsP43xPbrQ==
X-Received: by 2002:a05:6a20:d68b:b0:9d:efbf:6604 with SMTP id it11-20020a056a20d68b00b0009defbf6604mr35689526pzb.18.1671123256345;
        Thu, 15 Dec 2022 08:54:16 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b00562677968aesm1972328pfg.72.2022.12.15.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:54:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 15 Dec 2022 06:54:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH 3/3] lib/percpu-refcount: drain ->release() in
 perpcu_ref_exit()
Message-ID: <Y5tRNoL5lbwy91Xs@slm.duckdns.org>
References: <20221214025101.1268437-1-ming.lei@redhat.com>
 <20221214025101.1268437-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214025101.1268437-4-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 14, 2022 at 10:51:01AM +0800, Ming Lei wrote:
> The pattern of wait_event(percpu_ref_is_zero()) has been used in several
> kernel components, and this way actually has the following risk:

I'd much rather see those components updated to wait for notification from
->release rather than doing this or update percpu_ref_is_zero() to wait for
->release() to finish.

Thanks.

-- 
tejun
