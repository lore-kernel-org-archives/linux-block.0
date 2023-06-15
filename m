Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B40EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 13:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbjFON4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 09:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344789AbjFON4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 09:56:00 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA5D1FC3
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 06:55:38 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b426eb7e81so1801396a34.0
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 06:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686837337; x=1689429337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4U30jEpHQMdQo/ctm8QjpR5L8CIHwce7o4fRrt3t6w=;
        b=AwbwSpCYWSq63DjGFZdKx6zGwuswETijBwplGanaMf2oF4ZL5iHDqUli7bM9sOoIL1
         9f/oSqvFOdz7Tri6aZ9LBZSPFtK1bmHU+mEzXmDb4YoSPs91HzOxcqZSJFsA8mfUXkaz
         FTcO5gKnMwHSPnqhMYXKAEmUcn1tmct7g/pE5eDoqaLFtgrRbj28S3a2/gQ4HZbHMHAR
         A6T/wiQ+QAipjC1rPr14KhW1QZ5i+BTI/Jm7tkjbc30hDzhO5ghSPDyQbWrPEc+ZKaC7
         +aeztZaO371gwvsoSQWNvKSzMlIo4JHZhMPtmNkVwTbAGO302snTFEbnsmZ+m/Uo2uYv
         5DrA==
X-Gm-Message-State: AC+VfDwqXbx3CwPDS8CBRVBFU/WWJHP13mf9v+wLhXZwC+iZelrCWMZD
        gzVGLNqg2qcsIxWg2QlmKzY=
X-Google-Smtp-Source: ACHHUZ5wGZfTDONajWxKH3sNvxJEIsAr4BNl5zW1VwCO5E+gLCb5rrcrEQgPgKvvcw6EOsPVARoDQQ==
X-Received: by 2002:a05:6358:edd:b0:12b:dc3e:34c8 with SMTP id 29-20020a0563580edd00b0012bdc3e34c8mr9098829rwh.4.1686837337219;
        Thu, 15 Jun 2023 06:55:37 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j8-20020a635948000000b0054fb537ca5dsm4896050pgm.92.2023.06.15.06.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 06:55:36 -0700 (PDT)
Message-ID: <1d55e942-5150-de4c-3a02-c3d066f87028@acm.org>
Date:   Thu, 15 Jun 2023 06:55:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
 <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
 <20230615041537.GB4281@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230615041537.GB4281@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/23 21:15, Christoph Hellwig wrote:
> I really hate having this core complexity, but I suspect trying to driver
> hacks would be even worse than that, especially as this goes through
> the SCSI midlayer.  I think the answer is simply that if Google keeps
> buying broken hardware for their products from Samsung they just need
> to stick to a 4k page size instead of moving to a larger one.

Although I do not like it that the Exynos UFS controller does not follow 
the UFS standard, this UFS controller is used much more widely than only 
in devices produced by my employer. See e.g. the output of the following 
grep command:

$ git grep -nH '\.compatible' */*/ufs-exynos.c
drivers/ufs/host/ufs-exynos.c:1739:	{ .compatible = "samsung,exynos7-ufs",
drivers/ufs/host/ufs-exynos.c:1741:	{ .compatible = 
"samsung,exynosautov9-ufs",
drivers/ufs/host/ufs-exynos.c:1743:	{ .compatible = 
"samsung,exynosautov9-ufs-vh",
drivers/ufs/host/ufs-exynos.c:1745:	{ .compatible = "tesla,fsd-ufs",

Thanks,

Bart.
