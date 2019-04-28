Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4C8C43219
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 13:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9186620652
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 13:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fuks5tKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfD1NzH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 09:55:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38685 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfD1NzH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 09:55:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so3893588pgl.5
        for <linux-block@vger.kernel.org>; Sun, 28 Apr 2019 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=P1Z33zzLF8gYAAAOBRAHn3QQXFbFqwOCd40uaPGzWZA=;
        b=fuks5tKadXLX2DdYRAkpCkY0j8cFptq273gAjpEze06gDgH+OborWb4Cm60xKiea9F
         qS7XQxB6w5ToOGaQK7ppIHqPbwP4uyC30+RyuD8EvHgfrVfnW7Qh4CY09P2lXEcaltxa
         0f+ZRHKPlCXI3iw0wMjyaV7TRlYWodim8YdI9sNBN8KfwcLyRxa4dogrlPc9BZ7MVDcV
         v4AHGKc33aWiu1vBgoinRb5xx2CLVSqvSc+QTrs+A2sctBfqHzjcY+cAVq0hBbRp6ndo
         v9ICd8RBh2Z/b0hMRB+9nxHhn9ZfVWbimYnRY6Tz6g14+1dVKd26uhtxO7M0dxjEPJGG
         lfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=P1Z33zzLF8gYAAAOBRAHn3QQXFbFqwOCd40uaPGzWZA=;
        b=mxDIRv3sYDefSNGATjVzaOc/vEYEHlnok6N6N+i8Hkz3x3+t4p25/DVi8VJcFB0SPm
         LCYvgIICpe7i5GnAu+/QNwxMflfbnO0qxURKKM1I09i7MLgUS1eK6xVvuUGoBUVAn17g
         SWemO9KtuCwdZX622FRPFD2SqjlyIsevgShEIBKyQ8KoZLMnGMATcRQDAyw1wYMIXwcX
         pasdUMxI0446lfP5pzvt7qZ3m1xRYPAIy4UZiJnp+HnulKR06IoJgxTzp5Bd8ODthUlQ
         a+iW2KG+77HCfWeEY10CPurT8LPgnUefugQ0m0O8GsPEd1SRWMdqqv069SLe72IMGj0a
         2NbQ==
X-Gm-Message-State: APjAAAXQ1jNOEgOUkT8Axg9HppL3toy99XIOInsYE/XJlaIx8HGeidKG
        TDvpPQJ8v/Vmo+E5vpcK/y6VmQoynN9yzw==
X-Google-Smtp-Source: APXvYqzuIqhnkFIEqsbM9gqM3uvAWhyldalG1E+EGWI7ZT3PMM364WpGsEYqAIItRiE5nLTosMPNBw==
X-Received: by 2002:a63:2ad3:: with SMTP id q202mr35995852pgq.423.1556459706444;
        Sun, 28 Apr 2019 06:55:06 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 13sm44808150pfi.172.2019.04.28.06.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 06:55:05 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Storage fixes for 5.1-rc7
Message-ID: <32d1cc79-7db1-6017-9626-2eb1845dd9e0@kernel.dk>
Date:   Sun, 28 Apr 2019 07:55:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of io_uring fixes that should go into this release. In particular,
this pull request contains:

- The mutex lock vs ctx ref count fix (me)

- Removal of a dead variable (me)

- Two races fixes (Stefan)

- Ring head/tail condition fix for poll full SQ detection (Stefan)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190428


----------------------------------------------------------------
Jens Axboe (2):
      io_uring: fail io_uring_register(2) on a dying io_uring instance
      io_uring: remove 'state' argument from io_{read,write} path

Stefan Bühler (3):
      io_uring: fix race condition reading SQ entries
      io_uring: fix race condition when sq threads goes sleeping
      io_uring: fix poll full SQ detection

 fs/io_uring.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

-- 
Jens Axboe

