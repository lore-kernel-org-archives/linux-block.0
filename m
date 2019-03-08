Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C40C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A530F20661
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfCHSPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:15:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32862 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfCHSP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 13:15:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id h11so14764419pgl.0
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 10:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bpHVuv2Mlzgzjla7S6bJY6DDhJM1V/RMBpm+CChLwY=;
        b=kA24xoy6RSWisDCzZUWWQyWT4jrCYA4yOtwo0xR+LpTyODYMr3e4I1Wb/tvW7g1RFW
         T17JsNAu4ycxZQjXJgaj05PHYSDHkDDg+M7/oJ4xpqdJMCouq3p0oswnt0tMIn3J9L94
         A8VGrb1e7MW0zRMMUr85PWHCdiDp/2SF9pWGvfdxjHVASLPgkf64JtqoJlcaDCuD2UL5
         OClIG2Ytegek1ePb2U+8NOA4ZEfu/AQ52XWCMYB9FxrA2fdnJ+sBgM6TGA2aWEFNUj/B
         xK/Cc+EbwL+zwJ5auRcGlhKSE/9PXdwtvAugZ+UPCZl1idLSxcfStCzaFFFQZyZHB6v3
         DBSA==
X-Gm-Message-State: APjAAAXJnkMZDMNPXfUBUxk5bemGI88I4idbcEuW8eLr111UMMyYw+xy
        ygDOlRVVXfcl2VB/0TQ5Tk0=
X-Google-Smtp-Source: APXvYqxkymhySgQoUUVYcRoRVEpiqPFuYvzdLxf4+BJHMRlchG0XA63nfiJBc3D4kwpmG+KqC0WzJw==
X-Received: by 2002:a62:76d4:: with SMTP id r203mr20009886pfc.15.1552068929185;
        Fri, 08 Mar 2019 10:15:29 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h184sm24671287pfc.78.2019.03.08.10.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:15:28 -0800 (PST)
Message-ID: <1552068927.45180.30.camel@acm.org>
Subject: Re: [PATCH 4/5] nvme: Fail dead namespace's entered requests
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Date:   Fri, 08 Mar 2019 10:15:27 -0800
In-Reply-To: <20190308174006.5032-4-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
         <20190308174006.5032-4-keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-08 at 10:40 -0700, Keith Busch wrote:
+AD4 End the entered requests on a quieced queue directly rather than flush
+AD4 them through the low level driver's queue+AF8-rq().
+AD4 
+AD4 Signed-off-by: Keith Busch +ADw-keith.busch+AEA-intel.com+AD4
+AD4 ---
+AD4  drivers/nvme/host/core.c +AHw 10 +-+-+-+-+-+-+-+---
+AD4  1 file changed, 8 insertions(+-), 2 deletions(-)
+AD4 
+AD4 diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
+AD4 index cc5d9a83d5af..7095406bb293 100644
+AD4 --- a/drivers/nvme/host/core.c
+AD4 +-+-+- b/drivers/nvme/host/core.c
+AD4 +AEAAQA -94,6 +-94,13 +AEAAQA static void nvme+AF8-put+AF8-subsystem(struct nvme+AF8-subsystem +ACo-subsys)+ADs
+AD4  static void nvme+AF8-remove+AF8-invalid+AF8-namespaces(struct nvme+AF8-ctrl +ACo-ctrl,
+AD4  					   unsigned nsid)+ADs
+AD4  
+AD4 +-static bool nvme+AF8-fail+AF8-request(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx, struct request +ACo-req,
+AD4 +-			      void +ACo-data, bool reserved)
+AD4 +-+AHs
+AD4 +-	blk+AF8-mq+AF8-end+AF8-request(req, BLK+AF8-STS+AF8-IOERR)+ADs
+AD4 +-	return true+ADs
+AD4 +-+AH0

Calling blk+AF8-mq+AF8-end+AF8-request() from outside the .queue+AF8-rq() or .complete()
callback functions is wrong. Did you perhaps want to call
blk+AF8-mq+AF8-complete+AF8-request()?

Bart.
