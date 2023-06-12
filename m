Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EB9C77B7A
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 01:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjFLBtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Jun 2023 21:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLBtK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Jun 2023 21:49:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41CC12F
        for <linux-block@vger.kernel.org>; Sun, 11 Jun 2023 18:49:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25bdae05eb3so171337a91.0
        for <linux-block@vger.kernel.org>; Sun, 11 Jun 2023 18:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686534548; x=1689126548;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5U8oyK5GvJhj4Ee7fdxDkvyVUsHqjfnF8NeWf8XxItU=;
        b=wZzIkBfWdhXKPiGod3HcmD0cDSxEPRas9KTszL4STTlTfZlTsRmv6pdEnvO+csFkl/
         zf6SElO3xUazy81wnZgHrwI3fEOhB8a/uD/t+65cR6Kt54uOesm/J56p75pflFVq6fmM
         HDUcU3c11xYY9a4ehzxsdpN25kCE+WxLpXtKj+Ia8lHh/OUTKhTWWWxADyDoL73ut6ow
         8icw/ui1OqIOLzRqDC4MfnUgLX9mAoIiCv9h431hWY+WdJTdJgDPqYZEPydvdAzWL/bm
         cYPxsnrlRL9U5a56CyoQF2ICct8XFQPDRVLyBk5RjsFXa7DiCg+cM2+3aw3gpK//uGy/
         +kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686534548; x=1689126548;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5U8oyK5GvJhj4Ee7fdxDkvyVUsHqjfnF8NeWf8XxItU=;
        b=LOeAarlkDtFQYKW+fKsUte1WeeZtaQYu765ISmGoKkGxWs2l2bCS/2n0i4eC0iOqPd
         A+gNKuj4eK8KFswOJNPQqick1lb1us5y89UoS3xpO0LDHW/lI1Jn0Gw0WvFlmmsilfIL
         qAYt8kVTGtaG5HIwY9YSqJkRJv3iab4Q2CIwc4YW2NigtwRis8E4ABl2ug22Ad7HK7ih
         joL+UI8TCoq8sJZYVhKlfo1fjAtsoSnliLDmVmpqbGYlBkNkddAU6FQ2FPFx9ZQpRumA
         hNbsPH7eJ70Xe+bQUY2JwDOHe7dzCaBmf+fJFkLq1fZ56M2FoiasQqAn+8jep5/o5X/m
         CQ/Q==
X-Gm-Message-State: AC+VfDyAAuUSN3cZLzywPjBwKM+wf5WJMyV2i97jrsYd/RbaHHHgs7Q3
        xF09Q5fIBg/IZgQnQ1PM0JhYoaEz+2QRKALBZkg=
X-Google-Smtp-Source: ACHHUZ7AXnDu72RnN78JE+qXYbIQxrIu3H5dvr0kG8IW3Nm78Nt3l4OSkMF61BfnNEstl7PoPwWtXw==
X-Received: by 2002:a17:90b:3852:b0:25b:de63:f193 with SMTP id nl18-20020a17090b385200b0025bde63f193mr2420894pjb.4.1686534547697;
        Sun, 11 Jun 2023 18:49:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a195700b0024e37e0a67dsm6802959pjh.20.2023.06.11.18.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 18:49:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230524070026.2932-1-guoqing.jiang@linux.dev>
References: <20230524070026.2932-1-guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2 0/8] misc patches for rnbd
Message-Id: <168653454636.828148.3086329887965824145.b4-ty@kernel.dk>
Date:   Sun, 11 Jun 2023 19:49:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 24 May 2023 15:00:18 +0800, Guoqing Jiang wrote:
> V2 changes:
> 1. two patches are dropped
> 2. collect tags from Jack
> 3. replace "int mode" with "enum rnbd_access_mode" in the 3rd one
> 
> Hi,
> 
> [...]

Applied, thanks!

[1/8] block/rnbd: kill rnbd_flags_supported
      commit: b0488411e919368014907850f74191d03e25f031
[2/8] block/rnbd-srv: remove unused header
      commit: 5783153ac67e20f65a402ef42237cd1a6d7fa320
[3/8] block/rnbd: introduce rnbd_access_modes
      commit: d6e94913cb1cb4b4d1d737f72b5cef10b13395ff
[4/8] block/rnbd-srv: no need to check sess_dev
      commit: ba2eed1cf8f08f1e5b1ba009ac22554f14d05342
[5/8] block/rnbd-srv: rename one member in rnbd_srv_dev
      commit: 3ecdbf91513511fae49eb0cfa9f39f690eb4fe11
[6/8] block/rnbd-srv: init ret with 0 instead of -EPERM
      commit: 6a12d5379508d530a73140fc7d5502551558ced5
[7/8] block/rnbd-srv: init err earlier in rnbd_srv_init_module
      commit: d3fc0b46642524bc8e38aed3c7f5e99742436495
[8/8] block/rnbd-srv: make process_msg_sess_info returns void
      commit: fece685cc7bbb5e1af89f891223c31c3bcc969f7

Best regards,
-- 
Jens Axboe



