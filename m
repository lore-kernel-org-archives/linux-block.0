Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8188C4332F
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 21:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiLHVDH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiLHVDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 16:03:05 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D62954767
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 13:03:03 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id o13so1727103ilc.7
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 13:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVLGV9HSVjQT6MWFOCI6sr/k5HJU0kVG05tStWNC7nY=;
        b=ipaP+BSrE8uS9w5Vr79fKneH80rRl7vVwJ9JvMJwUJIl7SfXJUXy+e6z20PDFhEXEl
         jBgd84P695DTiiRUt+hFmRHfSdJ07shFrrgajKV7J7SNtI/fpclNEJtzTVmUEWfvGpCm
         UFCUzOwbT3ChHrwc3Iq7bAPIj1id0ihoDM0G4AVPZ/sJH8FD30w9IbLjr+VahvoPoc/O
         q7QgEqVPpiASlo/m/VSRAJ67WlAchzZEcddeAL/UsVh/e90rSnHKOSOEEugPn4Z309A3
         fG04NrlY23B2wu40FlrWz8X+yOBrkye2SVgmQRbt3+fEPurDqwdmvKlQlwamLUdTWos6
         iSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EVLGV9HSVjQT6MWFOCI6sr/k5HJU0kVG05tStWNC7nY=;
        b=6vGXJ+JKjh/Wg+V/LV5GMpJCOu2UMVxPt3+nBQxkRlxKLhdWnAJ9Qh2MKqhmni7FHe
         ODGaDZIqo3EPJ9YHwTCyHKvy8sWQ8UOZiW+JtVvmiwxZfCaHQpHKlrBdsy0cZmV29GZB
         bj/l5Z5NYqv3XdOHLw5SFcl9KYBHZCEHZSBUVtF7BXbFUnsajIUB8qx0uqstNI1jq+OL
         iUrib6AtB1huZ8X8JyM+Q05mRYIdX7EU8vjgobx4TQX5j4sn51hrmZMeF8QV0qxQPhAf
         Q1Ji7F3Q8nZTr36NYY9wBA1obaSc2PVUTewLmQlaYtANgjyvWAJJIs9CP182U73Uy6gw
         +3fg==
X-Gm-Message-State: ANoB5pkcCMT7AE8JNdsgsOJJkPJJGG2IAb3oF4QKSF+RyGMWueezfu/8
        TDtBSzQyZIrqgGlEZeSu9DRHMkrDKHKunzRm/NE=
X-Google-Smtp-Source: AA0mqf46JjC7y7QrfVPbdbVkJNTeCPnYXVkxqqYos2AHsIh0cyryHAPg0zFLh6ky5mi6EB/LCDJcww==
X-Received: by 2002:a05:6e02:1244:b0:303:7a9c:1b11 with SMTP id j4-20020a056e02124400b003037a9c1b11mr4635170ilq.71.1670533382390;
        Thu, 08 Dec 2022 13:03:02 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e33-20020a026d61000000b00363ad31c149sm8989119jaf.110.2022.12.08.13.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 13:03:02 -0800 (PST)
Message-ID: <40dbd6f1-be33-6536-4e2a-e7f0120a2fa1@kernel.dk>
Date:   Thu, 8 Dec 2022 14:03:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.1-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a small fix for initializing the NVMe quirks before initializing
the subsystem. Please pull!


The following changes since commit d0f411c0b9bdef85f647e15a2fcc790b29891f2c:

  Merge tag 'nvme-6.1-2022-01-02' of git://git.infradead.org/nvme into block-6.1 (2022-12-02 08:01:06 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.1-2022-12-08

for you to fetch changes up to e18a9c18c38f523ae45416e2b75ed4ddf8ad107b:

  Merge tag 'nvme-6.1-2022-12-07' of git://git.infradead.org/nvme into block-6.1 (2022-12-07 08:55:27 -0700)

----------------------------------------------------------------
block-6.1-2022-12-08

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-6.1-2022-12-07' of git://git.infradead.org/nvme into block-6.1

Pankaj Raghav (1):
      nvme initialize core quirks before calling nvme_init_subsystem

 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
Jens Axboe

