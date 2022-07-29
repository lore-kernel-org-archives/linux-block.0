Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB96C00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 22:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiG2WfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiG2WfM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 18:35:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A15F3E
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 15:35:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p1so5745396plr.11
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=S2SxImh8nmzgynjRxs9Hj0qEs9mHw/iuVu7P8Hw6agE=;
        b=nnSIdsrZEY5XtvelL221pcS4t4+FKhnKQ2cR91Cv8eiMEE+y6X21080Nxce7GCxVwn
         KJyn60GnyItlocy3Afrp+Zz3Iq5RuQrsetrS0E6wfLzNBxHSlPtaLhOCuN9W8/I13wQ5
         xbnv5hq3DVZUcjbq4cKEnX0gRCBWzPtgddbQDAA2OZeHdI0w81ajJVQDAXKLo2L9Waxo
         xhaosL9+ZsMSs44+EiBePcYbbRLS3thW3xEAfgIbezXX6amP8+RdMUDlgIZcvtV2IJPa
         n+NMp3Az5EjvK9lybVg0IMrgkFdLaRNOLdsfCijx1v6IxnnlL2bSZleHE6JW4jZwNeJq
         abJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=S2SxImh8nmzgynjRxs9Hj0qEs9mHw/iuVu7P8Hw6agE=;
        b=fvvXBbvNNnBDmcc7GXfHcZin1APEiENBIUj17GvWqbrLO4rp3yMR6PSKaKrEZIf0u9
         +n07Tj/Wtkbd5JsVKcytkblF3LG3s1GhEJszpASXCKVtP4DBLRIhx9trz6W3IHCwFneW
         Pf8kLBqGaoN4Aj4JFrfpayS4wolAOuqSlP2JPBp/hkE0AvAdMcn8/FwAxVU9kQD5YELq
         euqKYzSPsBpx4OAn5danoZUjbSsN13u49FZ7jvFLgOg9vMQ3CjVrzKZEO2YmcisTiyI3
         WEAEyAfS02LNoqs9u5fdhLIfX2xc+lxqKb64/2VgTE5S6LwwVs+uxU5zp4Oak+iTN74a
         pI7w==
X-Gm-Message-State: ACgBeo1Ffla+JDAcUMdRv0YCgqYLTYaXMne/7JmhW1wrE6QBTiuLKhql
        DA7AJPgdjxDrqvZ56H4h6FKbf6gcwa7TrA==
X-Google-Smtp-Source: AA6agR6HAMuq5KGtkMQadhtkjep9eQyqEIJJ7CpVnfIK+yqMf9joOIYNWzRTMepwGZHqzG9AM4kwMA==
X-Received: by 2002:a17:903:1245:b0:16c:ece7:f6f1 with SMTP id u5-20020a170903124500b0016cece7f6f1mr5970964plh.169.1659134108807;
        Fri, 29 Jul 2022 15:35:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 200-20020a6304d1000000b004126fc7c986sm3114309pge.13.2022.07.29.15.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 15:35:08 -0700 (PDT)
Message-ID: <284e0073-acb8-ba91-a714-0df18187c5be@kernel.dk>
Date:   Fri, 29 Jul 2022 16:35:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.19-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for NVMe, yet another quirk addition. Please pull!


The following changes since commit 82e094f7bd988c02df27f8c8d81af8f750660b2a:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.19 (2022-07-19 12:42:33 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-29

for you to fetch changes up to eda3953b6a805d6df87a4c51058493ec88bfc622:

  Merge tag 'nvme-5.19-2022-07-27' of git://git.infradead.org/nvme into block-5.19 (2022-07-27 10:03:40 -0600)

----------------------------------------------------------------
block-5.19-2022-07-29

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-5.19-2022-07-27' of git://git.infradead.org/nvme into block-5.19

Tobias Gruetzmacher (1):
      nvme-pci: Crucial P2 has bogus namespace ids

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Jens Axboe

