Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7799C54E76
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 21:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbjADVs6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbjADVsU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 16:48:20 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C41144F;
        Wed,  4 Jan 2023 13:48:19 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d3so37303146plr.10;
        Wed, 04 Jan 2023 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrCi/Pft2qxPLFB1xPtkzEGdXf77jJ8rZEUSTd/viPw=;
        b=DmTDoakfnRqv676B+kjCUKyufhaCbCkmNiys62I7CNdzzMY12YgPxOgMSxKsZrUb1A
         qxmcP8kEWRZdvKxNFoz8BoN5oUdu2Ig90TdQjOzgwapkQa+rMk3Jte/oYHZX4UdDZYft
         rfD9/heLa+bmWdwiadsCSV5JtE2WuHKIkZqelGQuQ0dbVOltGdg/CEEnaj3BJ6GuDIKK
         V7mkaqGzPse11DjNHB1+ReyY6d+dCgriktFfRkxfc7L77V1L1YhC0jEfTMjsJe6frz8N
         m3jD7+/1umkw8ZeaaitWMt0JuA+ODfgSqbj826YcKjId/ByyFSa1Dv3XnZOJIOSG+6DV
         8S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrCi/Pft2qxPLFB1xPtkzEGdXf77jJ8rZEUSTd/viPw=;
        b=K0Dp5hDvLk/imbUvGTnahtE5LTAHwOIQx4mNWKICECnHDwc6FWz2Pk8MqXFyOOmLeh
         /t9at7rIrWdzHIHFy2592XUUjjmU11/y1nCbwDSMYw+M7urYZyBfEJfVCNJbz283QHhk
         53+OJ2c4KYuSx1RnikyuLLrf7Vl2H00c3qLN88uLU0WCmcr5t+p23DiTPJguJrYsMf4U
         nD4PsCC3nBW0jAT6ePk7Jhd19Zz0UT+Q9wmCh8EeTU9CHSvnjan8uSnzjnhPQ1gBeivd
         2io1b2Tq84TrW3lZ3iMHumG+auTEWd5wb2W0J8Q9yUhfHCfbqJ85vitDSf3hldt98quR
         Wdog==
X-Gm-Message-State: AFqh2krV8RGIm37Z973QNp5BHMkC+mdNlFu/AGcI2rH5LbUMG7ixuT0x
        256RvRNTF89x8QLEQ6wcaPg=
X-Google-Smtp-Source: AMrXdXt80CrJ6uDKFsd2FIA5EFUOEPvU80dMI5tjGMtqLaLJPHzX553RwVQ4HzmPORoiqISL811fqQ==
X-Received: by 2002:a17:902:eb8b:b0:192:fb94:a40e with SMTP id q11-20020a170902eb8b00b00192fb94a40emr880445plg.62.1672868898812;
        Wed, 04 Jan 2023 13:48:18 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902680900b0018b025d9a40sm3856374plk.256.2023.01.04.13.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:48:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 11:48:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v3 1/5] blk-iocost: check return value of match_u64()
Message-ID: <Y7X0IT27kPap4tFi@slm.duckdns.org>
References: <20221226085859.2701195-1-yukuai1@huaweicloud.com>
 <20221226085859.2701195-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226085859.2701195-2-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 26, 2022 at 04:58:55PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This patch fixs that the return value of match_u64() from ioc_qos_write()
> is not checked,
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
