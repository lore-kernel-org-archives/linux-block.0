Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF820C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A875B61151
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 17:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbhKIRJ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbhKIRJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 12:09:28 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413B0C061764
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 09:06:42 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c3so10394253iob.6
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 09:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5ueSF3Jzj/mRZHLnQ6aIVVkQmonFWfPY35FWwOx+fvI=;
        b=H9n+76YMD00Nem8uUvq26lfNo+sjVJWYmUSIMZ4rZt2bBnruN/vtQ0hOQ1l14Ob0sj
         KilKV4Lx9YfqTZkX1LS2v+b6htjVvSKbmtxGaEEuDo2PFnUqVEPAU9R87xAOAQbALozX
         YuCA7gHkS277UJEC+TK1alqqxlI0CAGWHqzSBHLpRd7/OtILRoR5loFuyiQ0YqFzCbil
         lIo1/LqTPq+H0yo7I0Sae7BVZfVgzmA1RfKvVJVod6b5MEF/DmQPbsGPtOTx5QGn4/ER
         UbSPV3SRFuq4PG4kvQZXsTCWC7DSRkq2sYUO1XTuaBwyWFXzW1gMg8g8sCTnGm8Fous5
         Tdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5ueSF3Jzj/mRZHLnQ6aIVVkQmonFWfPY35FWwOx+fvI=;
        b=dHSnFkucRp6tkhyvHRol3syQdbsJQxNm9IOxJgTq1REfXDUuvBUE0ysAsivRv9MtZG
         G0zbeHjmgPRmZ94U+ObWf3+HJdrtVVfb7GzooAPgdZ+vrmiQMPU7fAs50iSwSy22/jtY
         1MOO4m9q25GdQzb4hH3lkOANOk8uGKAh81ZhGqJIi8hKbADvi8I+DAg9pmjQMLlzbhy6
         ZZmUT5qgxSGsEdaWZXwZv5W0khQaOoBKk6RyG4YZpELefKCRc73BAa753fcwrU4B3ydO
         7TIwM+m2mh2i1jfWjyFIq7oWPgVV/MUdOSbGDoE/qeBdCmX+QZxfIy2dde/wPP0v85z0
         eIxg==
X-Gm-Message-State: AOAM5307Gjt2gYsedy2+uNojtv8G7VE0Y8+wldOF+FcoygA+s/hwe5KQ
        OfTpc2kRMYnU2ldzbPrRT5WfjGJTljm3Q0FX
X-Google-Smtp-Source: ABdhPJwe3c5NKsTEFTHCbQBz6flYqsQ7+QBeXv102xBEtQzL3WedsJO6DOcCES0n0rahju5OfqDCUA==
X-Received: by 2002:a05:6602:2244:: with SMTP id o4mr6198866ioo.13.1636477601329;
        Tue, 09 Nov 2021 09:06:41 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k13sm11948863ilo.40.2021.11.09.09.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 09:06:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] bdev-size followup
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <0b1a05ef-c234-5839-6a73-0e5bf7634526@kernel.dk>
Date:   Tue, 9 Nov 2021 10:06:40 -0700
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

Two followup changes for the bdev-size series from this merge window:

- Add loff_t cast to bdev_nr_bytes() (Christoph)

- Use bdev_nr_bytes() consistently for the block parts at least (me)

Please pull!


The following changes since commit 97eeb5fc14cc4b2091df8b841a07a1ac69f2d762:

  partitions/ibm: use bdev_nr_sectors instead of open coding it (2021-10-19 06:17:33 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/bdev-size-2021-11-09

for you to fetch changes up to 138c1a38113d989416df57e9f8973c10c9e1fa04:

  block: use new bdev_nr_bytes() helper for blkdev_{read,write}_iter() (2021-11-05 08:32:05 -0600)

----------------------------------------------------------------
for-5.16/bdev-size-2021-11-09

----------------------------------------------------------------
Christoph Hellwig (1):
      block: add a loff_t cast to bdev_nr_bytes

Jens Axboe (1):
      block: use new bdev_nr_bytes() helper for blkdev_{read,write}_iter()

 block/fops.c          | 4 ++--
 include/linux/genhd.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Jens Axboe

