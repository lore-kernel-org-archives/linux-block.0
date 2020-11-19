Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D893C56201
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 15:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F2422242
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 15:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMB7AAct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgKSPdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgKSPdA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 10:33:00 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45DC0613CF;
        Thu, 19 Nov 2020 07:33:00 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id a15so6285209edy.1;
        Thu, 19 Nov 2020 07:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddxSt3wpSpboFERrBzVXzYpBlWugsPxM3x0s+uiBN2M=;
        b=iMB7AActJAYhUi6yp+uKKqf/eJgTmphnLGUbc/I2BAdd/Ao2za7FuaEkiyf+eSfTGe
         YaAvGicLhCpfhrskqGXxqOzGB27p+JVMgJJSCvy9OajV1xCiCCscL/lg7HbT11J2uJcB
         7m8ngC1oWnR/81cVGHR0jXPlU13LKVgvvHRyXmjS8YhYzpRNWFffw1cugGAmybdjpfC+
         3J1SKQKa5gjYZmBE3GA6sGW9U87foJ0p9AdYH7VbiK5SzsFgF6nwlhuC86p3iG2mhZih
         Z2lKpQ7PIgv1tvzeuHuhAUCGlhKH31uqeTNjd8570WC1GlA0fhT1lylnjmfjUUyvb3rk
         t3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddxSt3wpSpboFERrBzVXzYpBlWugsPxM3x0s+uiBN2M=;
        b=BopokDnwjd6QQABAijRn/LPeAjxLxQZzCg7qBo7Lc9ABjS1HyC/CDoo5fjqtroARHy
         XmVdPykJunnpQj7QQ4OOFMmIW8Tot0vdb0uGO6H+c6CYKfqSm9iTFvTKwdm1WH2Mju9+
         6UhrKGknnZ1CyL8hcsPZmq7uUHs1jVhLKIUG4aDr1XX0ABA1s9ZbCsUrknJKVFp122gr
         a3P129Y7FH4OxyX0Qysd22XCmAhGJ9ToDEFSwqREyWHjMKozCOCG3jBKkipXXKyQCSc0
         TiBlU93OKnhHGr8XCYv0KX7lHau4g1VTe+8XbZfvUhETIAtOT260jYk0rV7tuGzR006i
         sv6w==
X-Gm-Message-State: AOAM532L3vORalOw0/Eqpwyr9dTnGSSu7Lcf44QEep9yXxFLiH+G1P8a
        IIf+Hk7HP5+FDcHVParQbsuNiKhKzJ44sA==
X-Google-Smtp-Source: ABdhPJwGZZjfAcLjNFQmoj+12BbllR5+smck15BtFcLyUbze6Gh2p/TVFNPCRgVO4m5B8mnPcLb9BA==
X-Received: by 2002:a50:da4b:: with SMTP id a11mr13553485edk.364.1605799979057;
        Thu, 19 Nov 2020 07:32:59 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id u7sm3595612ejf.83.2020.11.19.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:32:58 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] optimise iov_iter
Date:   Thu, 19 Nov 2020 15:29:41 +0000
Message-Id: <cover.1605799583.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The first patch optimises iov_iter_npages() for the bvec case, and the
second helps code generation to kill unreachable code.

Pavel Begunkov (2):
  iov_iter: optimise iov_iter_npages for bvec
  iov_iter: optimise iter type checking

 include/linux/uio.h | 10 +++++-----
 lib/iov_iter.c      | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.24.0

