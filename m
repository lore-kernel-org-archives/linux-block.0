Return-Path: <SRS0=p+1D=3P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE656C2D0DB
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 17:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86C220708
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 17:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sk8ePj6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgAZRcH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:32:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44207 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZRcG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jan 2020 12:32:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so3954847pgl.11
        for <linux-block@vger.kernel.org>; Sun, 26 Jan 2020 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0HZDBDvDYqsKTzDP1l3UbI6xKbEIO2AvsS9tOgpJ3Gs=;
        b=sk8ePj6plKOvIdoRkxZ+lqi3upAoRTIGJfCXPb+8bvPolxLnhV4ihxSFCbWAZMjkXj
         V/2An44ZFqxReGWiikRFgeXKXGcQbL3pNOn/XFwx4cVPJTlKPIWsHtK/hroSFC58vhpS
         LV7n5XmsG6Xx9ec2HnRpag7WcfrSpr/Zj2vF8a0qT/d4DlY7JUKEvqlA2rU2iFQMj7el
         Gg9RWFtXafglcn4UNKr3P8j9yfu6hDfK9FGJ/0ptfSsvCQY9BU1HYw2G5xAxouIYNR5b
         LG7wzYrSy311tLdF4NzMN85LZCuLIqdKyzfdG7/b6EzdP01DvrgWdvumJnM6vJLn5UcI
         y2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0HZDBDvDYqsKTzDP1l3UbI6xKbEIO2AvsS9tOgpJ3Gs=;
        b=FJl2uCmfef6K4k1ptLSxBZ7vc+5sNTdOn/POJo4X+jBrqrWCW/JYbCo9Nt4dNffQEA
         FFooTYHA7pe1cmiFLnCJGiXbsBIrK7jaL0l74I5nVqt7xCDVdDs8rvFRYtkLZn8i+T/R
         YpdB4Xsoe4l1Nbm34ibvitQaaaDZYjm9rLcsXSqxf+awGri/7pCXKeKQcniSIiGJAzg7
         TGBCj6UDBFeqbybGoVkvLHWv5h4tfuHvSnsjrou+W3YKsZB0OlQ7L/hZ5Gak0d3rzSc0
         1wqflBlkBErCmA4OtR8qPj6+iKfnqF+jy5n1T6WMycV9V751AzUtAuIZofZ6gZUnXkaC
         2cUA==
X-Gm-Message-State: APjAAAW14QQ2tW8+3gSdL3pz8o139P0eApAhatHRn4C9GyZSxndsOR6V
        /GNlUNAkH2qUEfI3CQK0Bl+CeTlB1Zk=
X-Google-Smtp-Source: APXvYqwciDe24Qs0nFx0zJFZU3M8vu5HREIaqV5PCxkLXheuGxRvY7pQQ3KgN6XeXNYfdBqI+xbE5A==
X-Received: by 2002:a63:4b52:: with SMTP id k18mr15072078pgl.371.1580059926030;
        Sun, 26 Jan 2020 09:32:06 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d194sm13157134pfd.159.2020.01.26.09.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2020 09:32:05 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.5-final
Message-ID: <4deb18d9-34fd-c780-dbb4-f544d30ac807@kernel.dk>
Date:   Sun, 26 Jan 2020 10:32:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Unfortunately this weekend we had a few last minute reports, one was for
block (the other io_uring, pull request coming later there). The
partition disable for zoned devices was overly restrictive, it can work
(and be supported) just fine for host-aware variants. Here's a fix
ensuring that's the case so we don't break existing users of that.

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.5-2020-01-26


----------------------------------------------------------------
Christoph Hellwig (1):
      block: allow partitions on host aware zone devices

 block/partition-generic.c | 26 ++++++++++++++++++++++----
 drivers/scsi/sd.c         |  9 +++++----
 include/linux/genhd.h     | 12 ++++++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)

-- 
Jens Axboe

