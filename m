Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F29C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A2761159
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhJEPbR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhJEPbR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 11:31:17 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EC9C061749
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 08:29:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d11so22227709ilc.8
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iW6K9p6yFxtQPtK4TyVedjg4mcq0mrI3ScglTW1kRDQ=;
        b=KFJcE3eLpaBUGyUxuZB5iobNm/eQqRm8EbzGd+uObJgAQ8ddzEfcgK2A7N92BYOIHb
         4Inn5MpqGwT+4N1eb/b2MkAHc9iRCgLRdo1yitO8ntejT0Dt+nLoxNrL7OeWb0a9601c
         ai3mq88mqoRrSmyPjB9fE5TRmONnYdFBwi4OVSWts7XAOoh5O0n73mIUNSjz7KlXtpIZ
         8oWJxUumAUN+8/CHubTPHMetsgh4UDLKAeEYP18cmw7kWXYuzlNlE0x65NTSqr0t5bkJ
         /pqMnJZogvy5jr+7jgxC6VZzvnLqGIEozeetm0laCxXAKoP1Mp1ATYY4JfZAppLU+8R6
         BSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iW6K9p6yFxtQPtK4TyVedjg4mcq0mrI3ScglTW1kRDQ=;
        b=p0afw/gqam0DbFoAR2mUfNUNeyxojqvEds9SrcYK/jcsDr1D6KuRUGRv1vly7E5OsJ
         5+UUpXoVxIMKUeX9cJX1rqOvh+V1pgoQe1ZGchVxgrjaDv0CvzgmvNgVQBz1+pTSInX3
         Wr1lRQIZsqTn2OwzXC+X65pM7forl5K1KgII7K7ks6xNwlw5bCdyto0E2pVqmGLNn7sT
         u4xwoKCO+JLfyN95vjyOq4AqWtlIyPEQ42G4D2jsNWCanC7J4zf/YdiYzd+twbsMqj+q
         9QveU5CiYNnu45+mJ6hbI8VBei9gXaHgVUFU5fBtsHf7HlU3Z6KQXLzGv5ocFo2ApDge
         Tz+g==
X-Gm-Message-State: AOAM532PcUG7a0a9XBPbHA0qZepuLG1Hrv868OWBzC01Wagy3vIRydMU
        YCCYnufGRm78yL8W8kvDaQdcyaIpnBf2EslMKPg=
X-Google-Smtp-Source: ABdhPJxp8CAMekighXgeXneQ96hT8UovAvdJZ6atqdRblgPEtuPuWKcJUj7EBdWjspFtY8BqfNpV9A==
X-Received: by 2002:a05:6e02:1445:: with SMTP id p5mr3588440ilo.11.1633447765547;
        Tue, 05 Oct 2021 08:29:25 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m5sm6317762ild.45.2021.10.05.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:29:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     tj@kernel.org
Subject: [PATCHSET 0/2] Reduce overhead of CONFIG_BLK_CGROUP
Date:   Tue,  5 Oct 2021 09:29:20 -0600
Message-Id: <20211005152922.57326-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

As some are probably aware, I've been doing efficiency chasing for
block devices using io_uring. Currently we can do about 5.1M IOPS using
a single logical core of a single physical core, but that's with a kernel
config that's shaved down. Enabling BLK_CGROUP and performance drops to
~3.6M for the same test.

These two patches bring us to 3.9M, which is a nice improvement. More
work to be done here.

-- 
Jens Axboe


