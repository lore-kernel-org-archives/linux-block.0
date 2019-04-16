Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294ABC10F14
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2B220652
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfDPPAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:00:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35281 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbfDPPAj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 11:00:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so10485701plp.2;
        Tue, 16 Apr 2019 08:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzEbblBmSVEVYraSVJmAXHJjfIQS4JnfPJ5pABW9bwM=;
        b=MpMnHx1uPX3QbKmpn+4VaIY1oCOc6JN/A2pbqI4+lu4AV1eXCW2WIDlms7gtEyg3m3
         qyRx7AnMnEA9+0hqe2hGvh6jSRl1O1NFVQ0cISOnlwbSqoltnFUjOdYNQhz/pyPFCgs7
         BmTrqEmej1OoIfvkY9SCHR+n1YE2BMcjwGrCAamP03qqsM7h4rLePDIr1htX51Ic0u/s
         sv2JUsZuEEggcVJZYUqZhMptBm3sfTcSP6qyAFpRqLiYi1SQZSjKm8TiAu9TyhwCvsP/
         EVQfwLBrDTxv7lx+r9kky0mjNeBYuZNWPfitL9LdtSLJ+5wmnW48Clx1op4cviglpA9A
         UZZg==
X-Gm-Message-State: APjAAAXMBxIttr55eDXu2uV6GauXvJkTOSz+V5qxE9bkTxmmqhW3UjBn
        gwWU+y+lvotHLQPA7VaAP7o=
X-Google-Smtp-Source: APXvYqySzSzXOj0Lmriu7HG7Tij+Jv6tCo5HjivT6quvsGdRuy1XM1U7v9j5by0iBOoTZTx/2bx+WQ==
X-Received: by 2002:a17:902:7081:: with SMTP id z1mr83359372plk.252.1555426838881;
        Tue, 16 Apr 2019 08:00:38 -0700 (PDT)
Received: from [10.128.207.50] ([66.201.36.5])
        by smtp.gmail.com with ESMTPSA id l1sm59682001pgp.9.2019.04.16.08.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 08:00:37 -0700 (PDT)
Message-ID: <1555426836.35423.1.camel@acm.org>
Subject: Re: [PATCH v2 1/3] blk-mq.c: Add documention of function
 blk_mq_init_queue
From:   Bart Van Assche <bvanassche@acm.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com
Date:   Tue, 16 Apr 2019 08:00:36 -0700
In-Reply-To: <20190416032801.200694-1-marcos.souza.org@gmail.com>
References: <20190416032801.200694-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-16 at 00:27 -0300, Marcos Paulo de Souza wrote:
+AD4 Reviewed-by: Chaitanya Kulkarni +ADw-chaitanya.kulkarni+AEA-wdc.com+AD4
+AD4 Signed-off-by: Marcos Paulo de Souza +ADw-marcos.souza.org+AEA-gmail.com+AD4
+AD4 ---
+AD4 
+AD4  No changes from v1.
+AD4 
+AD4  block/blk-mq.c +AHw 9 +++++++++
+AD4  1 file changed, 9 insertions()

Please always include a cover letter with a patch series that gives an
overview of the purpose of the patch series.

Thanks,

Bart.
