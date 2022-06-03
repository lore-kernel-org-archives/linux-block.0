Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85550C43334
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 05:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiFCFFy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 01:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbiFCFFx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 01:05:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958523917F
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 22:05:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p10so8915311wrg.12
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 22:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=rB7QjtcTTXaD+ufw8NxVJPDiif8BkB+8QdRxXsN07K8=;
        b=lsrBaEYJlnsM8hlfASDACkp8yszE7gpvfbbieUtQ6sqrO5g1FBjxm2tv3uDpMi83HC
         kCtFnI7CL4Mw8Y4FEb5RELC3GZzNN3CphUMQH8Gy3p/w2Pr0zKSsvW0v2SzrQ6FlWI/L
         QcoY2ik9y/qYwMeJJBlazCDOIgJsqRD0+qd4SWSorbCFh2X7km3A+qEAa/HDBCSIVzWo
         grFMqHZg1I0cEEJjDYLf5jYN+XEfeivvnm+IU6zQRNhe8DYrRjoBBrErQiq3FwBl1TC7
         wbDRywU2GGw6cCg9Tj9Vzf+hVJZBWGxiLecKN4mPUQQJHT8FJS3gVo6E1OKgivDZywZd
         Yjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=rB7QjtcTTXaD+ufw8NxVJPDiif8BkB+8QdRxXsN07K8=;
        b=6rx7m/oDX78rZPy2yE6JSff5krCWapGQyQxhvKHmynPPzEMJH0jrYShrDyTrKSRscg
         EhnobaY2vdsbpwYd0B6I8I1YKEmAXSdcmqNQ9GxqEinsUR09L+44p4O3txe9c1p/l4L/
         wVhgppiokJ8NkxdKRG8PD8RqBkmFDF6w1Rp5703RpVSwYn7uV8OFtgeuJ/dIZDFlwTXK
         oX56jGq4y/k+/UbYGeha36J+A05+b1NlLky+/Ain3Kl7LOSJIMytT9Om79zUh6YUksII
         j436SpBQ/GCzMgRcE6BgmIzllx7uj9eOotDxoCJxAwOUQvQxKtaMk2T/COjT54w4a3yk
         0bGg==
X-Gm-Message-State: AOAM5307lPk+jpjM/z1efHlzN+1/+iqj+vPFavUJShayf9blLvXnmeYx
        +jpxGKzxfv54QIm/djADlwSAYCY63ka0gIsj
X-Google-Smtp-Source: ABdhPJyoR4rAoLRJKmBenNNxnq4FwZaDzmjDstF4xMKcJZOZTczCIEusC55SOouGIHIZIHvOlNyG6Q==
X-Received: by 2002:a5d:64e3:0:b0:20f:ed9b:7505 with SMTP id g3-20020a5d64e3000000b0020fed9b7505mr6470787wri.408.1654232750065;
        Thu, 02 Jun 2022 22:05:50 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c3b0300b003942a244f2fsm11960334wms.8.2022.06.02.22.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 22:05:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org
Cc:     muhammad.ahmad@seagate.com, tyler.erickson@seagate.com
In-Reply-To: <20220603021905.1441419-1-damien.lemoal@opensource.wdc.com>
References: <20220603021905.1441419-1-damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] block: Fix potential deadlock in blk_ia_range_sysfs_show()
Message-Id: <165423274909.11858.14158322851335874108.b4-ty@kernel.dk>
Date:   Thu, 02 Jun 2022 23:05:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 3 Jun 2022 11:19:05 +0900, Damien Le Moal wrote:
> When being read, a sysfs attribute is already protected against removal
> with the kobject node active reference counter. As a result, in
> blk_ia_range_sysfs_show(), there is no need to take the queue sysfs
> lock when reading the value of a range attribute. Using the queue sysfs
> lock in this function creates a potential deadlock situation with the
> disk removal, something that a lockdep signals with a splat when the
> device is removed:
> 
> [...]

Applied, thanks!

[1/1] block: Fix potential deadlock in blk_ia_range_sysfs_show()
      commit: 41e46b3c2aa24f755b2ae9ec4ce931ba5f0d8532

Best regards,
-- 
Jens Axboe


