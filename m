Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6703C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 04:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FE2218F0
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 04:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fN27Qq4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbeLUEFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 23:05:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35660 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbeLUEFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 23:05:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so1879963plo.2
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 20:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0TctYLhtIiIb4/zmSeT+YIH7pbwBULpuOw6CxdKt/HE=;
        b=fN27Qq4T/ti9dW7qWTBbEo0q0ZScJy0NrCtpjNCfr7baiC1uHBRXFHs8uDJUOZzwY6
         CeOGBORgo+6iyazs3W0O1tQiv6mkI+lbGZfJ2KQcLI5ncEQfLSEfhmeWXJdbXvIKcVze
         DqdoCJYcEJzZe+TAs46+L4KM0cywG3nBMigGZjZwOYHBc5fX6g28gcv5sYUapeQpJhP/
         NCKPp2KiCmceO7aW0tVMc+0hNYLwoPgJiYr4OlJKftfUPtVV0rh8n9G7Yy1tRM5DdpKt
         zCfSuZCBBZp8Y5yI1KYvJrEVHN6g9PPw0bUGG/I71nIbz7dAS4/okN3xpzgOWx3IWKQr
         VnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0TctYLhtIiIb4/zmSeT+YIH7pbwBULpuOw6CxdKt/HE=;
        b=RDpEkDYKn5muWeYIlJt+XgE2Bgx9WzoMTIgY8u5c7hRlsBHc+wDHH1kEJfyqDGbyWE
         t/f1sb+r4jPLx+LTB60h5a30/wo1dQRfxgFg4aobYe4PKdT4HmOj5kCAzRK1HLs2XgSK
         cxCpb+OrVZBSg4EG9yxpoaZEARct5jPZ/e+TDPlEYQJQUS5IGGwiCiF2AII6vZybysO8
         xbGI/8+4732OdxqdOFHXTIzYC+mNwDZHaz9EcVQoqcOY5DaDVu2MiSUo36IJdhv1QqS8
         HRuaGbFtQ4Gch78yGBYxm2VE8TjV/AMpn+uCyHO0I4O6NAHOWe2vWtrBJBEqKJltA9YB
         KDRQ==
X-Gm-Message-State: AJcUukfGn08Rl/VUiTvYhhV6LKy97HudYJRl6QFMucI7DYe7eLdUXWKX
        orHLcZxLArtT48+cogqzLXbj0g==
X-Google-Smtp-Source: ALg8bN7St5qqugGfI9wp6ys5DMXpebxr9ZD6k4WDjYKllRloKRM6/GKVZYiiHSoHOC0pQ9drPnxwDg==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr934098plt.157.1545365100899;
        Thu, 20 Dec 2018 20:05:00 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v190sm31566285pfv.26.2018.12.20.20.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 20:05:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 4.21-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>
Message-ID: <bdc8749a-b777-6e2b-9a8b-f2b1a3e73e12@kernel.dk>
Date:   Thu, 20 Dec 2018 21:04:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the libata changes for this merge window. Nothing major in
here. This pull request contains:

- GPIO descriptor conversions (Linus)

- rcar deferred probing fix (Sergei)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-4.21/libata-20181221


----------------------------------------------------------------
Linus Walleij (5):
      ata: pxa: Drop <linux/gpio.h> include
      ata: sata_highbank: Convert to use GPIO descriptors
      ata: rb532_cf: Convert to use GPIO descriptors
      ata: palmld: Convert to GPIO descriptors
      ata: palmld: Introduce state container

Sergei Shtylyov (1):
      sata_rcar: fix deferred probing

 arch/arm/mach-pxa/palm27x.h             |  2 +
 arch/arm/mach-pxa/palmld.c              | 12 +++++
 arch/mips/include/asm/mach-rc32434/rb.h |  6 ---
 arch/mips/rb532/devices.c               | 12 +++--
 drivers/ata/pata_palmld.c               | 83 +++++++++++++++++----------------
 drivers/ata/pata_pxa.c                  |  1 -
 drivers/ata/pata_rb532_cf.c             | 45 ++++--------------
 drivers/ata/sata_highbank.c             | 37 +++++++--------
 drivers/ata/sata_rcar.c                 |  4 +-
 9 files changed, 97 insertions(+), 105 deletions(-)

-- 
Jens Axboe

