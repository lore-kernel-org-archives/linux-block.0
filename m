Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581ABC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2585920842
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfBLQbo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:31:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38621 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfBLQbo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:31:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so1542227plb.5
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 08:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3hgytAGDUrZ/R0IfohYIBCLhO49aHp8Xhw7B3mqkak=;
        b=khwmpIOtCuzGu2LGKfJ8DNIGfJkttAazEO2o5JRP0i4bxYo4paYo3Zskm1iM/6JsdK
         CiBOr7TE9nTeKwpVr81DqRD8M6L7Z4MChwzLHsmnNdwTL63P8qXkBLCfwEMostIyTrjC
         DQFDFUi7pg2UIhy6In9SK6mYJtHKdCri5EV97maOfhTPvU/TldExpDxqtH/CtKHF10tI
         PFRHnpbJ/L+OjMuG1f2usGLRXB1HnF4SsqJCaYU8sQLWPtdTYkYL5/0OsHWT3Xb37ki6
         ZI5m6sDqe/qbbZwnUotoQxAbOVRDo2ezTYQ9g9VZhnKC156P5aEvEJblBZ4G1HJzZKkq
         irJg==
X-Gm-Message-State: AHQUAuZafZEneTJuCBzxMOPmPJ3g5qon5+H1JvYRYFDnVAhTI0j1/8S2
        aM6Qn24S2M7A5XQTE0DpyNI+AIuQ
X-Google-Smtp-Source: AHgI3IYIHNKNUC1u0RStpSiSWiY0kMcE3NuDa9aGq1ttxjOVYIuDu87o6I215WnUtT59cRk5zZwXKQ==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr4827703plb.192.1549989103738;
        Tue, 12 Feb 2019 08:31:43 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o23sm41245970pfa.140.2019.02.12.08.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 08:31:43 -0800 (PST)
Message-ID: <1549989102.19311.30.camel@acm.org>
Subject: Re: [PATCH] block: remove redundant unlikely annotation
From:   Bart Van Assche <bvanassche@acm.org>
To:     Chengguang Xu <cgxu519@gmx.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Tue, 12 Feb 2019 08:31:42 -0800
In-Reply-To: <20190212031657.14324-1-cgxu519@gmx.com>
References: <20190212031657.14324-1-cgxu519@gmx.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-02-12 at 11:16 +-0800, Chengguang Xu wrote:
+AD4 unlikely has already included in IS+AF8-ERR(),
+AD4 so just remove it.
+AD4 
+AD4 Signed-off-by: Chengguang Xu +ADw-cgxu519+AEA-gmx.com+AD4
+AD4 ---
+AD4  block/blk-cgroup.c +AHw 2 +--
+AD4  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
+AD4 index 2bed5725aa03..699dba716c83 100644
+AD4 --- a/block/blk-cgroup.c
+AD4 +-+-+- b/block/blk-cgroup.c
+AD4 +AEAAQA -880,7 +-880,7 +AEAAQA int blkg+AF8-conf+AF8-prep(struct blkcg +ACo-blkcg, const struct blkcg+AF8-policy +ACo-pol,
+AD4  			blkg+AF8-free(new+AF8-blkg)+ADs
+AD4  		+AH0 else +AHs
+AD4  			blkg +AD0 blkg+AF8-create(pos, q, new+AF8-blkg)+ADs
+AD4 -			if (unlikely(IS+AF8-ERR(blkg))) +AHs
+AD4 +-			if (IS+AF8-ERR(blkg)) +AHs
+AD4  				ret +AD0 PTR+AF8-ERR(blkg)+ADs
+AD4  				goto fail+AF8-unlock+ADs
+AD4  			+AH0

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

