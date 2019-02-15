Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE3DC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1C121924
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 16:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SYQTSfbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfBOQ4U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:56:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37520 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfBOQ4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 11:56:20 -0500
Received: by mail-it1-f194.google.com with SMTP id l131so24824383ita.2
        for <linux-block@vger.kernel.org>; Fri, 15 Feb 2019 08:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ktUX7cnfJ5X7FqehWvoFu3xkgtiA493aShJ+L34ifnA=;
        b=SYQTSfbOd3AxRHdwiNARGgE3hoG4Fglp4wBFAIG2BfHIRcezAc5jVma67yOGqIId+v
         V9Sm3AIqi0f1F6LRVzi4PuFKIluNtMaYQ99lt4J+61eKJgnWQvFzT9efnCZO76BPDbLW
         vCHE0Ok1v9HmPkTE1mOO52kelNJrVCocgGvSet7+WCrJl62QTygtsTI7sML/AoV9BK0P
         Pd3JP51PHeV2OCwo2u2v2lLMG1J33xkNPrR6SKX8kPjL/4kp7z0u9bRVUme12rNxDt//
         WcNF2XwrsS+jtMPJaWVnEhl7ukAE3x3yARWql6aQ2JJJgxaOfatFD6rXop1CinXvN36s
         K0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ktUX7cnfJ5X7FqehWvoFu3xkgtiA493aShJ+L34ifnA=;
        b=I+bvHyXkhLm2eryLF0rrlpsjcCz8Y/sEHch3M011MnjNxq7Gvoe3vJhRK+85jWDq3H
         BFNDSxjrMZ02kQPwvSONPWwTp3aLe7zzqy5qKRm0mdnTBgwNYcChIOQNOs5+bk99Jwli
         S6aDWF/Rp8NK9GOAHEWzjpAjVRvNut3NNe96BSBfFhFJfs1WyjeFGHoOYi57R1ahoDQD
         wRo7eRdRhAErSiFYvN4O2sjRvLN716Hh6XqmnJPUS4Nq8ubXi7U46oNis1+fasbh9o4V
         vDZ2OoQn++AGc+92AR73KcHeMEs40/gzA4ohle23sNdy9pMw6ZeKI9x+VU7THN9d7t69
         aV+g==
X-Gm-Message-State: AHQUAuY8LXxZvFBH6Q76JK5AwORuaEuKUl/vEULGYbFcy48ESBBu5rnB
        PCXX9Q6deBMPQkMJze81ZI7JlUDgyaYGcQ==
X-Google-Smtp-Source: AHgI3IY/ssw33kDFCjAx9HL5Vj2NURqLZspSBt+Fcvh4s+VShsAZibbByYIbJqMNz2NTbED4vQyxxQ==
X-Received: by 2002:a5e:9b0b:: with SMTP id j11mr2029989iok.65.1550249778840;
        Fri, 15 Feb 2019 08:56:18 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o19sm2790650itb.37.2019.02.15.08.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:56:17 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.0-rc7
Message-ID: <c74b7382-dbe3-ecc9-17fe-b0e6e3b32b26@kernel.dk>
Date:   Fri, 15 Feb 2019 09:56:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Small collection of fixes that should go into this series. This pull
request contains:

- Ensure we insert into the hctx dispatch list, if a request is marked
  as DONTPREP (Jianchao)

- NVMe pull request, single missing unlock on error fix (Keith)

- MD pull request, single fix for a potentially data corrupting issue
  (Nate)

- Floppy check_events regression fix (Yufen)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190215


----------------------------------------------------------------
Jens Axboe (2):
      Merge branch 'md-fixes' of https://github.com/liu-song-6/linux into for-linus
      Merge branch 'nvme-5.0' of git://git.infradead.org/nvme into for-linus

Jianchao Wang (1):
      blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue

Keith Busch (1):
      nvme-pci: add missing unlock for reset error

Nate Dailey (1):
      md/raid1: don't clear bitmap bits on interrupted recovery.

Yufen Yu (1):
      floppy: check_events callback should not return a negative number

 block/blk-mq.c          | 12 ++++++++++--
 drivers/block/floppy.c  |  2 +-
 drivers/md/raid1.c      | 28 ++++++++++++++++++----------
 drivers/nvme/host/pci.c |  8 +++++---
 4 files changed, 34 insertions(+), 16 deletions(-)

-- 
Jens Axboe

