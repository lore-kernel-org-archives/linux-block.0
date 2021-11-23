Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD40C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhKWROJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239012AbhKWROJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 12:14:09 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECFEC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:11:00 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id t8so12524323ilu.8
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+14E0SQffHzOR7qgUY5NIu1hgOZYrgClMEKmiWyxDM=;
        b=GUKjedPAU59dmvpC+Du26IhecTPPT5SCxx6zy3Er/PD3aKdKUHdgp4p8oVSVGyZDsv
         mSUp8HU+dNTXl9Oi2l6Pe0Nx+Mv0MDAs4mDGLk9VlOTrEmUEyiTs48bAKls0/uLBF+8E
         ZeX8bKhHYxYB1c7ouyiM5dSSvtNSAYTusoTW/NPMtx373UH/I28ZQNyMbDQ74Ojst7E6
         76lKLmeqYc5q35yc9w+Wgk2rYhk2Nes8eUZcI7TWKC3QGkJuBjfg6UhzY3xf1Ap4IDFz
         WxKmx+WPpUSXJMFymk7P/7ineo1I3KPTl83+lsuCldRKnwuMjk4R6fwg6Lcc0Vh7XJea
         Bulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+14E0SQffHzOR7qgUY5NIu1hgOZYrgClMEKmiWyxDM=;
        b=qOEYowPnyx68yGS+oiCvpYiMUbBpdAaYjRog7jvFByzfYRRaXHnHCp9+XNX24DJMq5
         9NOgDVy3KRfQmUTW43OkBTKeFJQn2p+eqIb+9iSY9K6CFpMeYBo5aJQ87cn4n0n6zTPO
         wpEX1dmNU/DJiQculPLea/PIwpDCB0l7fXZZDFCLS/ueQu77HovIqCaKae0fGmNxzZ/6
         0iz5A0TsURrcfv2MIseT8AX/XF4i6FE7iyNH2mPNCKjaQG+ooY1GyIDmqIFBA7jSlcJH
         BFlYmtQv2dGIbnPnsweekpdgywZKRxPsASxa9IkHMfhZCp8+E4Dgso8s3QCTR1ECsQZB
         4O9A==
X-Gm-Message-State: AOAM533MqNBOU/JxPNu1umfJPswEV6t6Z/D3in4mRqFGgUIEO2VamkyM
        qHs6PnjNN6Xxa2X5JMYmZ7Sb89niCgu0VRea
X-Google-Smtp-Source: ABdhPJxDVMmhPQhyTngV/AQnEt24IS0NwVl7jgZo5Cbe0SBZX8u6v4jFRvezof3GqXa5dqVBxqrsZg==
X-Received: by 2002:a05:6e02:5c4:: with SMTP id l4mr6078150ils.317.1637687459937;
        Tue, 23 Nov 2021 09:10:59 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm8251283iow.9.2021.11.23.09.10.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:10:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/3 v2] Misc block cleanups
Date:   Tue, 23 Nov 2021 10:10:55 -0700
Message-Id: <20211123171058.346084-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

First patch avoids setting up an io_context for the cases where we don't
need them, second patch optimizes re-writing to the bio if not needed, and
prunes a huge chunk of memory in the request_queue and makes it dynamic
instead.

Since v1:
- Get rid of QUEUE_FLAG_POLL_STATS
- Use kcalloc() for poll_stats
- Move io_context creation into blk-mq-sched helper

-- 
Jens Axboe


