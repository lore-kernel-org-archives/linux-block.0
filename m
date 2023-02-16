Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A55C61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 15:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjBPPTZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 10:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBPPTY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 10:19:24 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359B1C660
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 07:19:22 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id j4so754506iog.8
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 07:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=117JSzhkmlfdsoukHnoW9sXQoMG/9LAmqMYJYCnZSbY=;
        b=59hsNga9RXtV23zHRVyeQGnDxijDul9wg24JUhU1fXKawgJQjy3WJ6DFPufC5oY1rJ
         iv/r86GcE8wkbB9RgXS9ZDgiA92a2A+hiRJRKg87Mb7Ccebu0dHQ/5qKn6kQOzPKEYCH
         npZAEC5ARpe3BgCBfGvTy9oKkwqfbJXyYHu5PJ9lY5Lnuy4CwWDHLbKPpgtj7h/2zCY4
         fMyvorvl/U8QgVuMFCpIoXC34/lxOsxwaq1yJ8/WUSPgcNefOVsGI+GMMtTExRkfcnJR
         H/Ek2cUV51px0+kftEMCaHHkaJIitWbejJbojGNd16ls/2B/o/2G77vJGnACie4uP07R
         I8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=117JSzhkmlfdsoukHnoW9sXQoMG/9LAmqMYJYCnZSbY=;
        b=sUEILfTmxD9TmrXx4VrDp/zKLLkY6iILNPd32MDtO1kXioPnvWBeB4TTmrCJdYXFx0
         oom1FKNiOo8NDnoROn7h0fVc0eE8k2NujfCdr2m3H/JVidW/ccakTiegtA+Y/V/S4ihG
         nN3aJ80JOaxzTpkPpfc6TlUL9m+QtVVTkCKdfa0/owZbsDVqeuxf8D+YRA0RsrwsXi+a
         aj/IOvhkake58ih6xMfESTY6NScvEdNFuuc5qEbM2yp2ZgnndMWfk1P7UkvN3ZDPK6HQ
         3M6c/2ypSMnF88eGE6qHESJWo14InT9q9rUceKEwUeY2hp9hdXcRXVucvSe6LTjWDqUy
         1ubA==
X-Gm-Message-State: AO0yUKUE2OBP5EGhBM6A0GQ15AGyjyVxsyv69LwBrV6jXc6N0ey1Xi7b
        4NOGTG+1H5+yR8eEhraJyKq/qGJdm6XPPMdm
X-Google-Smtp-Source: AK7set96moDt68gR/d8a/XZ8n5rKRhuvBPVZrGVt+4ivwZIVctc7GeQA7Caj3Ql1TJJA05nAiM3/QQ==
X-Received: by 2002:a05:6602:2ac8:b0:740:7d21:d96f with SMTP id m8-20020a0566022ac800b007407d21d96fmr4855093iov.1.1676560761232;
        Thu, 16 Feb 2023 07:19:21 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p10-20020a0566022b0a00b006e2f2369d3csm561600iov.50.2023.02.16.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 07:19:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org
Subject: [PATCH 0/4] Support REQ_NWOAIT in brd
Date:   Thu, 16 Feb 2023 08:19:14 -0700
Message-Id: <20230216151918.319585-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Support non-blocking request issue for brd. Patches 1..3 are just prep
work and cleanups in propagating the gfp mask correctly and dealing with
errors that can happen, patch 4 enables nowait on the queue.

-- 
Jens Axboe


