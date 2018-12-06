Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EFBC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E040920838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E040920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLFQGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:06:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38650 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQGU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:06:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so389897pfi.5
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svpvzU/dbLSFtbp42nmU8G9XdKDKMDMv/6tlX9uxHLA=;
        b=Binx6m2Qr+VJnzCEmQnyYlnbiedbrYoDxoHU5Tszyagd8TBQal1mvnH9gdvFR+85Ko
         6/T4cFwp+7coMnbW9AzK05vOTjCyFBdfxVLhkz4/l1auFrEJ8EMf+U7btJtpA4m2B4Bt
         HfRXQ8lSdvvNxOGCthbcochj1b74aYKRTIhw6QloEKrutH8cFUcsFcBhLDnut1CU3xMm
         lymSVNbCOc7fj7qf23bqME+OkzT0p5j++oqa8LcKY+Zltk1z1GK99nBZvhOU3w585Ql3
         UAlcuJZqRfbeafyAqkKrRqgtno34copq7+j7T6OkP3IqXKBg+J9Bit5BvxKq3slpTIo1
         LU5Q==
X-Gm-Message-State: AA+aEWbEK+coRkxkm7B7T0eY6tXg/tN/YaM769CEFW89Wefma/wwst8K
        upyZxegFMSRCoUUQprHYf50=
X-Google-Smtp-Source: AFSGD/Xa6IAO3iEIFE2HGZAgoW8+hHyZLMKykhk1sdGhDXWQ8Li5RGq9VYXUoRj3UY8b6r7Kz3KDYQ==
X-Received: by 2002:a62:399b:: with SMTP id u27mr30128548pfj.181.1544112379142;
        Thu, 06 Dec 2018 08:06:19 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g190sm1076614pgc.28.2018.12.06.08.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:06:17 -0800 (PST)
Message-ID: <1544112376.185366.230.camel@acm.org>
Subject: Re: [PATCH v3] block: add documentation for io_timeout
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zwp10758@gmail.com>, hch@infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Date:   Thu, 06 Dec 2018 08:06:16 -0800
In-Reply-To: <CAA70yB7rD_vqMXUvHrQ8SwH-jAyDZeL58TkqABqJ0Y=-p_pjyg@mail.gmail.com>
References: <20181205141701.GA33910@192.168.3.9>
         <20181205144006.GA18123@infradead.org>
         <CAA70yB5WQPYzptck=miwiBrV7=uixvLKpJrzGEOP9zBU5Y2CwQ@mail.gmail.com>
         <CAA70yB7rD_vqMXUvHrQ8SwH-jAyDZeL58TkqABqJ0Y=-p_pjyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-12-05 at 22:59 +-0800, Weiping Zhang wrote:
+AD4 Weiping Zhang +ADw-zwp10758+AEA-gmail.com+AD4 +To4-2018+XnQ-12+Zwg-5+ZeVUaE4J +TgtTSA-10:49+UZmQU/8a
+AD4 +AD4 Christoph Hellwig +ADw-hch+AEA-infradead.org+AD4 +To4-2018+XnQ-12+Zwg-5+ZeVUaE4J +TgtTSA-10:40+UZmQU/8a
+AD4 +AD4 +AD4 Can you please also send a patch to not show this attribute for
+AD4 +AD4 +AD4 drivers without a timeout handler?  Thanks+ACE
+AD4 
+AD4 Is there a simple way do that ?

How about checking the timeout member of struct blk+AF8-mq+AF8-ops for blk-mq and
checking the rq+AF8-timed+AF8-out+AF8-fn member in struct request+AF8-queue for the legacy
block layer?

+AD4 Shall we return -ENOTSUPP when user read/write this attribute when
+AD4 driver has no timeout handler ?

A much more elegant solution is to introduce a sysfs attribute group for the
io+AF8-timeout attribute and to make that group visible only if a timeout handler
has been defined. See e.g. disk+AF8-attr+AF8-group in block/genhd.c for an example.

Bart.
