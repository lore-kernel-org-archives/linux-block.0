Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF24C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FE1213F2
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfCVPg4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:36:56 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:39135 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 11:36:56 -0400
Received: by mail-pf1-f178.google.com with SMTP id i17so1788032pfo.6
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 08:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKSZ4+pqnZJ/O8a2pIjuLuFqQN2xjxc92GTtiGPMxBU=;
        b=U67b6reaWdeGu+ppTgCcmMfqI9IXYr4dFMh+ILSXpB+3JPEkAvvXpmHA7ZEVUaQOup
         RZDewMKtclSYZFbRR4nuxBeI/PEcvCaOzTiosii8svOoUloCZ2/i+7zqVu/i4BDNSBd0
         WFnRNeKAYqQv9EaG481f7PtVIYApPw3BgKRIpuxXv33XoViKaenENBRiJU4eYAPWKz12
         gJbdag6p78dkzFOR1/IdXx6wSeFx79hy7rv+cKiUkP/9RKgt0cKGqooV5wh1n8Xpj5fX
         hYahFVDwsb+DVJyeOpdEGXDzpOL1yU1O71h7koT3pM4uYZs7hMTFPubZZbmSUfwHNr7W
         zxew==
X-Gm-Message-State: APjAAAUyhg5EphJIk4j527ZoOW2b/r84F+CfJHRXKndNOIkF1NEDZ+dq
        P6dKNgAnp7C4IhnYvufoKVY=
X-Google-Smtp-Source: APXvYqxsuAxhbNIBpa047RB2mbInKSU6WLDiqsw1779OdEWiPu5//HpMXSO0cmbTyaZuXlcfPnFb+g==
X-Received: by 2002:a63:510a:: with SMTP id f10mr9539239pgb.327.1553269015053;
        Fri, 22 Mar 2019 08:36:55 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u4sm16081290pgn.12.2019.03.22.08.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 08:36:54 -0700 (PDT)
Message-ID: <1553269013.65329.147.camel@acm.org>
Subject: Re: Read data to kernel buffer by blkdev_read_iter
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ivan Safonov <insafonov@gmail.com>, linux-block@vger.kernel.org
Date:   Fri, 22 Mar 2019 08:36:53 -0700
In-Reply-To: <1a5a1b81-49c0-2817-73d9-d58716c44b0a@gmail.com>
References: <b6d54ac9-ee29-edcf-907d-1e12fce321ac@gmail.com>
         <98dec559-60bf-2463-7b0b-0cc2dd57db7d@acm.org>
         <1a5a1b81-49c0-2817-73d9-d58716c44b0a@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-22 at 17:57 +-0300, Ivan Safonov wrote:
+AD4 In the previous message I misled you: iov+AF8-iter has ITER+AF8-KVEC type only 
+AD4 if set+AF8-fs(get+AF8-ds()) present before iov+AF8-iter+AF8-init(). In this case 
+AD4 +AF8-without+AF8 IOCB+AF8-DIRECT blkdev+AF8-read+AF8-iter() work fine. With IOCB+AF8-DIRECT 
+AD4 blkdev+AF8-read+AF8-iter() return -EFAULT.

Have you tried to store a physical address in iov+AF8-base instead of a virtual
address?

Bart.
