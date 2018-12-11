Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF5DC67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9522D20870
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9522D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLKXQR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:16:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45743 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXQR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:16:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so7630657plm.12;
        Tue, 11 Dec 2018 15:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qx8ck+bCS8xNMB6L1Jbv2bXMQ9MinmQyXaEbJcK2iw=;
        b=jOtov/HBtnSEyUhn6Gqt5wpcCtcYX9dYJI+/p12rY9ZQ+bP4Jek2tBM+4pBEld7Jx7
         n31qRpbDwc4bLgFBCCxPXsEcr68g/jbBoXPnwehQqjphR3xmnmQs6/NS2ggKRt8xC+51
         xZeU4xVBCOt1PSoCkeOl0QmLOldMhIsOmQndBLG55IBxZKcOVyKdQ6W653yKv4/0G0b5
         S4DGP+pDd15E4oeW1ABkvkN0mO5G10E9EpGEqR4bbvB/mBW87KUTV1lhN3O2XojuX3cj
         JGgG/kaeWL8RHOFicybcUWtzo/gyqrT+NuBsBjZSnZf/9dp1Azba/9y7kRfp7JktrVki
         kPYg==
X-Gm-Message-State: AA+aEWZjw9OhprptpPM8nyHYtjUK9JpPo5w6w5u6J+lceOuw0zH0qQ9Z
        qjUXcVpnZOk6tAbtxMXA3GM=
X-Google-Smtp-Source: AFSGD/UwbskVYXrCOf5iQqkHK7NmRsG2Lr1bLYta0QAuFoc/SxyT1lEuUNZXR28XzlbS0zuORl8BBw==
X-Received: by 2002:a17:902:3124:: with SMTP id w33mr17897851plb.241.1544570175563;
        Tue, 11 Dec 2018 15:16:15 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 12sm15469587pgd.35.2018.12.11.15.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 15:16:14 -0800 (PST)
Message-ID: <1544570173.185366.397.camel@acm.org>
Subject: Re: [PATCH] blkcg: handle dying request_queue when associating a
 blkg
From:   Bart Van Assche <bvanassche@acm.org>
To:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Date:   Tue, 11 Dec 2018 15:16:13 -0800
In-Reply-To: <20181211230308.66276-1-dennis@kernel.org>
References: <20181211230308.66276-1-dennis@kernel.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-12-11 at 18:03 -0500, Dennis Zhou wrote:
+AD4 diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
+AD4 index 6bd0619a7d6e..c30661ddc873 100644
+AD4 --- a/block/blk-cgroup.c
+AD4 +-+-+- b/block/blk-cgroup.c
+AD4 +AEAAQA -202,6 +-202,12 +AEAAQA static struct blkcg+AF8-gq +ACo-blkg+AF8-create(struct blkcg +ACo-blkcg,
+AD4  	WARN+AF8-ON+AF8-ONCE(+ACE-rcu+AF8-read+AF8-lock+AF8-held())+ADs
+AD4  	lockdep+AF8-assert+AF8-held(+ACY-q-+AD4-queue+AF8-lock)+ADs
+AD4  
+AD4 +-	/+ACo request+AF8-queue is dying, do not create/recreate a blkg +ACo-/
+AD4 +-	if (blk+AF8-queue+AF8-dying(q)) +AHs
+AD4 +-		ret +AD0 -ENODEV+ADs
+AD4 +-		goto err+AF8-free+AF8-blkg+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4  	/+ACo blkg holds a reference to blkcg +ACo-/
+AD4  	if (+ACE-css+AF8-tryget+AF8-online(+ACY-blkcg-+AD4-css)) +AHs
+AD4  		ret +AD0 -ENODEV+ADs

What prevents that the queue state changes after blk+AF8-queue+AF8-dying() has returned
and before blkg+AF8-create() returns? Are you sure you don't need to protect this
code with a blk+AF8-queue+AF8-enter() / blk+AF8-queue+AF8-exit() pair?

Bart.
