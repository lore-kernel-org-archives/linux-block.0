Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93CC433F5
	for <linux-block@archiver.kernel.org>; Sat, 23 Apr 2022 02:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiDWCVG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Apr 2022 22:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiDWCVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Apr 2022 22:21:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D096DF87
        for <linux-block@vger.kernel.org>; Fri, 22 Apr 2022 19:18:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c23so14667718plo.0
        for <linux-block@vger.kernel.org>; Fri, 22 Apr 2022 19:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=PYOSS5/DJvDqR+/P87jn0dmO+rmmGkHzFGUlm0Aw058=;
        b=CrTXwNpHOgVqTotWKVo4GFRnRCw8E1J/ruLoaylygrhew1bAXAjn1g3Lz25/JmFJvS
         heeb+enrElQGMMC5EPFr4YZLhBW9BMmdzHorjUQNnaCxyVjxujcMwV9kXg/vW9VMqEr7
         Nq0+mnTfd3aLkJlmm8DJn04RpophguVqBAuMKuNm9St8Qy2XVXGNHUpxO/QPveIkSacd
         gi6TuvrfHCwHcpwiUt6a50VrGTEKj9lIfQzA0f1M+PjeiLD7q11J8nlKqbl5qvk3I4Oo
         ZX7xZHOAvoP9sZSsPdf+VddFxTY8bFXjZk1L8xq0RipT+zgQp521JJsPbdA6LojZIxIn
         6qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=PYOSS5/DJvDqR+/P87jn0dmO+rmmGkHzFGUlm0Aw058=;
        b=Dj08bNVzc/rYerpFJFFOS6uTk5tzjmyWNEsUeLagLBMKLOLlTVWZ0xSZsyezxrjCVq
         E9WBcVT3JryKb5BkrmCrVaDJPexdJ21g2P5qCLj5bULLwxyI8nSCJrpihuaQPyBZ2Ftx
         lpR6iao7wjY6BUD5ucOp5f6CrA0TuJiPE69+B4jlcl3T4gXmxOJVYBoUrrcNwg7dT2qx
         DJ5BOu+YRDACZgVLj5knytfI6wBTiL5pTbCbWThzzmWTtfSoRn11OYB632RamZTuM8Xz
         fEeEXoCV8z6ypjBTsGc22PXctHV9lYy3xcWj1Q9U+hckx9yrJ/fvvO4JlAPqejL5EdBJ
         T+MA==
X-Gm-Message-State: AOAM532x/aG9JHKQvQZyxPInUmvU/QtdhDuKaPcUH/GgyFE/YDscU2Sy
        3CnU+CuJXA/eVB+pT+5kS3hoFH9n+kIiXzej
X-Google-Smtp-Source: ABdhPJwzkTRDHzZVXIkFQEoZ6vonPOmzYH5Fpo3CP7bs/d6/owiJWynnm/rIyDAXyN0a81upE5do3g==
X-Received: by 2002:a17:902:8ec2:b0:156:9d2c:9ec5 with SMTP id x2-20020a1709028ec200b001569d2c9ec5mr7301839plo.170.1650680289622;
        Fri, 22 Apr 2022 19:18:09 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0010d500b004fd9ee64134sm3833598pfu.74.2022.04.22.19.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 19:18:09 -0700 (PDT)
Message-ID: <1dbe8c29-19a6-d03f-e693-502080707680@kernel.dk>
Date:   Fri, 22 Apr 2022 20:18:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.18-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just two small regression fixes for bcache. Please pull!


The following changes since commit 89a2ee91edd9c555c59e4d38dc54b99141632cc2:

  Merge tag 'nvme-5.18-2022-04-15' of git://git.infradead.org/nvme into block-5.18 (2022-04-15 06:33:49 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-22

for you to fetch changes up to 9dca4168a37c9cfe182f077f0d2289292e9e3656:

  bcache: fix wrong bdev parameter when calling bio_alloc_clone() in do_bio_hook() (2022-04-19 11:28:17 -0600)

----------------------------------------------------------------
block-5.18-2022-04-22

----------------------------------------------------------------
Coly Li (2):
      bcache: put bch_bio_map() back to correct location in journal_write_unlocked()
      bcache: fix wrong bdev parameter when calling bio_alloc_clone() in do_bio_hook()

 drivers/md/bcache/journal.c | 2 +-
 drivers/md/bcache/request.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Jens Axboe

