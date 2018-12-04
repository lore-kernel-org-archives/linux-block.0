Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0384C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8C820850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8C820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLDAbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:31:31 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:36875 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeLDAbb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 19:31:31 -0500
Received: by mail-pl1-f178.google.com with SMTP id b5so7344938plr.4
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 16:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4XsbgFKwRKDLzseCO6+ycUkiHYFJ43dzKGvhHwYap4=;
        b=sqIlWu7WFmvR6UhRbZT6sTNRLh6wYyk9oGim750jzfPcjI8CA8EA0QCgD+p9QLVIFx
         fTJgJySVrsLa+gundQ/zm0/qVi1IA33bQCofY+dffSEwn8J42Bv0IDUafXOOYu+ryQeS
         foYnfg4+72JvSYAi87oqNZfc9IzxugZ9DrDmmrP3L+PUYYajYQcefvI00eW0FTYUDMhF
         xuurvzbt3lqOQbwlpX1pVDyVhRuzPBqSgeq9QznbDHt7zRCsCVQ/v8ZX+zBGHWpkcNhJ
         FUt+c1SZvUMLaGVNN/DeGUz4F86Nj8n0dKtEPGBPbaLSuMTzhPzD1x2OlGFxfeU2H0h9
         ggHQ==
X-Gm-Message-State: AA+aEWYxI8qRlpfEKQtgi1Z+zFsXuh/BlwBwN72eO/HKaXXWonLrZUus
        SsJJmbCisAKU7MO5enzCYss=
X-Google-Smtp-Source: AFSGD/Uk3ePFQcwGRwPe5GF6tcFjzFhjd2cjYazLH1ROQmljbQtBakkvkD/+VXD/Y8gLaFzkBK6yeg==
X-Received: by 2002:a17:902:9a41:: with SMTP id x1mr17806749plv.126.1543883490542;
        Mon, 03 Dec 2018 16:31:30 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h129sm37970447pfb.110.2018.12.03.16.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 16:31:29 -0800 (PST)
Message-ID: <1543883488.185366.176.camel@acm.org>
Subject: Re: block: sbitmap related lockdep warning
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Date:   Mon, 03 Dec 2018 16:31:28 -0800
In-Reply-To: <879e4f73-caa0-93e0-a6c3-3d53d1962cee@kernel.dk>
References: <CACVXFVObAF+keMw3aDSMBg0vfL-wSVFMw46ubkxEP-09QX4bsw@mail.gmail.com>
         <879e4f73-caa0-93e0-a6c3-3d53d1962cee@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2018-12-03 at 15:24 -0700, Jens Axboe wrote:
+AD4 On 12/3/18 3:02 AM, Ming Lei wrote:
+AD4 +AD4 Hi,
+AD4 +AD4 
+AD4 +AD4 Just found there is sbmitmap related lockdep warning, not take a close
+AD4 +AD4 look yet, maybe
+AD4 +AD4 it is caused by recent sbitmap change.
+AD4 +AD4 
+AD4 +AD4 +AFs-1+AF0 test
+AD4 +AD4 - modprobe null+AF8-blk queue+AF8-mode+AD0-2 nr+AF8-devices+AD0-4 shared+AF8-tags+AD0-1
+AD4 +AD4 submit+AF8-queues+AD0-1 hw+AF8-queue+AF8-depth+AD0-1
+AD4 +AD4 - then run fio on the 4 null+AF8-blk devices
+AD4 
+AD4 This is a false positive - lockdep thinks that -+AD4-swap+AF8-lock needs to be
+AD4 IRQ safe since it's called with IRQs disabled from the
+AD4 blk+AF8-mq+AF8-mark+AF8-tag+AF8-wait() path. But we never grab the lock from IRQ
+AD4 context. I wonder how to teach lockdep about that...

There is probably a better solution, but one possible solution is to disable
lockdep checking for swap+AF8-lock by using lockdep+AF8-set+AF8-novalidate+AF8-class().

Bart.
