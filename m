Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3445C43334
	for <linux-block@archiver.kernel.org>; Fri,  8 Jul 2022 12:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiGHMrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jul 2022 08:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiGHMrn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 08:47:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D76B258
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 05:47:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w24so17978606pjg.5
        for <linux-block@vger.kernel.org>; Fri, 08 Jul 2022 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=Zf8l3oHCecA1dC7efE4EmKeEheeZ9tHOE/uMGwIqNHM=;
        b=7iMC9C7ZkWghWsE9PJKX3lo6DWR4XSI7TRKmdJDmZnhzdJsCfGO9ZoKvIuhxIWPpe8
         YhV8bLBi+cd3nAScQ1WkEsfctgxwE4iUib4pPROo7glcPuP22LgPvv3kYqhrX2NmDcb5
         mHgQuBpsT4Vyq8y/q5bGwZbIpToGmQj9wdQUMmGQAJr7iDmGbPNOjDqUIBr2LT6BQBJL
         Th8O3xQxr6M1aC34QoXvT88/kcJ0RNhm+gr+KM7mcU/FH3PZbhARh363x/IubzVx3ozs
         b/qGsAyptbL9O0je3q0DWXJmklwlIwNJWfqU2UrCcjBXIeVWIejBRqQpYCOrdvKxshMm
         /NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=Zf8l3oHCecA1dC7efE4EmKeEheeZ9tHOE/uMGwIqNHM=;
        b=kJX7RR5UYLeqmrwwRfFRk0wfVbSUofFoiHEz8Gdbdt8XN2k4HxaaDgKHpfk50m925G
         CKJwzhcSNx4yXo5sLZhyEYtYn/2M3wvYod0jU/3+wTAyyF3n+1BIsA0ApA/Eo+ZOWufP
         1PUNhI961ewSxj3tpMq3j37MHjxruhFBKMirIEMSh93eAppoeB+QMa0asLJ+0Xm957eV
         L52WrPF8jSIUTjmDW0hDptJvod5W5f2pcwTbFYcHsazf10NY8IbIvEsv3+OJ0bY9Jl2P
         45cTHfj2XnOXVEGa3WcUv+dX2pE4C9FozCYxxj8uuPGcJvwYFSJx1TLCcSg2uxdL91BU
         x1Hw==
X-Gm-Message-State: AJIora9dKkkRRFPZb/wI/NwMbdP4qbcafOs5ZRhDZQqDdKLAVqLimofw
        53UA9CUWI79idkH08Jd2AllnJg==
X-Google-Smtp-Source: AGRyM1stczfP8QuacibbPocVTEoKXye8Tz91bdIZiEnft3xi2HF0pTTk6i0BVmK9QaRawQR7cUWZmg==
X-Received: by 2002:a17:902:7290:b0:16b:b6b5:7e6c with SMTP id d16-20020a170902729000b0016bb6b57e6cmr3778890pll.116.1657284461997;
        Fri, 08 Jul 2022 05:47:41 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c9-20020a624e09000000b0052974b651b9sm1984457pfb.38.2022.07.08.05.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 05:47:41 -0700 (PDT)
Message-ID: <1b53ba18-b689-f192-a7e9-19062b3bbafa@kernel.dk>
Date:   Fri, 8 Jul 2022 06:47:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.19-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

NVMe pull request with another id quirk addition, and a tracing fix.
Please pull!


The following changes since commit f3163d8567adbfebe574fb22c647ce5b829c5971:

  Merge tag 'nvme-5.19-2022-06-30' of git://git.infradead.org/nvme into block-5.19 (2022-06-30 14:00:11 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-08

for you to fetch changes up to 6b0de7d0f3285df849be2b3cc94fc3a0a31987bf:

  Merge tag 'nvme-5.19-2022-07-07' of git://git.infradead.org/nvme into block-5.19 (2022-07-07 17:38:19 -0600)

----------------------------------------------------------------
block-5.19-2022-07-08

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-5.19-2022-07-07' of git://git.infradead.org/nvme into block-5.19

Keith Busch (2):
      nvme-pci: phison e16 has bogus namespace ids
      nvme: use struct group for generic command dwords

 drivers/nvme/host/pci.c   | 3 ++-
 drivers/nvme/host/trace.h | 2 +-
 include/linux/nvme.h      | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
Jens Axboe

