Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A01C10F14
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E3020857
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfDHQCP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:02:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38041 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfDHQCP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 12:02:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so3106627plb.5;
        Mon, 08 Apr 2019 09:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GE0TAFxw9kW2YRs7vIrsQIndfvAZMCvui/zXzKoD9l0=;
        b=qTMygxLpUlBC3q9JjpP4tBBELRB99dpR+8BrSCqvTJOV07+JQuG4teUGwh8MMYxLGm
         CMwSbz0ZozXAJ4bIAiS2YebR7JooBQ7xxAWuo2Gccvt7cwwHpfOAzMQ48tBn5vCz/OBX
         8pvVj+aYTyDxIecBpBTzfirbRdGdWCelkRZIbrZFUdMGCB+qgbU9XBSDS41sIkIj6HiE
         gcoIilv58+McQSDvsW4tGCpxXOu+qL9aDl8/EHPi5oMWpt3/Uct01PmtqMSocE6Mya1N
         cd2B3HQ1Ix468UGPYrhGe6Acc3PR0oB9nCmIyODhS08TOhKdswcO/PARQyeLuUA4JnOI
         V+iw==
X-Gm-Message-State: APjAAAXDwIFVmsjvvwNMXaIpDNhumKz5FY+p3GoR1Yt3/iCivUDEaMxg
        Tgj8rZh1FxIFGus2cdYDJzfKqpGb
X-Google-Smtp-Source: APXvYqx11fGkTEdCVM3C+S/wRWC4trFdCUCrSs2iiU1sGwRqV7sIeccP+PEtS4vGpMFYHg1sz6SoTw==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr31034567plt.59.1554739334272;
        Mon, 08 Apr 2019 09:02:14 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id c3sm56658009pfg.88.2019.04.08.09.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 09:02:12 -0700 (PDT)
Message-ID: <1554739330.118779.275.camel@acm.org>
Subject: Re: [PATCH] fs/block_dev.c: remove unused header file badblocks.h
From:   Bart Van Assche <bvanassche@acm.org>
To:     Chengguang Xu <cgxu519@gmx.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk
Date:   Mon, 08 Apr 2019 09:02:10 -0700
In-Reply-To: <20190408103354.18638-1-cgxu519@gmx.com>
References: <20190408103354.18638-1-cgxu519@gmx.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-04-08 at 18:33 +-0800, Chengguang Xu wrote:
+AD4 This patch just removes unused header file badblocks.h
+AD4 from fs/block+AF8-dev.c
+AD4 
+AD4 Signed-off-by: Chengguang Xu +ADw-cgxu519+AEA-gmx.com+AD4
+AD4 ---
+AD4  fs/block+AF8-dev.c +AHw 1 -
+AD4  1 file changed, 1 deletion(-)
+AD4 
+AD4 diff --git a/fs/block+AF8-dev.c b/fs/block+AF8-dev.c
+AD4 index 78d3257435c0..6b584817d461 100644
+AD4 --- a/fs/block+AF8-dev.c
+AD4  fs/block+AF8-dev.c +AHw 1 -
+AD4  1 file changed, 1 deletion(-)
+AD4 
+AD4 diff --git a/fs/block+AF8-dev.c b/fs/block+AF8-dev.c
+AD4 index 78d3257435c0..6b584817d461 100644
+AD4 --- a/fs/block+AF8-dev.c
+AD4 +-+-+- b/fs/block+AF8-dev.c
+AD4 +AEAAQA -30,7 +-30,6 +AEAAQA
+AD4  +ACM-include +ADw-linux/log2.h+AD4
+AD4  +ACM-include +ADw-linux/cleancache.h+AD4
+AD4  +ACM-include +ADw-linux/dax.h+AD4
+AD4 -+ACM-include +ADw-linux/badblocks.h+AD4
+AD4  +ACM-include +ADw-linux/task+AF8-io+AF8-accounting+AF8-ops.h+AD4
+AD4  +ACM-include +ADw-linux/falloc.h+AD4
+AD4  +ACM-include +ADw-linux/uaccess.h+AD4

This patch does not remove a header file but removes an include directive.
Please make sure that the patch title is not misleading.

Thanks,

Bart.
