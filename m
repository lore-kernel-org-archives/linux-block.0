Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A0C433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Dec 2021 17:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhLSROB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Dec 2021 12:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhLSROB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Dec 2021 12:14:01 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE5C061574
        for <linux-block@vger.kernel.org>; Sun, 19 Dec 2021 09:14:00 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id j6so4480662ila.4
        for <linux-block@vger.kernel.org>; Sun, 19 Dec 2021 09:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ga2Wl9f/1foFY62Wlc8VODha7nmRjQPysvMA2RCkocM=;
        b=2Qp6pqD6m6dPARzaOXalwvpiRtMsVik1XnYyY4b8Ub7kpUlC3+KlI+TfzjY9J2fuE4
         p2I5C797usRQngtl28XciRlFmXMuizg5AKxPsQLPDqahoTrvcJwndSDdnHCJrQjppzI1
         MOU7dOKc2Nu51bEKYexpo1czOIhlM/ECZHBriyKCx/w8ZiV85fvuj+NKyoaDu0rNB1nf
         hL1N86aUW+qoBrMsdawSXyV7DY7jIjvyAHIbu+azFxEbGzXNQBBzvV058kflljml6tR5
         mg5uod9mbeuPrKnp9LXkx6rvQaZgbJRDYvqgTOfDyBo5YpFj7UIswX2G/hpTNDGrn9/1
         ZaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ga2Wl9f/1foFY62Wlc8VODha7nmRjQPysvMA2RCkocM=;
        b=kZUESUaHwvznSVl6B7ai4bp2v4rYrdnYL8KEGsJqv58R5cNP1yDFmDjL78FFZbuERb
         BFsyF8pcKwhag0jBkbYA2tYSwGJbCcvlzQRt2bVthAxZbW71wGTvmc6LvDVU6IB7W9ZM
         237aVqB/jUs27dzKnpjzlV8QvoVPVpc+T2LQHXY+eXQh+i9lb2Xb6yj4QtCbLiUTA68C
         htfmsMOrGzgc1ivpplxqNGaLCff29tft4/wJjVrp0kLqA35WxxhYCwnG5i3xYnDe508Z
         TVNsNmI/SEvIDTtSqKHMlqnGWufZIHtYTE8/zz2seuDsAEksCEKUDzpwr/E+R6bdlV6g
         wjWg==
X-Gm-Message-State: AOAM5321LX70/cc05sLy+k+nWHMd4jA95DeQMZJCSPukdN26MSrn9kzT
        JLwKSUgYxMRX5/+UGNtNANYCc5Tgvge0NA==
X-Google-Smtp-Source: ABdhPJzkPxSGzoqUGcIODGwd78pNDON4lC8H6WYRboQnICjB8Ux+JL5CIIq0y01VyQqrHF+H5No80Q==
X-Received: by 2002:a92:c54c:: with SMTP id a12mr2621913ilj.256.1639934039848;
        Sun, 19 Dec 2021 09:13:59 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w11sm8287880ilv.18.2021.12.19.09.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 09:13:59 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block revert for -rc6
Message-ID: <b49f11c8-11b3-6d81-288a-9ca545763a1d@kernel.dk>
Date:   Sun, 19 Dec 2021 10:13:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Turns out that the fix for not hammering on the delayed work timer too
much caused a performance regression for BFQ, so let's revert the change
for now. I've got some ideas on how to fix it appropriately, but they
should wait for 5.17.

Please pull!


The following changes since commit aa97f6cdb7e92909e17c8ca63e622fcb81d57a57:

  bcache: fix NULL pointer reference in cached_dev_detach_finish (2021-12-14 20:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-19

for you to fetch changes up to 87959fa16cfbcf76245c11559db1940069621274:

  Revert "block: reduce kblockd_mod_delayed_work_on() CPU consumption" (2021-12-19 07:58:44 -0700)

----------------------------------------------------------------
block-5.16-2021-12-19

----------------------------------------------------------------
Jens Axboe (1):
      Revert "block: reduce kblockd_mod_delayed_work_on() CPU consumption"

 block/blk-core.c | 2 --
 1 file changed, 2 deletions(-)

-- 
Jens Axboe

