Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D3C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 15:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3A120828
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qzrX6gir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfF1Phe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:37:34 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:39957 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1Phe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 11:37:34 -0400
Received: by mail-pl1-f177.google.com with SMTP id a93so3456368pla.7
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Fbz7i/a8prmVWVZJikznTM3uMPjhEIVGVwJsddN/mUQ=;
        b=qzrX6girWKGE0L5Pc3mTSB5Ir3xKpSWq5LRnR1EMSEObgUzD1NOWiLQeswnXVYc6J6
         yb23d3LUX1fQGZKNjh2/WPyyNVBmar8tyUZ822N4AvbI1+xMmiBk7mG2T1UYhCJjBuJ+
         +XH3935WhQF5xMmp0a87spY50yy/9/SZod1+2pSQRyUzz/F3VpryNfA77OWBxcAp0JvT
         DVRevtYr+i/H8DY4nYyqApzIDF5Mn9fbhAf7t9UcheFuk4KPOrvSVLCg7YrW4WTjCYuK
         s7W20AsPnjHhCX7xkzNkAavjNgKPigEC1c0DFYqx8I8axtGfO0sWMS30we+2C6h6Yp3n
         eOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Fbz7i/a8prmVWVZJikznTM3uMPjhEIVGVwJsddN/mUQ=;
        b=E8SGeXP8IU4Onr9irpVRQKOjV25RoplWtRdCHzOaURzfTjiqd+G+uyQHjQJOV7OQge
         zMzKX4Uf6yHsRy30JuLLeTdICQIf4ajvBfx0ahJ3IDZbGD5EojlP7iFTH2kjcZzmbtvx
         FPsjIW1Itdp9N84JwuoG7MZdf3FGg5VXxFwlu70b3q3Cmf7CNMIiYE/ntFLN6OkJYz8c
         mPXJpSTkqb9+FY7LKz6R9MMnLfXt9nGnacWMBdCtukWRko/CpGgjJ30VvI1RhIUmQ7sm
         ebNMx7/sHSeO6DsoFjsTKhVJSjYjBP+M3DHNcZpIJdADag+qlMwqFbpTHE8b5WC7Vk1o
         +8tA==
X-Gm-Message-State: APjAAAW/Y1snbSQWA4UrzYZtxs69C5C8TV0PT5mdfLj7Ptm+omZxj0Sb
        xbZ2kyvI1IurnnYe0WZljMVYi4rTIBcg2Q==
X-Google-Smtp-Source: APXvYqzTm3Z2xAtGZSAT1B2HGUjszC6uPxsFAHLXkX3bgOQkEF4TL1f2mh4B5irtbPXLqS5hTymHYw==
X-Received: by 2002:a17:902:8c83:: with SMTP id t3mr12194256plo.93.1561736253029;
        Fri, 28 Jun 2019 08:37:33 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id x128sm7198647pfd.17.2019.06.28.08.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 08:37:32 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Fixes for 5.2-rc7
Message-ID: <bed3d400-fe9b-6016-5332-1c663912fbb6@kernel.dk>
Date:   Fri, 28 Jun 2019 09:37:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just two small fixes for rc7/final. One from Paolo, fixing a silly
mistake in BFQ. The other one is from me, ensuring that we have ->file
cleared in the io_uring request a bit earlier. That avoids a
use-before-free, if we encounter an error before ->file is assigned.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190628


----------------------------------------------------------------
Jens Axboe (1):
      io_uring: ensure req->file is cleared on allocation

Paolo Valente (1):
      block, bfq: fix operator in BFQQ_TOTALLY_SEEKY

 block/bfq-iosched.c | 2 +-
 fs/io_uring.c       | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
Jens Axboe

