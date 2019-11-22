Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04060C432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 15:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C421520706
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 15:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZRCDH9hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKVPhN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:37:13 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41854 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVPhN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 10:37:13 -0500
Received: by mail-io1-f68.google.com with SMTP id z26so4946159iot.8
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2019 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=E6O8mN42OUdCkFOFD8wO9m8Mf8sTsDft/Xamt2K8+qU=;
        b=ZRCDH9hONcjsVeo0iwCyU/c5dWKwY/FDgbwE+zbMKzVt6E+SRHRtUVCnKL69eNlaq9
         bNZzXrTYpryo/OQlJLpHA28r6Xt/WbjvHWS5hkSsqNQwTix5AdIOuCLvPDnzgPBJQRvu
         8nKGVj8P5YqnKDHl+PyVne3RC3SgxDb+PDww/LzizY1ZeGJyWy9Ma015hnBrX+uHOESo
         ov2MS0y4/sTyBnAZA5Ly5cN6iCbyrMy5Da+b9nbdIolJG62xfv9gEthVN+uxYE3kwo56
         gi1hDqQeL7yfeNLN96zaBZ4su28JG/W9bVtTp+OqnLrdxSKaRtPLlWBWGVvEVMEPpZRO
         WpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=E6O8mN42OUdCkFOFD8wO9m8Mf8sTsDft/Xamt2K8+qU=;
        b=a3VhJgZjeKjrAB1bcqgqT3tR5vC7JjL05+G0R7I9h1mlAq1yHXl5FoDD1BlHrhQx/Y
         H45vLeA+rpOvUvCRM8pQ8Qs1zY0R3LVCOK37ebdrqpApf97ERw9186VqK/df3YxBwqma
         gWMH4/mf7P9ltpvRWN1zwPHRe3WMqYryd3KpA25DpfMq83gRUb0gfwuhsww1k72JtZxb
         euQW8gIHF9/JHhaD88EAUcrrhfhkT60N6i3O0SKw4qMeCKWK14DbVA2ZUyb5wB0SZswV
         u1IwgjSxmzRBS8axefYfxsDd3MMwjJB4SZED2WOnVKEZpW0YoVKOmkPJN9e68sRGeUnH
         auyg==
X-Gm-Message-State: APjAAAUntAN7fjqb/4mZFZHjE0yFK6SUeJPtEqMOv0iskyueugiHIHYw
        I9LML2I8CF4HV5jN6sqwYz1execBeZcYjg==
X-Google-Smtp-Source: APXvYqyk2s9icu8PUnb2aVAf41VlKiOEWBREnHe08j9P+ko9xztcTdwgVDwgNEKPpbXwPgt19USeAg==
X-Received: by 2002:a6b:b458:: with SMTP id d85mr13637967iof.287.1574437029926;
        Fri, 22 Nov 2019 07:37:09 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c5sm2336187ioc.26.2019.11.22.07.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 07:37:09 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Post pull for block drivers
Message-ID: <3b9c21af-321a-535c-1192-08fe3961230d@kernel.dk>
Date:   Fri, 22 Nov 2019 08:37:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a drivers-post branch that follows for-5.5/block and for-5.5/drivers,
done to avoid conflicts with the zoned changes. The main zoned changes
are coming in the next pull request. This pull request contains:

- Prepare SCSI sd for zone open/close/finish support

- Small NVMe pull request
	- hwmon support (Akinobu)
	- Add new co-maintainer (Christoph)
	- Work-around for a discard issue on non-conformant drives
	  (Eduard)

- Small nbd leak fix

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.5/drivers-post-20191122


----------------------------------------------------------------
Ajay Joshi (1):
      scsi: sd_zbc: add zone open, close, and finish support

Akinobu Mita (2):
      nvme: hwmon: provide temperature min and max values for each sensor
      nvme: hwmon: add quirk to avoid changing temperature threshold

Christoph Hellwig (1):
      nvmet: add another maintainer

Eduard Hasenleithner (1):
      nvme: Discard workaround for non-conformant devices

Guenter Roeck (1):
      nvme: Add hardware monitoring support

Jens Axboe (1):
      Merge branch 'nvme-5.5' of git://git.infradead.org/nvme into for-5.5/drivers-post

Navid Emamdoost (1):
      nbd: prevent memory leak

 MAINTAINERS                |   1 +
 drivers/block/nbd.c        |   5 +-
 drivers/nvme/host/Kconfig  |  10 ++
 drivers/nvme/host/Makefile |   1 +
 drivers/nvme/host/core.c   |  18 +++-
 drivers/nvme/host/hwmon.c  | 259 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |  13 +++
 drivers/nvme/host/pci.c    |   3 +-
 drivers/scsi/sd.c          |  15 ++-
 drivers/scsi/sd.h          |   8 +-
 drivers/scsi/sd_zbc.c      |  22 ++--
 include/linux/nvme.h       |   6 ++
 12 files changed, 341 insertions(+), 20 deletions(-)
 create mode 100644 drivers/nvme/host/hwmon.c

-- 
Jens Axboe

