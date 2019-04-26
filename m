Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0062C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F7F206BA
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/PIB/8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfDZAVM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:21:12 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35695 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfDZAVM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 20:21:12 -0400
Received: by mail-yw1-f68.google.com with SMTP id d132so585293ywa.2
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2019 17:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztWRd3wHw2jMAG4RUdsq7Ojt2d2mraX7SmXYPZ/MnB0=;
        b=T/PIB/8Lc6vYgzuQJ8WyhCqUybuwJcntoclecPqwSVy8vdtmcJ46V3R12gLPxntX5m
         oKUIhY0b7xMXR3qSo+XLUsPMjKu1h3YkNo3dCArXU4PgqKmLs5rqxVq12LSEM+3oqdc9
         AdafnSp4DwfEhJASOFe7K4vSRMr2xewWB2igOw9Vm7x2kMvYNk6ACg+bALaruANzw2E4
         DIXFfBZvMtVoqRF+1n3ADC9Bz/i8/CajTj2dLbhUxCZa08X+qkD4n5wxPq2a1Jq6Tol7
         9D5/iJH8Wkd16mFn6h61KsUqGZeab7U8PhQSagqFsxABSBooNHrYH3WDKk0DAiHEgHvK
         98ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztWRd3wHw2jMAG4RUdsq7Ojt2d2mraX7SmXYPZ/MnB0=;
        b=lh+JAsOr+JPHwl5UozwDBw21Dr7x7qmiRllhmhtE+Rum6dUvl+UWTo2EE8h3YC1mJe
         z9xCGUsxeLHqdaGbPsDZzpf9eZ8icIIj8V4GMPCWYRlRpw5nc21NuPp05VU04+2mJOdR
         /BEkgs94le+1az+3AqLutSOnpyukBmzcKIK9gQqER5SDcyibsnJm4TRn6oJ/87taS2nz
         rnGJsE9CrgK59DSyff0wTgyeVKUKU57ejBH6Zn8dSoC6hknpFzj1mPglNTjSDYBj4tGO
         bCh84rgn7D9g87sViYdcrDGePLwsNWeMKAlfHW3qkh7qqJwUUI7M+pbNVj1uPxkQzvRi
         wtVg==
X-Gm-Message-State: APjAAAVuehbifw+3x4Pbjv80+vkoK1tiSKptACrwJ7FmRrAvxrgJWKtx
        OpdQ9WospmgwkIl6Hl1pUtfEelZc
X-Google-Smtp-Source: APXvYqwIMFmebQ8NgHU5D8xfOh65Ce6Wh40gKZvxSso7E5ae1LXLTq7PqNiRYhTKYfQZGHeklfBsQA==
X-Received: by 2002:a0d:eacf:: with SMTP id t198mr12637378ywe.495.1556238071015;
        Thu, 25 Apr 2019 17:21:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::5484])
        by smtp.gmail.com with ESMTPSA id 191sm8242546ywg.12.2019.04.25.17.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 17:21:09 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 0/5] RFC blk-mq device stats
Date:   Thu, 25 Apr 2019 20:20:45 -0400
Message-Id: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

Hi,

This patchset adds per-device histogram statistics of read, write, and
discard request sizes, as well as number of requests for each
bucket. It uses the blk-stat infrastructure and only collects stats
for devices for which it has been explicitly enabled by writing 1 to
/sys/block/<dev>/queue/histstat

In addition it builds on top of two patches I recklessly stole from
Josef - thanks!

Thoughts or oppinions on this approach? I am not married to the
naming, so happy to change that if wanted.

Thanks,
Jes


Jes Sorensen (3):
  Use blk-stat infrastructure to collect per queue device stats
  Export block dev stats to sysfs
  Expand block stats to export number of of requests per bucket

Josef Bacik (2):
  blk-stat: rename batch to time
  block: keep track of per-device io sizes in stats

 block/blk-iolatency.c     |  2 +-
 block/blk-mq.c            | 56 ++++++++++++++++++++++++++++--
 block/blk-stat.c          | 16 +++++----
 block/blk-stat.h          |  3 +-
 block/blk-sysfs.c         | 71 +++++++++++++++++++++++++++++++++++++++
 block/blk-throttle.c      |  3 +-
 include/linux/blk_types.h |  3 +-
 include/linux/blkdev.h    | 12 +++++--
 8 files changed, 149 insertions(+), 17 deletions(-)

-- 
2.17.1

