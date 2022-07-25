Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74509C43334
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 23:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiGYXXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbiGYXXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 19:23:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E5022298
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 16:23:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso8339975pjr.2
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 16:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y5CMOfPsakNJ2rNZiy50AEclvikybNeFFbedJLqfNnc=;
        b=x1UD2N2A/AbnF6gPNA47MXYG8iu6Us+eaKe0Qvpkd2ArvSKwKvVtimhGXNGytd2paR
         KIlHz+BeTwd/eB3KdD48TX9QMptZDwWRezYiaEk50NRbNMgvPN20ogy296P6dSnVjU88
         kxZH0RG8lpvWJr72CZH9zpKkYlFiD8qZDYLY21pCrD9CqPuq5JB0Uy/iy4BLKoDXWadW
         jnPzt7Anc2nmN2L14o0zPNsRj4KD+l1dPmfd4CxEopRuQ+/jjgRXbnoeuFU9IpqtVCPK
         UaCyDDPUjvh2NDa3PxBFC1cKn1wHmA5OK8WSy/Of8jGEUYRXAdufyeTsdRthOeYO47Ds
         Icjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y5CMOfPsakNJ2rNZiy50AEclvikybNeFFbedJLqfNnc=;
        b=pSEAPfui8YlXKgBFVXoqIeEZqt/MzBlL24echJesx1IftWIYoKH8DMSVEL+s6LLTrg
         bvBCfzH6C0LDKF7S2OzQ1BDHICBy9EQGO3yXUxd3L64+UCqbWg+8jo/reogYiKMZmf+a
         oqawjrYWoXmwDvKMxre+vG3S4GcZnKg4yHHW1dH23CR9Xwxr5TjGhtlZf4hAfGguYflr
         6RwNi88vyV4fl/40quO3GwuKQAPdi3FXDjZ6hCXvqeXWm0GJqoc4lC7sFoGaTMwuRvnb
         Yxk3t/ktGm4gi3QC0loS7Aegys+H/BZejrrCnO7tKt3sh+kh4KOCZiqCh5A/BtZiswuC
         ikWA==
X-Gm-Message-State: AJIora+KtgDEiVb0gUbuMT5JswTspmBk9+jYCwo5sb/ItBXaPzLX17wl
        Bg0pZLGal8MOqLsLxxT+htmLkw==
X-Google-Smtp-Source: AGRyM1vQ+sY/UH2MM/8KvWnUdYje11w8dD1jqj0apJMZMqH8IfoVF9oUG5tGXI95hjXyA9DN/oIIIg==
X-Received: by 2002:a17:902:6902:b0:16d:810c:1381 with SMTP id j2-20020a170902690200b0016d810c1381mr5132357plk.162.1658791412836;
        Mon, 25 Jul 2022 16:23:32 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78ec5000000b0051b32c2a5a7sm10183937pfr.138.2022.07.25.16.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 16:23:32 -0700 (PDT)
Message-ID: <05e6e50e-073b-3017-7630-33b7571d07c2@kernel.dk>
Date:   Mon, 25 Jul 2022 17:23:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] remove the sx8 block driver
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20220721064102.1715460-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220721064102.1715460-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/22 12:41 AM, Christoph Hellwig wrote:
> This driver is for fairly obscure hardware, and has only seen random
> drive-by changes after the maintainer stopped working on it in 2015
> (about a year and a half after it was introduced).  It has some
> "interesting" block layer interactions, so let's just drop it unless
> anyone complains.

2015? I think you mean 2005, or earlier.

I'm fine with killing it, I don't think it was ever widely adopted or
used, even when it got merged.

-- 
Jens Axboe

