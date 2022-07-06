Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD314C43334
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiGFOwU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 10:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiGFOwT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 10:52:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2117248D2
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 07:52:18 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id m13so14264079ioj.0
        for <linux-block@vger.kernel.org>; Wed, 06 Jul 2022 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=SEbukFa2QWMZwSoMSlefwgQKjSOZaTUazMJWi+s+igA=;
        b=pAf+xM5lgL2ndW9+1ejwh63vphlj180H+CefqWkBSgx/OzfqyL3669HXdAvewwmEVd
         uC/7YZbnfdt4tuiA26DC0+vRoWrIXKMIkZ3WLmLbc9AluQmSmWvwh4A59XMYyYn82ZFb
         UL6hc7NMPzxzQ2NYhN7NhxbDpOajN0vonPbwClYUqOsD+wnjWLOZnbj9YhTdgRrCtIWE
         HGOKg7ZvadI3ACXyLfvzJ2CdDFXjjxZ+06dgZOk8KCnSPF/qwPZhIGfCbf+qp9BlPlBN
         3XHgpAA0T0jeLsKRnEHJYqsRFztayVDVcwHtZoq3OhDV17mRYqIisaH9GJCQr1sBDytw
         mk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=SEbukFa2QWMZwSoMSlefwgQKjSOZaTUazMJWi+s+igA=;
        b=vge/6dheTh2qhz87MsM/B0DDY2dI2gkgJN32Ccezag/+FlBOZevz69tI7faBxZcy8J
         +N+q4BhL9288JcgQ6u6s3ex94rITsBwpqmKUqeA/5LLmbBLB/Qt6daVhnfA5y9NvncNk
         TGrA40vqz3XjFARPN5qwxsdIMFuPMNTVtEDUZuIAcLbdbpy8+2lC0DZTEfwkhtAWHBga
         nX/G2jFk/XTHalf8HlozgArNPUo+yAwcAkNztO495UompXdgvplcSY8lVcAx5TPweYT4
         Co2cO4W9YkEfGYkqGgKSQphho1vrLschI/CzRLqBkgjEZPLEFj9f7IiOg4eoEcg/SX2u
         TOKQ==
X-Gm-Message-State: AJIora++MsGGIy7//4Yziu5hGY4QmGe+XFXyMw3KSRN6EVWC6pc/A2gf
        pfzIs+2bYv+lrEz3n8/jCMz82Q==
X-Google-Smtp-Source: AGRyM1sWQ3V1NB2XI9W4fM2OSegslhVPHlX+Tmr7Dw8+XrvB6v2eHLsSg4gco8OdLZUw5VGxBVGVkw==
X-Received: by 2002:a05:6602:2c0c:b0:669:c1a9:245c with SMTP id w12-20020a0566022c0c00b00669c1a9245cmr22291594iov.218.1657119138102;
        Wed, 06 Jul 2022 07:52:18 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x18-20020a056e020f1200b002dc3a66b4b7sm272289ilj.33.2022.07.06.07.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:52:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     guoqing.jiang@linux.dev
Cc:     jinpu.wang@ionos.com, haris.iqbal@ionos.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220706133152.12058-1-guoqing.jiang@linux.dev>
References: <20220706133152.12058-1-guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2 0/8] reduce the size of rnbd_clt_dev
Message-Id: <165711913730.329256.8144446315536322784.b4-ty@kernel.dk>
Date:   Wed, 06 Jul 2022 08:52:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 6 Jul 2022 21:31:44 +0800, Guoqing Jiang wrote:
> Could you apply the series for rnbd?  Jinpu has acked all the patches.
> 
> Thanks,
> Guoqing
> 
> Changes since V1:
> 1. add more Acked-by tags from Jinpu, thanks!
> 
> [...]

Applied, thanks!

[1/8] rnbd-clt: open code send_msg_open in rnbd_clt_map_device
      commit: 43a20e93310ec218550dcdda0ae79dcd91dbd880
[2/8] rnbd-clt: don't free rsp in msg_open_conf for map scenario
      commit: 953d0c1b1d29c75221ae2d14a0f937f2e0f90592
[3/8] rnbd-clt: kill read_only from struct rnbd_clt_dev
      commit: e8d5be284d3089aa5c3d957e53f71d2eca72b574
[4/8] rnbd-clt: reduce the size of struct rnbd_clt_dev
      commit: 7e6c34c6ca2282ea1a9c3a2d06db3e3578f272dd
[5/8] rnbd-clt: adjust the layout of struct rnbd_clt_dev
      commit: 50aff97483b6afe4a9796154e9f6a5ca0a4f55c2
[6/8] rnbd-clt: check capacity inside rnbd_clt_change_capacity
      commit: ffa41a71702493b9145a5ae4f4b1b8a4bab1b8f7
[7/8] rnbd-clt: pass sector_t type for resize capacity
      commit: 59498516e707ed6b6a5c01ae28fc816382d9698f
[8/8] rnbd-clt: make rnbd_clt_change_capacity return void
      commit: 3b56590b1715b998cb5c73a5bd2e9d340ccb42dc

Best regards,
-- 
Jens Axboe


