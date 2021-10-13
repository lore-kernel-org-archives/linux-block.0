Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A044AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9AA60EB4
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJMQvp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhJMQvo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:51:44 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2EDC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:41 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w11so392071ilv.6
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=df0xnPiyqcuM1Nzi5PvpJ8aLl4R36Yqjv9TJWZ3Vk5U=;
        b=gHcWdziVHWKehigqjTi5oV0yz26TmKTT+xfLfKaatVdZQq/swmkQaSArWXMO9F5Ik6
         UEeFBBm8lr061T0Nh+gbeNOXKhn+soIKXpWWym75HcNsLjcnIgAWc9CIRfaPHZh8t01T
         Cy1OEB1LWmekPtxBaykoc1KuTX41ePjjo0LDR/92U7cOlpMaxgyue/mxPIJGZi5X1W6E
         NHMif5mYIwlGGcSc9Fr0pLc4zQPWThdXgr+h5PshFQqWZRsYci6jdMfiyDh/dl0xb1gv
         nOBy669Mz4IK5JiXc1OXp3PVGoDB02mQyS8DQq9kfBaQQUTFASOap4JKjkRS9oiqJi6U
         AJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=df0xnPiyqcuM1Nzi5PvpJ8aLl4R36Yqjv9TJWZ3Vk5U=;
        b=aIGP6p01KsXCI+/r7uVHoKJCd54VvapElchtIm2B+oQVbL1Jv87mWvPZa3Q5brXeE2
         1syCUpdNmeU4xHdL1S/QwnbQq3+nSKoMo70lZ3MNs21xYS1OzYjnFQedQj13pdnpAaN2
         igSvLHUZQUsX8NLZtT68r/tCKQqxUrIGrvu0I90WG49Au35o6TATWk3Jd2RoK5M+GDM9
         8jk7Cm6SiA1eyeW/eBALy7lEnz9SfdHzTQTXzrh4F0A6CrIWV4KZZiY6nnbkbRaJ5Ldf
         eOcOotTyJ013pE3ubykrumVcq9o4m4xKRhysv1F4Kp6ytRBH+rd1Z2Vsm4218qsNTLBi
         E2XQ==
X-Gm-Message-State: AOAM53179TRyFmMySLdbiUMfkyBTqLHO0AiaLbF7J7IRr9L0qhTVQnlX
        Q6PR1lv9pX5cvqK8RzkMVr3X86wRqsz4dA==
X-Google-Smtp-Source: ABdhPJy7RfB3k+89DcSKAkERI2VthYuVIYXIFud0D64NlvPZj0lCwJcUt2SZ4wYsmITeJa6smHp4Sw==
X-Received: by 2002:a05:6e02:198d:: with SMTP id g13mr99690ilf.300.1634143780420;
        Wed, 13 Oct 2021 09:49:40 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v15sm17217ilg.87.2021.10.13.09.49.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:49:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/4] Various block optimizations
Date:   Wed, 13 Oct 2021 10:49:33 -0600
Message-Id: <20211013164937.985367-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Patches aren't really connected in this series, they are all standalone
optimizations that make a difference.

-- 
Jens Axboe


