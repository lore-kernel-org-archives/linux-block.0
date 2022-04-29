Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E538C433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Apr 2022 18:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377885AbiD2SoV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Apr 2022 14:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380209AbiD2SoG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Apr 2022 14:44:06 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FA7CC504
        for <linux-block@vger.kernel.org>; Fri, 29 Apr 2022 11:40:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z26so10641826iot.8
        for <linux-block@vger.kernel.org>; Fri, 29 Apr 2022 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=QI07kVfm6DDJG41MtoM3AQ76DvoTV+TlN+pmFbS8na4=;
        b=6JJ6Lg38rFyepwWgo5IZEZTQBoB0q6BBGR544QYGUyFgrlyL4wy6sfl4wyqALLcEeH
         j29iWlA6Htsdr01dmjIaB01abZpNIVklVdqa4/7FTTGmS0WFvW2bhchfDNDZ+XHrm6/z
         aeVZHwCd+zulQ7IEDeFdTcnmm/fWS9oO3LrMHq/e1EQ/DfuNNukOPetB/MQ+O91Krtkt
         BlPdmpsRaz+d5ItKU+MKksWLaMpm8N6EO97X89Q09iOtNx9jmBT4M6Bim25fFiAc3/ci
         wVxcrgLox3qYDCKRMIuqEUMMIdX7Al4klSw0lW0qAwEFS1k/vWkO8KLZApNtGimCRDih
         0yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=QI07kVfm6DDJG41MtoM3AQ76DvoTV+TlN+pmFbS8na4=;
        b=XSwZAJozlUrGatgGWVOKAUwwuminQfAc5n3CmeyjzyDYxAiPdIclqg81Yi6pp3eVI7
         V0KSl7PHAvoMmAgRiQpZQii2QCDsBmFMCM/X1XrrXwrl9DEfPTuXXxyg1tZS4RZL6oaz
         Hst6Q8wh/uZ5HjqGU1lVfSXzMjE43SpUiMLnu8ljBZU3b4Kzwo5dayc5EbxtuT52aTY5
         HZRqr51rhgU8lZ8NRtJfhvaF7SycWkqGIYwKHZBTk3FlgiPfaIUvnDxWtE/soyXj2OL8
         o5Wu8/dJxNihsQQnu9xB8UKq5K43EtuW9LExaAk0HYTtwkqa5G7UVb20y5cLBfaW7g96
         5PEw==
X-Gm-Message-State: AOAM5316UHRjfboMrmOoNsHw9tfsyMqcW2W/u+VFnNY/EHJfxQQLGK0U
        Da/Ui+k6+xN2wuiuMpcmDvqKQzULo6y3Vw==
X-Google-Smtp-Source: ABdhPJzhhxY6OlmH28q2zxFgGrNm8I4XP+qbRUDI1F+n0S3G4DLmMMWbmME8j5e5ydJ31eXvH1OGnw==
X-Received: by 2002:a6b:18f:0:b0:65a:42e7:497a with SMTP id 137-20020a6b018f000000b0065a42e7497amr303057iob.218.1651257646726;
        Fri, 29 Apr 2022 11:40:46 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c23-20020a023317000000b0032b3a7817c5sm772844jae.137.2022.04.29.11.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 11:40:46 -0700 (PDT)
Message-ID: <7b3769f3-34f4-db1c-8f53-85d47f2e72c3@kernel.dk>
Date:   Fri, 29 Apr 2022 12:40:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.18-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

- Revert of a patch that caused timestamp issues (Tejun)

- iocost warning fix (Tejun)

- bfq warning fix (Jan)

Please pull!


The following changes since commit 9dca4168a37c9cfe182f077f0d2289292e9e3656:

  bcache: fix wrong bdev parameter when calling bio_alloc_clone() in do_bio_hook() (2022-04-19 11:28:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-29

for you to fetch changes up to 09df6a75fffa68169c5ef9bef990cd7ba94f3eef:

  bfq: Fix warning in bfqq_request_over_limit() (2022-04-29 06:45:37 -0600)

----------------------------------------------------------------
block-5.18-2022-04-29

----------------------------------------------------------------
Jan Kara (1):
      bfq: Fix warning in bfqq_request_over_limit()

Tejun Heo (2):
      iocost: don't reset the inuse weight of under-weighted debtors
      Revert "block: inherit request start time from bio for BLK_CGROUP"

 block/bfq-iosched.c | 12 +++++++++---
 block/blk-iocost.c  | 12 +++++++++++-
 block/blk-mq.c      |  9 +--------
 3 files changed, 21 insertions(+), 12 deletions(-)

-- 
Jens Axboe

