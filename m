Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B203C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F1C20850
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F1C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeLEP7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:59:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42753 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeLEP7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 10:59:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so5452696plp.9
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 07:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vBxReaGs36YPUCHCTOiShJ8rkmFuemBwF9YWdFSORlM=;
        b=tCT2JNNndCgGhF2i2AqSUIOOoD0cjpl/+mRbXAW39UsKacBofcW4VorvC9ctpw0+MV
         13Xm8TwiPs8R5UhsnztfquecyCCgC+PerCICjzHNrmMMXCjvHWEWYNP/ER+D17QNb3pW
         EAhoGV//942XjexKAFgUzxM1qNwv52nkYTKwOs5TUFArE7qK/0kMA+k5g+Aiv6d7YxvQ
         82fNXAX2g7mfaLHgW2Vm3MI2dLZh0i4FXRwLPCmkuaGebdRi7o+nejF9jw5YCtOH8L4L
         K0U2ed91n1jp7LUR9ZdUdwDXPYP09S4zwxbgJMWRk6QLgVPA3MZONyVJe0rQt+dWRrUr
         bgiA==
X-Gm-Message-State: AA+aEWagKjAUNvKhZNctjwqo0rHEZ5lTo3GB68cAVpRteFqy+vVhQ16Y
        EzrZ12vKbw5TsYjdl96mnhs=
X-Google-Smtp-Source: AFSGD/UpGMJxFEnSKPmUPKrVWXufRMFdVSieJRVUtcncrUlrgNvSBaLy/sm7OOzqPzgxCOyVI99clw==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr24781083plb.169.1544025542824;
        Wed, 05 Dec 2018 07:59:02 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h64sm11522914pfc.142.2018.12.05.07.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 07:59:00 -0800 (PST)
Message-ID: <1544025539.185366.224.camel@acm.org>
Subject: Re: [PATCH 1/2] block: get rid of BLK_MAX_TIMEOUT
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Wed, 05 Dec 2018 07:58:59 -0800
In-Reply-To: <997df532a176a435c3581ce180f318a298084393.1544023832.git.zhangweiping@didiglobal.com>
References: <cover.1544023832.git.zhangweiping@didiglobal.com>
         <997df532a176a435c3581ce180f318a298084393.1544023832.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-12-05 at 23:37 +-0800, Weiping Zhang wrote:
+AD4 +AEAAQA -130,7 +-119,7 +AEAAQA void blk+AF8-add+AF8-timer(struct request +ACo-req)
+AD4  	 +ACo than an existing one, modify the timer. Round up to next nearest
+AD4  	 +ACo second.
+AD4  	 +ACo-/
+AD4 -	expiry +AD0 blk+AF8-rq+AF8-timeout(round+AF8-jiffies+AF8-up(expiry))+ADs
+AD4 +-	expiry +AD0 round+AF8-jiffies+AF8-up(expiry)+ADs

If you would have read the comment above this code, you would have known
that this patch does not do what you think it does and additionally that
it introduces a regression.

Bart.
