Return-Path: <SRS0=o1BL=5G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76FFC4332B
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 18:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8216720714
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 18:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KVifl0TT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgCUSip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:38:45 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:34170 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgCUSio (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Mar 2020 14:38:44 -0400
Received: by mail-pl1-f176.google.com with SMTP id a23so3984982plm.1
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2020 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kiDy+sX8D3WKSgmbEaOZpU5jKw6XVf3S6CVgbq1TQvk=;
        b=KVifl0TTwUFDk5NDyj/CtXAIg/K5b9Rt3gIitTNwi9Nd2YXTp8DlNMWAHCSoTeJDmu
         yV/VI4TLg/EdRFvGvG4b/0SVFn9cLnqTamcAxhnypJvBy2XQ5qFXLhEXGNFX+UnRsti2
         vaquqGE4F46AXhOn/y7EmspGTCVZv4JKW3qAspG3BESvw+LviCAXc8I9QrNE+R9cwqug
         ENRGoWYR1njxja9xZ/5RYmMCPs7Wx3d/xuPBisMTnIWhD3Y6j5RXXsi1LEx+P+THXkVR
         MhaNAcfJ/yOWwCJYsUzBVbrpaW7zXnZLhxYCurwsjYfXaQ6WIyyB9jEQbrDcFRpKaFY9
         pXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kiDy+sX8D3WKSgmbEaOZpU5jKw6XVf3S6CVgbq1TQvk=;
        b=ipRp7bvtGwJ45F+yd7Lmh7qy/rTpSqBMI5jC7/CZzKtjBq+rUpsoP9O6uyoD7fO7m1
         vr5a25SSFiDGrQDjiIlHGDQQYANYlQdzuGf9ITRhMUaEO6X1GykZMR5HOSvuBxhfWwRG
         qHA5oqYwu+476shLZK3WeL4/9UmzlW3lCH8AABaSq6P/NM1DQH5Y9/ZZizneQqDcuMxW
         7GS7oiZVqybuj+T5skdITqQjiwuRKujNvFEh6TMmzNBfS2XcQvvGVywrAvKM+05kXVhx
         V/m9GbCZXv9ICMU2lapfFlENdlidYo5Gwimn87Qr5hE32uQKYc2gabe85E3TxIBCBQGt
         jv7A==
X-Gm-Message-State: ANhLgQ1I4cp847Z7HXccPYxDOD4w1VEY/yOgy6oCuFfT5fKc8GJO3PV1
        AMb/cZ0mKZeSmJjP4tdwPxPxyQ8FK7SDoA==
X-Google-Smtp-Source: ADFU+vt38EJ/Y1ZGCJPwmU9118OEVbjEuEkDUUcNRybZK5ZwDfS7Kbv31KxVZv07L2JYgTp/WdVQRw==
X-Received: by 2002:a17:902:ba08:: with SMTP id j8mr4324414pls.70.1584815922371;
        Sat, 21 Mar 2020 11:38:42 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i20sm1152658pfd.89.2020.03.21.11.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 11:38:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.6-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <9b5bff9b-0999-26c5-9ecb-3aacbe115bce@kernel.dk>
Date:   Sat, 21 Mar 2020 12:38:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just two NVMe fabrics fixes that should go into 5.6. Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.6-20200320


----------------------------------------------------------------
Jens Axboe (1):
      Merge branch 'nvme-5.6-rc6' of git://git.infradead.org/nvme into block-5.6

Prabhath Sajeepa (1):
      nvme-rdma: Avoid double freeing of async event data

Sagi Grimberg (1):
      nvmet-tcp: set MSG_MORE only if we actually have more to send

 drivers/nvme/host/rdma.c  |  8 +++++---
 drivers/nvme/target/tcp.c | 12 +++++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
Jens Axboe

