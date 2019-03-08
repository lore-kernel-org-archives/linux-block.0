Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4EFC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F0620851
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfCHVyJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:54:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46428 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCHVyJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 16:54:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so15072222pfh.13
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 13:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uI8JgGDFZEfWJe4SicWq4bH5tGm8Yu2S9wB4edZEdy8=;
        b=heuScPH3XsnwMue4VUNgnI2ArdhFZSTS2MH30WmgcJ1ZOzaKFWD8aRhMRp2+VGKk7E
         nieDzDNgWK8OrxtOMeg3oZR9TkgYkr4pZ6zbvMCdwPId9kk1zB607jYrbj0tA/Er7aEd
         PLarQAaiqeTQHaH8xJX7YEh2yNfuj89PmUtltQLn9JUnd6HoD3VUr7Khe7YelDJSO75A
         1gqnGAf0qGm4Zae0Yeq+hNVY8V6CYJFpYlqXcmBg4l1IJGb3/ao39vqPcidSJKgB74TE
         wZ4S8Bl+QLuxCpHSznbUskZWPmuP1x4ZFcOzsw29OJUiPJs0cDvLNMQtbMTR5CxRvgqI
         Z4kQ==
X-Gm-Message-State: APjAAAU/1necoEQQQOsnNJCUn23rbXAEHkMogLuxtMtXB9A8gX2oNTAd
        pRvvF3E3+UNFJuwyJ08pX28=
X-Google-Smtp-Source: APXvYqwj6u1XsWnvGbFFl9c0tbfpoh6D35epVVcGLOSfw2PpYmm5xzZaRDYU3qmXoVjdgpbQqulamQ==
X-Received: by 2002:a63:481d:: with SMTP id v29mr1018888pga.261.1552082047795;
        Fri, 08 Mar 2019 13:54:07 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v186sm21737567pfv.184.2019.03.08.13.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 13:54:07 -0800 (PST)
Message-ID: <1552082046.45180.91.camel@acm.org>
Subject: Re: [PATCH 4/5] nvme: Fail dead namespace's entered requests
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Fri, 08 Mar 2019 13:54:06 -0800
In-Reply-To: <20190308181905.GA5232@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
         <20190308174006.5032-4-keith.busch@intel.com>
         <1552068927.45180.30.camel@acm.org>
         <20190308181905.GA5232@localhost.localdomain>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-08 at 11:19 -0700, Keith Busch wrote:
+AD4 On Fri, Mar 08, 2019 at 10:15:27AM -0800, Bart Van Assche wrote:
+AD4 +AD4 On Fri, 2019-03-08 at 10:40 -0700, Keith Busch wrote:
+AD4 +AD4 +AD4 End the entered requests on a quieced queue directly rather than flush
+AD4 +AD4 +AD4 them through the low level driver's queue+AF8-rq().
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Signed-off-by: Keith Busch +ADw-keith.busch+AEA-intel.com+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4  drivers/nvme/host/core.c +AHw 10 +-+-+-+-+-+-+-+---
+AD4 +AD4 +AD4  1 file changed, 8 insertions(+-), 2 deletions(-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
+AD4 +AD4 +AD4 index cc5d9a83d5af..7095406bb293 100644
+AD4 +AD4 +AD4 --- a/drivers/nvme/host/core.c
+AD4 +AD4 +AD4 +-+-+- b/drivers/nvme/host/core.c
+AD4 +AD4 +AD4 +AEAAQA -94,6 +-94,13 +AEAAQA static void nvme+AF8-put+AF8-subsystem(struct nvme+AF8-subsystem +ACo-subsys)+ADs
+AD4 +AD4 +AD4  static void nvme+AF8-remove+AF8-invalid+AF8-namespaces(struct nvme+AF8-ctrl +ACo-ctrl,
+AD4 +AD4 +AD4  					   unsigned nsid)+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +-static bool nvme+AF8-fail+AF8-request(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx, struct request +ACo-req,
+AD4 +AD4 +AD4 +-			      void +ACo-data, bool reserved)
+AD4 +AD4 +AD4 +-+AHs
+AD4 +AD4 +AD4 +-	blk+AF8-mq+AF8-end+AF8-request(req, BLK+AF8-STS+AF8-IOERR)+ADs
+AD4 +AD4 +AD4 +-	return true+ADs
+AD4 +AD4 +AD4 +-+AH0
+AD4 +AD4 
+AD4 +AD4 Calling blk+AF8-mq+AF8-end+AF8-request() from outside the .queue+AF8-rq() or .complete()
+AD4 +AD4 callback functions is wrong. Did you perhaps want to call
+AD4 +AD4 blk+AF8-mq+AF8-complete+AF8-request()?
+AD4 
+AD4 This callback can only see requests in MQ+AF8-RQ+AF8-IDLE state, and
+AD4 bkl+AF8-mq+AF8-end+AF8-request() is the correct way to end those that never entered
+AD4 a driver's queue+AF8-rq().

Hi Keith,

What guarantees that nvme+AF8-fail+AF8-request() only sees requests in the idle state?
From block/blk-mq-tag.c:

/+ACoAKg
 +ACo blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter - iterate over all requests with a driver tag
 +ACo +AFs ... +AF0
 +ACo-/

Thanks,

Bart.
