Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEFCC4321E
	for <linux-block@archiver.kernel.org>; Sun,  4 Dec 2022 15:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiLDPmO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Dec 2022 10:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLDPmN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Dec 2022 10:42:13 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F20E11175;
        Sun,  4 Dec 2022 07:42:12 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id n7so7036788wms.3;
        Sun, 04 Dec 2022 07:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :reply-to:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARJr/vQ/Knp4FhLBG/R5CG9hyKkb4Kf7wc8CtCdE9MA=;
        b=OdTvFkBOe2smg8eLEgGUrKf8uAot3y1J750clEheB+bhRL4XlV+6OtN9IOZicNVswS
         EmZvhfxfJ/Pfm7QJmQ6ul4t2w1uEKtYlY9+Zyg7ZLpSpKMAEQ+v+X1FUZzkoKJuzurlW
         cmi+ggbScdntpurIEwkJ1Tuvngyo/0Wan09IucYZGqeT6yiehOH3lV4g34sOMtti1UuE
         05EON0Kh/zfLd5I5wtyafkS3zT2siaZg0A18PHVoB7MqOy1kl9H+/kCzsgCKfeN6hMWn
         QtoL15Jhqe7jMkqeT46rj68a0azH+wutCLmzqKmbD8MHuHx95LfuuzFieFioOxiHPacA
         nBYQ==
X-Gm-Message-State: ANoB5plnOuoFXyvF6eiT5yzZQ829btm7aAGfobRb6QQ3oelBnZ84BP4o
        AGJlyMP4mJu50wAqmt63jqahJj0Ppz8=
X-Google-Smtp-Source: AA0mqf6E4NIoyZEUI5UzMZ/4uFr9cNIRBVcplhRTvgLrFrjXryAvJ17+72A0HoBTfD74xwp1mwkW2Q==
X-Received: by 2002:a1c:6a13:0:b0:3cf:7801:c780 with SMTP id f19-20020a1c6a13000000b003cf7801c780mr58335691wmc.29.1670168530698;
        Sun, 04 Dec 2022 07:42:10 -0800 (PST)
Received: from [192.168.1.243] ([5.30.201.27])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003cfa80443a0sm14927961wme.35.2022.12.04.07.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 07:42:10 -0800 (PST)
Message-ID: <805d7405-2e2f-ddda-8e17-97ac1934738c@linux.com>
Date:   Sun, 4 Dec 2022 19:42:07 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: efremov@linux.com
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
From:   Denis Efremov <efremov@linux.com>
Subject: [GIT PULL] Floppy changes for 6.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 85d6ce58e493ac8b7122e2fbe3f41b94d6ebdc11:

  block: remove devnode callback from struct block_device_operations (2022-12-03 09:19:48 -0700)

are available in the Git repository at:

  https://github.com/evdenis/linux-floppy tags/floppy-for-6.2

for you to fetch changes up to f8ace2e304c5dd8a7328db9cd2b8a4b1b98d83ec:

  floppy: Fix memory leak in do_floppy_init() (2022-12-04 18:03:41 +0400)

----------------------------------------------------------------
Floppy patch for 6.2

The patch from Yuan Can fixes a memory leak in floppy init code.

Signed-off-by: Denis Efremov <efremov@linux.com>

----------------------------------------------------------------
Yuan Can (1):
      floppy: Fix memory leak in do_floppy_init()

 drivers/block/floppy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
