Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FB3C2D0C2
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 16:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA7721734
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 16:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xatsX71h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgACQ1R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:27:17 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:51789 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgACQ1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 11:27:17 -0500
Received: by mail-pj1-f52.google.com with SMTP id j11so4778924pjs.1
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2020 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ewI6kNgnuFoy1NljHwaTnJVsIynTaSpRVFrE4ARkdHg=;
        b=xatsX71hJPtuOYgWsLfdGiIBiFv3+RxW8iPaUldRYpGOqEOt62rnwkZyW7EZtiiPMA
         zT+FpOG4MLprAX7ax6hc6N2b4Y6RliEzQotop9fx96V3w+zPQ9TxrKZ7nEvkeBIurns+
         9CerDp2iKK3/1CPOkYm4ViGDAYDviPsXPyo8zG9L2WIx+hvMdpVTQv5fCsF9GZf14tMP
         yaRXXWsC0sDg9s4/7Oey1PtDJxf5z6ZBf4S7t9chrPfffx3x66KLyb4j/G8sy3qvv0qz
         wzxAKqPJVeDVInVzvJ39q3O6iv4I3oCJrr8o73DxmOYMP97UYbce+VxKiS+mo9Bqu/KD
         iNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ewI6kNgnuFoy1NljHwaTnJVsIynTaSpRVFrE4ARkdHg=;
        b=NZwEwoQVWDLZUq16mAG1zvO6tsaxjT3aOeXh5jg5ptOPX77WmorUjAT/lXxTNrgUSQ
         2HUDOCrufT5cnIewUIXOQcPu0B94SgtWqDs66YfvkOBRTk3kcg/2flo7hLQX0m0d0SEc
         6jSiASO/WtKnqBvnwVFnGDb5QiwHRIZmKbi1mJ9eLIzSZALWlmsPx18fpDtA5zr5iRMb
         3Dq46kax+NnKRFqhxLIN88QBfkRws3LH5m7+cjyVjxoRzLTPTsvDAF7ZbZZFGctIonSc
         zOz2S7XX0Gi7CyFhEdKSS8rcqoJZMsM/B+O3QkRCeNBzYEmk5ikZ1z5foqGF4bPVlU0u
         iX7w==
X-Gm-Message-State: APjAAAUZspJbUplPANE1MVPBBC3wPKQmQbGXk4YbYhf3tvxPhx8t+MaT
        BAcMglu6zrnnGiFLE9mVQugFi6oPNSAeXA==
X-Google-Smtp-Source: APXvYqybBzFvYgZqAhnlxdAUUPSc8prpsdU10y+z+iThwotfhofw+n1lHD83ruiVsgAwdbqCsHpNSg==
X-Received: by 2002:a17:90a:8a12:: with SMTP id w18mr27457756pjn.68.1578068836883;
        Fri, 03 Jan 2020 08:27:16 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:ecb9:465e:ed5a:a75f? ([2605:e000:100e:8c61:ecb9:465e:ed5a:a75f])
        by smtp.gmail.com with ESMTPSA id i8sm52759730pfa.109.2020.01.03.08.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:27:16 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.5-rc
Message-ID: <a947b677-cf96-0126-9e42-31d478d0c897@kernel.dk>
Date:   Fri, 3 Jan 2020 09:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Three fixes in here:

- Fix for a missing split on default memory boundary mask (4G) (Ming)

- Fix for multi-page read bio truncate (Ming)

- Fix for null_blk zone close request handling (Damien)

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.5-20200103


----------------------------------------------------------------
Damien Le Moal (1):
      null_blk: Fix REQ_OP_ZONE_CLOSE handling

Ming Lei (2):
      block: add bio_truncate to fix guard_bio_eod
      block: fix splitting segments on boundary masks

 block/bio.c                    | 39 +++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c              | 18 +++++++++---------
 drivers/block/null_blk_zoned.c |  5 ++++-
 fs/buffer.c                    | 25 +------------------------
 include/linux/bio.h            |  1 +
 5 files changed, 54 insertions(+), 34 deletions(-)

-- 
Jens Axboe

