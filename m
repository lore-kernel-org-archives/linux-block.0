Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E203EB64DD
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 02:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjHDCBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Aug 2023 22:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHDCBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Aug 2023 22:01:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BF10EA
        for <linux-block@vger.kernel.org>; Thu,  3 Aug 2023 19:01:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2684e225a6cso272027a91.1
        for <linux-block@vger.kernel.org>; Thu, 03 Aug 2023 19:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691114471; x=1691719271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRe8CI7xK9YdHSQPDOmK1mO6LPdqNHzGTyyI9WtFcQs=;
        b=cZTYvPmmKjZ6yPE7K9dSTJyWSDjeQfjGSRPCZRCVPH8iHnHlKkMPVIa4Pftfv9LbUf
         y8in3Dfic+IDakjT5z3xU9+FJ36tsZ0BQcT/PoFKMJaxt3i76TZ8b5+SEGVc+BoWCeAh
         V7P4ZzeXN8MKdqg8xQwB1QbaoslUhBTRSJCjcD+ZwIgPGC/9ILCXYqsQWC9YYn6BVDRK
         cJulIg9T0FCEEcoW1FTYTllYx2gJYXxYOvbqbJv7iTbbYeOoyZnolW/gzB6EXRSEXDhO
         ef1sHvOFNBp2mhB2i4p1x6e2UK+MKc4wCsRxgMYPUSmXfbfyLxSnU+A8YZc5SCC1uri7
         kykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691114471; x=1691719271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRe8CI7xK9YdHSQPDOmK1mO6LPdqNHzGTyyI9WtFcQs=;
        b=UdotXsbZ7bFqUKGGoiXSxWGfYR2DMOP9Z6ZIr9AzuguS9Gdip53kUCT6eA6DmUk2ez
         AIY5TGyO6BU6PUURLCXNDEF8QUZXq4XSofMcxEn3s6wJeyfDwtNX5haAk8A/tF7V3m2+
         YXOIYTfqFcOtWzOrttcb3q2k1RnIY6A1HIjC256xYv5j4gWxxcQQJB3IOrFw0mBny9iy
         Hoc0KT4Nyih8Ikh1mfENcxL6sIGyBR+QRhgM8IxGgugDf0Iqfd8f81sk947Hdrdl6BM7
         wx4ZXF/lFfaHSp5IN78mz0kptRLiQyoKL0zyZs61OqiDx+s0nFkxSQcjODALwn1RVUEO
         X4RA==
X-Gm-Message-State: ABy/qLbQO0bcArMxHBFQJLQ3FoIzrI/cAZomCbH/zTpN/VeTFz43XYK5
        93tu5BQzj+7q5nmLE9yY4jY6xA==
X-Google-Smtp-Source: APBJJlEE6jmPJaIgUGvwa3nc9Ve34em9166qso/8niv4JtARWIb0Bra8YqYex0R0gszappbuUQssIw==
X-Received: by 2002:a17:90a:53a3:b0:268:437:7bd9 with SMTP id y32-20020a17090a53a300b0026804377bd9mr15893961pjh.3.1691114471116;
        Thu, 03 Aug 2023 19:01:11 -0700 (PDT)
Received: from [172.20.1.218] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b001a6d4ea7301sm483963plb.251.2023.08.03.19.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 19:01:10 -0700 (PDT)
Message-ID: <5c85d3ee-26f8-9f34-a462-ebdbaee3b900@kernel.dk>
Date:   Thu, 3 Aug 2023 20:01:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH -next] fs/Kconfig: Fix compile error for romfs
To:     Li Zetao <lizetao1@huawei.com>, mcgrof@kernel.org,
        johannes.thumshirn@wdc.com
Cc:     hch@lst.de,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230803130738.999853-1-lizetao1@huawei.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230803130738.999853-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/23 7:07?AM, Li Zetao wrote:
> There are some compile errors reported by kernel test robot:
> 
> arm-linux-gnueabi-ld: fs/romfs/storage.o: in function `romfs_dev_read':
> storage.c:(.text+0x64): undefined reference to `__brelse'
> arm-linux-gnueabi-ld: storage.c:(.text+0x9c): undefined reference to `__bread_gfp'
> arm-linux-gnueabi-ld: fs/romfs/storage.o: in function `romfs_dev_strnlen':
> storage.c:(.text+0x128): undefined reference to `__brelse'
> arm-linux-gnueabi-ld: storage.c:(.text+0x16c): undefined reference to `__bread_gfp'
> arm-linux-gnueabi-ld: fs/romfs/storage.o: in function `romfs_dev_strcmp':
> storage.c:(.text+0x22c): undefined reference to `__bread_gfp'
> arm-linux-gnueabi-ld: storage.c:(.text+0x27c): undefined reference to `__brelse'
> arm-linux-gnueabi-ld: storage.c:(.text+0x2a8): undefined reference to `__bread_gfp'
> arm-linux-gnueabi-ld: storage.c:(.text+0x2bc): undefined reference to `__brelse'
> arm-linux-gnueabi-ld: storage.c:(.text+0x2d4): undefined reference to `__brelse'
> arm-linux-gnueabi-ld: storage.c:(.text+0x2f4): undefined reference to `__brelse'
> arm-linux-gnueabi-ld: storage.c:(.text+0x304): undefined reference to `__brelse'
> 
> The reason for the problem is that the commit
> "925c86a19bac" ("fs: add CONFIG_BUFFER_HEAD") has added a new config
> "CONFIG_BUFFER_HEAD" that controls building the buffer_head code, and
> romfs needs to use the buffer_head API, but no corresponding config has
> beed added. Select the config "CONFIG_BUFFER_HEAD" in romfs Kconfig to
> resolve the problem.

Patch looks good to me, for some reason not CC'ed to any lists though.
Adding linux-block now and getting it applied.

-- 
Jens Axboe

