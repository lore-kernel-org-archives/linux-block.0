Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F436C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 20:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE9C20858
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 20:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0ePU7/Yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE9C20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeKPGYP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:24:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34028 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeKPGYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:24:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so3673554pfg.1
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 12:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qzleyIG4fWbMBjys0bsxSkIUUXv49fRHq34UAUsgeyY=;
        b=0ePU7/YcXm5OfMcIBxM8ySLfGW2Njxzc6UHJkjZOUaKbAm4I7wc1UmxwuStH5sSO1t
         eKSNGaXQ+Otw+YEaO9J4K9/4vIqOu+yBUYzmc1FzZJz2nLOvMsnQN8XvGruvJZsogDHS
         tinFjGSjICUI9O+FrNYa50wvUoWcBpg39nfzaKYLEAf9mtnus5Xceeuk1sWTqUKBfoiU
         KdhIzNyNG8BQu5fmqePPFnx626dfp8nsADgf9tTjBpxCOMaeVekTu8iUxis8U0QHfzKn
         8y/UjAWqurpHUYeu7D7yMYIbosl/AQ/3qwh9y0Xw7m94Dgn5haShvtpd/8U4EwIJVfk6
         x1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qzleyIG4fWbMBjys0bsxSkIUUXv49fRHq34UAUsgeyY=;
        b=Af/TuKSYqPkzdBG0ExNoV88br5XM6NVY9eRjHBWlRG2nwCM61l8VHsBd1aNC6WtW8D
         VQi0xWTABlHrc2cIGcis4XlvlJnG3pnnZGq6R6V6Ehw4Bg8YNo+bXTW5DOHQRKBHUQIK
         63oejb/eoLA11V5Qh0wj3k5VM7zZI55hzQdijx1br5HnmXUggNrvjkOIZl5TfPEPEdR1
         qHZBrpRIKpI8MCTQ+sW073BCWiSSuggtzNbPAWQXdpjIELslozR6hBmqcnQfEeLomAJB
         pDZek59rrb+Yhvam2qB/kW5RAwPdKcCs9cacNx5TeLeNgjhPM3lyHe8kj/88XzTKKWAW
         9p5A==
X-Gm-Message-State: AGRZ1gJYvkeRMXDXL7f0ldYlrgFlDDVXarsnrQ9+BU5eiYv+xHSYzYak
        dqbmq6lzoHJoWUa6ZH7+9Qegx0au3pI=
X-Google-Smtp-Source: AJdET5flu6gQy9+MdHpHrnlMeXOhRNhZ+oglSVcQqYV4rgpQSE2kdThWLkVjWCaipBXNZjRyM5CtzQ==
X-Received: by 2002:a62:59cd:: with SMTP id k74-v6mr7934136pfj.243.1542312897516;
        Thu, 15 Nov 2018 12:14:57 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::11f6? ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id h128sm32614674pgc.15.2018.11.15.12.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 12:14:48 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.20-rc3
Message-ID: <35c71c32-94a0-3fa0-c6af-3f63258456ad@kernel.dk>
Date:   Thu, 15 Nov 2018 13:14:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Small set of fixes that should go into the next -rc. This pull request
contains:

- Discard loop fix, causing by integer overflow (Dave)

- Blacklist of Samsung drive that hangs with power management (Diego)

- Copy bio priority when cloning it (Hannes)

- Fix race condition exposed in floppy (me)

- Fix SCSI queue cleanup regression. While elusive, it caused oopses in
  queue running (Ming)

- Fix bad string copy in kyber tracing (Omar)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181115


----------------------------------------------------------------
Dave Chinner (1):
      block: fix 32 bit overflow in __blkdev_issue_discard()

Diego Viola (1):
      libata: blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD

Hannes Reinecke (1):
      block: copy ioprio in __bio_clone_fast() and bounce

Jens Axboe (1):
      floppy: fix race condition in __floppy_read_block_0()

Ming Lei (1):
      SCSI: fix queue cleanup race before queue initialization is done

Omar Sandoval (1):
      kyber: fix wrong strlcpy() size in trace_kyber_latency()

 block/bio.c                  | 1 +
 block/blk-core.c             | 5 ++---
 block/blk-lib.c              | 4 +++-
 block/bounce.c               | 1 +
 drivers/ata/libata-core.c    | 2 +-
 drivers/block/floppy.c       | 3 ++-
 drivers/scsi/scsi_lib.c      | 8 ++++++++
 include/trace/events/kyber.h | 8 ++++----
 8 files changed, 22 insertions(+), 10 deletions(-)

-- 
Jens Axboe

