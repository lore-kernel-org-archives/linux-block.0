Return-Path: <SRS0=8cuF=4K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2721C35671
	for <linux-block@archiver.kernel.org>; Sat, 22 Feb 2020 17:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B126C20707
	for <linux-block@archiver.kernel.org>; Sat, 22 Feb 2020 17:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YVAx23Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgBVRCK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:02:10 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:37048 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBVRCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Feb 2020 12:02:09 -0500
Received: by mail-pg1-f170.google.com with SMTP id z12so2673493pgl.4
        for <linux-block@vger.kernel.org>; Sat, 22 Feb 2020 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9bdfrL8vgJJE6beT0eW24qljrk/mrGGcMm61WERVUEc=;
        b=YVAx23Jtk6he8xTbTGwVzZjsu3/5+hEBRHpiTFnGyhk0I5BNDNFAGj7ixUtykcImfT
         b1iTpE5UBJ3DDBUwzf2ZJhBPuW2X4DIvJvL7pjAssdO4fY2V+usxDVfSh/hJPJHW0U/Q
         ZqT+oOOHCyw5uwq4Yi/NRA77+NXOHiGdBBs71vBCFqDueAvc+mdw4BVN8KqO7lb7O2ov
         vq2u9eG1MRo0527lvM8CKLIwykFF522EAAlQQd2O7ivpc7fwEJNJqFlTMRgNHAGDDkBe
         k4VuhDO6JYo979r8EHdJUKULHrUTFxbIQRB/kVyKGz+c94WWLXCAk1lZAxxVBcjHHe0R
         eqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9bdfrL8vgJJE6beT0eW24qljrk/mrGGcMm61WERVUEc=;
        b=O+muAPBiNj2Oqe2hPsHxqHwvOPL3YwlmGLqfguMVTqyIUR0LD2wBWzjwbbPuBGEV8t
         NPxa4mnMLGpXq6PhRuhDNfowX/K9xt1z1CyMtFUySOMaknMyzgYR+FM4ZB9tPy0+AMeG
         QBB/ujnkoww8/YRMfFI42HNc5JQDzKk+lqCUxU26mclnlkwf+NZksyhNh+bFmv8Nn+Kf
         YLUcFQ/+V1LBDnbLWyhqrfjyBgSV16vLbDHTW5r58ENUlTaUvmuzXnEmE5PXwPeKnI8L
         sx4W7O0X3D/6R1AEo94lrY/hm6HkLitPveqIuF2NtdvZNko/F4vFN/k/pPGN1Hj9wPUM
         2Yiw==
X-Gm-Message-State: APjAAAVw8v4hKrthSkT1plQ+wGuRUAauJG1FtRQmBWFQpJ84vD//HKQH
        1Q9oyINOw2Pq/v8VGYyNQ70pQTmLnBI=
X-Google-Smtp-Source: APXvYqxsTZN7uoIUgZl+hw52kjC6oqk+H77lowOm7OWPP6srqhRJ6EzmFVv9hMzcS9vgQsDIS7M+Ng==
X-Received: by 2002:a62:4e42:: with SMTP id c63mr43483047pfb.86.1582390928889;
        Sat, 22 Feb 2020 09:02:08 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:a99e:da38:67d8:36ae? ([2605:e000:100e:8c61:a99e:da38:67d8:36ae])
        by smtp.gmail.com with ESMTPSA id g13sm6373084pgh.82.2020.02.22.09.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 09:02:08 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.6-rc3
Message-ID: <6afcdd61-2d0c-3059-4baf-4814c26c5885@kernel.dk>
Date:   Sat, 22 Feb 2020 09:02:06 -0800
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

Just a set of NVMe fixes via Keith, please pull!


  git://git.kernel.dk/linux-block.git block-5.6-2020-02-22


----------------------------------------------------------------
Andy Shevchenko (1):
      nvme-pci: Use single IRQ vector for old Apple models

Jens Axboe (1):
      Merge branch 'nvme-5.6-rc3' of git://git.infradead.org/nvme into block-5.6

Keith Busch (1):
      nvme: Fix uninitialized-variable warning

Logan Gunthorpe (1):
      nvme-multipath: Fix memory leak with ana_log_buf

Shyjumon N (1):
      nvme/pci: Add sleep quirk for Samsung and Toshiba drives

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/host/pci.c       | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
Jens Axboe

