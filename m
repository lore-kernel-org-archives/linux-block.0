Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A057DC07E9B
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 12:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85640619D2
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 12:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbhGFMcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 08:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbhGFMCY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 08:02:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0014C0613A0;
        Tue,  6 Jul 2021 04:34:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u8so25642951wrq.8;
        Tue, 06 Jul 2021 04:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yv7klRcSZNtoO+YCPzzJU5HrTFcadvUP9OGq8uM3AYc=;
        b=PWJji29fyaRN+yUkhTohrKnKgIItivILKx3gmRBEowcWDHNC03lpUD1A2uAYrF67Wv
         lakOiD2O4sRcNOUjAKWo4NfynshuJi/Y4NbGoTdyLXonJH7L5F6FQosGTcinEH7NCwCc
         9QX0sglYfa2rNNYhi1gbX4thH/ztLyZEnXp0eQvTNJcpiiFWsmxachyvyef8pYg5eWkE
         oyH4mLY+zImuXdFogB+MYcsCGcGCSeobmAUhNTfnd+F+gwF5Oj0FfWTgGXBcvz8QBVqr
         HxfXyKcfel5zGYphJTucMZ5SKqHOGFMrC8Gq9LsA2IsZCpsxwmPFx8bcbdOU5i1HdcSd
         SWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yv7klRcSZNtoO+YCPzzJU5HrTFcadvUP9OGq8uM3AYc=;
        b=cgT4SFp5TMKVjZe/JmjGT+5O2fXnef17MaozvTdHRy2mRv4v925T1Q4OfGGOBoiSmf
         QNYMsW3cYDBiVxKa28jaJNcHsdlLyVIP9GUpVTN+u/pDUGp4mIf7YizDyaY8MXPtuM3P
         qB9GI8CwlWbSjPOwJXQdPmtQwHL61HIQGOQLbeO0n4jKwh5AZ/gdgSOXGuCtD7oRouWs
         Zneg4WOX7BDqVB4Ewp1UGStCWKsdwqOXWemIFiixNNbVJHf+bdeXkoiBy42wauTtPC14
         TqdAblJwkMKJYnR9s/9NImX86sMQksliPWJX3jt/IzR4XNmT1W9I3kg2C5Anm6hbesEz
         QKHw==
X-Gm-Message-State: AOAM532mxN6O94OmpmZhZzPPLm9paVRI7aNuDbIwThGefqfSl3jgTcCF
        POLQA61G4Vf/AjM7psY9Feg=
X-Google-Smtp-Source: ABdhPJxF4A3lcDvg/enPNqf57lPLvLc7ZYnnpy+MDxjHhvYiVIRmiwhj3lcXzQrRjxajIScDaOEnQQ==
X-Received: by 2002:a05:6000:144f:: with SMTP id v15mr10328613wrx.375.1625571245485;
        Tue, 06 Jul 2021 04:34:05 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id v18sm16496143wrr.54.2021.07.06.04.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 04:34:05 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, kbuild@lists.01.org, lkp@intel.com,
        kbuild-all@lists.01.org
Subject: Re: [PATCH v2] block: Removed a warning while compiling with a cross compiler for parisc
Date:   Tue,  6 Jul 2021 13:33:24 +0200
Message-Id: <20210706113324.98041-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
In-Reply-To: <202107060648.767XjMRK-lkp@intel.com>
References: <202107060648.767XjMRK-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Dan,

Thank you for your comment, I have fixed the issue, added the discussed tags, and sent a new version of the patch.
