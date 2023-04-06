Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107A4C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjDFVW7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbjDFVWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:22:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ADFAD11
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:22:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o11so38662439ple.1
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680816170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9gv1oNOyaG5XA76eU8Cmc0pYEAxkBXhzY0QMS3Qs5g=;
        b=Z8udLpJNI+jaU32kxqcG89f12RsElX2AlNx8tyh0AjDT7cHY2A2/KF4Jw+o1ubYbIf
         vsnAwu56E1eLe0FbXURDuKdZQP9xxi4UJRnAYGEdmGYjqf8flb9foW/pX1/VZigI9G9R
         KnBKVVOuVP+LEDjCsowA0m13ZAsMpfx1zrNUcsEnc7c3R3LYM/k9Igh5SiwtVFjGfoEy
         uP1a7aFc9l3MJGwIe1//LnCfgZWLn11gi3YwIx2FNHkon9Se7iFRuILF8o7JR65BJPHi
         M3g3J8/WVWYUaJ+irV+vAPpTb/hZ1deztKzuEZOXYGHvcgLtMc7tBDA7yI/bdhEPuAMC
         /TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9gv1oNOyaG5XA76eU8Cmc0pYEAxkBXhzY0QMS3Qs5g=;
        b=WQnVjAYVK1lB7+sMknzLw6F4aD/Th8PQiHWIN0Sxg6qit2TpbbMEtV5FPF2UxWmqFa
         rN+bQC0+AScIKnSvfZTSfvv7CSRYRAqvU4QCgRT/+Njo1Ye84xA+kEJnD9KHHh7M7ZRX
         zmxUNRblE02jY90SB7ZP1gCTQsEtLIAv/zSnRwPGrRMkeQ683gDWdctq1684k+iuB1P7
         fQZG3kAjNVbfPq0szMvF+POLy8ZYdiYlZqKcv2rOdY1BfF23SnBhqtWAm6ML/PEFnYBz
         UrhMzf/JDsNsNd9IMaGpUNxuM58+exatphz0cwaBOyQ/3FqOcY2nl3KjzZGsMW7dTomn
         fXrg==
X-Gm-Message-State: AAQBX9cD/IIKe9xxR563l7+JjABiOcp8MsTZm9d6cXtDjL0VihzmCNhm
        9TvVMP9h5ZnBlrKSR9o8q6s=
X-Google-Smtp-Source: AKy350a8p1ZESG/mt5xSxdumEFTlwjl9R4gxhH/TZPyqRXVtCED7u6QL6/WvXyls3PVxQUWERsglCA==
X-Received: by 2002:a17:90b:20a:b0:236:a3c2:168a with SMTP id fy10-20020a17090b020a00b00236a3c2168amr13057627pjb.33.1680816169714;
        Thu, 06 Apr 2023 14:22:49 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id bk17-20020a17090b081100b0023d386e4806sm1548341pjb.57.2023.04.06.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:22:49 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:22:47 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 12/16] zram: refactor zram_bdev_write
Message-ID: <ZC84J5Pze9glr1Mx@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-13-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:58PM +0200, Christoph Hellwig wrote:
> Split the read/modify/write case into a separate helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Minchan Kim <minchan@kernel.org>
