Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851D5C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A99217D8
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 15:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ySupV0P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeLTPzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:55:20 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:46883 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeLTPzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 10:55:20 -0500
Received: by mail-io1-f43.google.com with SMTP id v10so1154266ios.13
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 07:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=X8uJO2jfOP1Ad1Koz47V99zCYkrogc5u9GgoJ5x7Ry0=;
        b=ySupV0P8bCiB2bDSzc0e73bZhDHpjoCUjVNParMxTD9J6tbqL2n1mM8420jKwcCwk0
         D3Q2Q2CoTqRdZHTO899nQmhvPpzDM09xJMn68IkmI+fIX1wE/D6u1kwv3FSwFSB8cxfp
         bztiucFveCHdC8ez4PEhxcXuCMsnT3fjEIZ1Sxvlmh1fuGKOQsrGtHlkR5AGV19Br0qQ
         HyR85wzC3/wG9N3TV4pzrsnKYibPXndYD7jCeXo3gT4gMdvOBcc/TQP6deV0/98YIHCf
         a2ZJzskddlPhStsoIrmuaFyB3V38oemhqn90p7Xe58+Xnkxoi5EwE4LzB7NfwfzZrp1y
         895g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X8uJO2jfOP1Ad1Koz47V99zCYkrogc5u9GgoJ5x7Ry0=;
        b=QM867DDLkog5jqqeh/A0LQ+5Enn9Qxfuwd1j1krM6ILi/0UIW+S6a2V0V73rI0GsIR
         d0pL5gk2FW081qpA77E4a3ZWeRr0wzN73mV6hwiBn18RaP0CyEyfC3wNfIRoDL6W2rOA
         0eCh8TCbGI2pNzOJQUumoRHCsGxza4szWEjig/NAzTSm4NqibPp7+B8mgnAHSvsO8pOd
         g+VcymK5SBSA4xcBVo8ynemPg37lexgaB1sKFe2eHSGZXHtQFzwWiWDjy2+q9KOBXizF
         GiGBRGdNcbdPaGY5mOnqS76DTBxd3o2bqlsfEn1giIItCfYopo7hQwG2Cn5rAyCdG2KM
         AwiQ==
X-Gm-Message-State: AA+aEWYdeJIj31I2VKGt7PSHKsQ9fPGUtcrzZuUQSaqPV27YYM4xGIG/
        ht7FP6uYcQ5arsjGhQjdnAbTekwnpNgQxw==
X-Google-Smtp-Source: AFSGD/Vr9EL371+PPK38k9I+ViazAm6RIOtGHRLLFd/DN6TUftgjCFeS7ksUxXwKUNpCwMv6blJ9sA==
X-Received: by 2002:a6b:8d11:: with SMTP id p17mr21786007iod.74.1545321319306;
        Thu, 20 Dec 2018 07:55:19 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 18sm4987896itk.28.2018.12.20.07.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 07:55:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     ming.lei@redhat.com, osandov@osandov.com
Subject: [PATCHSET] Fix kyber hang
Date:   Thu, 20 Dec 2018 08:55:13 -0700
Message-Id: <20181220155515.31202-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

First one adds the necessary sbitmap helpers for users to be able to
do add_wait_queue() and list_del(wait_entry) type operations, and
still work with the optimized wakeup checking.

Second one converts kyber to use it, fixing a hang with domain tokens.

-- 
Jens Axboe


