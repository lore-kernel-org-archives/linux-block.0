Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA97ECAAD4
	for <linux-block@archiver.kernel.org>; Sat,  3 Sep 2022 17:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiICR32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Sep 2022 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiICR30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Sep 2022 13:29:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C07DE73
        for <linux-block@vger.kernel.org>; Sat,  3 Sep 2022 10:29:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h188so4590272pgc.12
        for <linux-block@vger.kernel.org>; Sat, 03 Sep 2022 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=52EnIjUfy6s2MnVsro/QtNEzT4FZRbZlA+cF6ZAg+Wc=;
        b=b3lV3R8ldIi3MCKRhV6deyZC4NhsHDdqZ97ILrzPfb4nqT/XyhYXGOvOGVDlHJ2/BP
         jmHVBSlA3x89pc1hfAjrnYfQ1vAPMKUlxydcY4Etx6LR+1ZTzfJ4Au5uO9JdwAUf7RwU
         DANm5uPNz39ZOLud1mMo2YX2C9L9yLRu74goHMWcjyHRJbxmAG8bvNPeuTz6cJHbwDCU
         JdA5pn+nBsC2efVOOxxjMrcsQ8Llx47n8yhIrD2+bL8MiP+Y8XDCII+vXXftfSt+cdB7
         QCcl0SyjcUtloKeCT2NCk0RsLZk3Whdgx0a95C5ogFa2k6JRoBmSTsiNi3AiFW0I2KVf
         GeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=52EnIjUfy6s2MnVsro/QtNEzT4FZRbZlA+cF6ZAg+Wc=;
        b=5Nh53AsnqMHYfXWsW2dXZgsABU4GsjqVK+XYs/yLD00xnyqoxtZFKIZKsELMDtc4pc
         MncZsCB7s+gca4evH5+JYGe1lNP1jkkJoVyncdtCWohS/YXKIy6o4ltScNrCmO2T/IJk
         ArvaYpIJVQV5ZS1B5vPXjUKvNk0hSjTN9GJeWoaVtRJ/FTT6I3koCEmuKebE61Wdnrvm
         YNCunVL11S8gFRtCqWkx1hpdDn4U3CwgXWWopkCXIVRW/Fv7bi+e5aSH8tPkEPvCKDBq
         u/04jPdJy0gBeVMCSfBNSuSbJYDHFl3Tnk68V9pQf5A+ZYgA1j5D9qbDtLSO+MjU3a/E
         eUTw==
X-Gm-Message-State: ACgBeo1yiH6fQQNdUH8VhDGaujr5wtTNHVoe8G3K0juzIGVIQ4J2XNvL
        WFHNgtqs0+GfnT9RfAgfquc57Pqqa3KKZw==
X-Google-Smtp-Source: AA6agR5+P9sYS+tZCQIJ8X0AF0yNL6O39mJifEjp2OoxZMxI5zstlPkvk7+qYGeKHTAiVR91cqdjNA==
X-Received: by 2002:a63:25c7:0:b0:42c:450a:20e6 with SMTP id l190-20020a6325c7000000b0042c450a20e6mr24139067pgl.277.1662226163200;
        Sat, 03 Sep 2022 10:29:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c14-20020a056a00008e00b0053ab9c18d3csm4362065pfj.14.2022.09.03.10.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 10:29:22 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220823103819.395776-1-ming.lei@redhat.com>
References: <20220823103819.395776-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: don't add partitions if GD_SUPPRESS_PART_SCAN is set
Message-Id: <166222616124.223043.14028529491012837737.b4-ty@kernel.dk>
Date:   Sat, 03 Sep 2022 11:29:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Aug 2022 18:38:19 +0800, Ming Lei wrote:
> Commit b9684a71fca7 ("block, loop: support partitions without scanning")
> adds GD_SUPPRESS_PART_SCAN for replacing part function of
> GENHD_FL_NO_PART. But looks blk_add_partitions() is missed, since
> loop doesn't want to add partitions if GENHD_FL_NO_PART was set.
> And it causes regression on libblockdev (as called from udisks) which
> operates with the LO_FLAGS_PARTSCAN.
> 
> [...]

Applied, thanks!

[1/1] block: don't add partitions if GD_SUPPRESS_PART_SCAN is set
      commit: 748008e1da926a814cc0a054c81ca614408b1b0c

Best regards,
-- 
Jens Axboe


