Return-Path: <SRS0=7zlQ=R2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A7C43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 15:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B010206BA
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uknE9+Np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCWP7H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:59:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35166 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWP7H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Mar 2019 11:59:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so3546593pgf.2
        for <linux-block@vger.kernel.org>; Sat, 23 Mar 2019 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vPhKFhVHvB+INBFWGtM/X4mn22ic1ssk41iqdDgqTZQ=;
        b=uknE9+NpQyPmRFHHKEBPhkhfBnA/hao3I8khBn/sVIXajTpFodPRstRDxL2gOoKEtp
         mYMt5C3wdYMUJIxkeXKN2/lBZpcbDfnpbskZsCp6nEfRijfPR7L/I0b5aemF5sJpPtKf
         Q9Ka/bZUfPGJLyOe51igobtK2rg8Yx4Z3W92Pd+xPGXiETSEM7heSX+aKAbyZf5+crCW
         usyBqTunHpKXNuNX/6qcxRPQOLFoYaapSPIbH868+yTvlp85QUFoDzx+Btssau1SFsMN
         N04Tg3ASYsv8o2SnBChYTN2r9bqEJK/28kumncyg2mtOmcTIyMxBX7Un7a4KrFychuoq
         /jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vPhKFhVHvB+INBFWGtM/X4mn22ic1ssk41iqdDgqTZQ=;
        b=ew8JgIcNjgjFzGqNk371rO25oGBbkTrWuC7v6LBND1VvuwDmtBRyU+zCEOgoaloSEZ
         tZyArgbjebpv5fMa9djJ19UDsn8Mrc128GFourvISCKU0HtiYugMfWKr66jgespqIFxD
         +U684w4TlN0dHBwzah6b1YyxS8CEw8V8L8wLqBzTs73/Mqzm/rVH3EVrqcoGeSIaKvBa
         tTGsIIVPOi3kUHNW+KDGR4q59yBKusarsfUbH9iAWiJNiVPLUXpaxmXS7WRPyGcWGAtv
         7cNhm+9/kiGSIhun31xdUSuIZoTG3zOrZdtKD7oEXVlsfWI9l8zstLRrFn8Hh2Jf9SEP
         uBYQ==
X-Gm-Message-State: APjAAAWL1we7wQQjt7Fw3J+c/AdnsdGU8SkoZqQtjK5o7Rumh/XRPch6
        jjQrWuB88DI65BA4At7QsqVQlyuXh8w1xWCy
X-Google-Smtp-Source: APXvYqw5CNknjQh6XE9s4KZkKAJKQw2AmpJOS5ECHbtb9HVQnrRBziOKfS//0KnfXLkC5us2n7DzgQ==
X-Received: by 2002:a62:1342:: with SMTP id b63mr15012793pfj.7.1553356746255;
        Sat, 23 Mar 2019 08:59:06 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e63sm15330162pfe.120.2019.03.23.08.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 08:59:05 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes/improvements for 5.1-rc2
Message-ID: <278dbb07-f4f8-8984-ab1a-0d78ef3c518c@kernel.dk>
Date:   Sat, 23 Mar 2019 09:59:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The first 5 in this series are heavily inspired by the work Al did on
the aio side to fix the races there.

The last two re-introduce a feature that was in io_uring before it got
merged, but which I pulled since we didn't have a good way to have BVEC
iters that already have a stable reference. These aren't necessarily
related to block, it's just how io_uring pins fixed buffers.

Please pull!


  git://git.kernel.dk/linux-block.git tags/io_uring-20190323


----------------------------------------------------------------
Jens Axboe (9):
      io_uring: use regular request ref counts
      io_uring: make io_read/write return an integer
      io_uring: add prepped flag
      io_uring: fix fget/fput handling
      io_uring: fix poll races
      io_uring: retry bulk slab allocs as single allocs
      io_uring: mark me as the maintainer
      iov_iter: add ITER_BVEC_FLAG_NO_REF flag
      block: add BIO_NO_PAGE_REF flag

 MAINTAINERS               |  10 ++
 block/bio.c               |  43 +++--
 fs/block_dev.c            |  12 +-
 fs/io_uring.c             | 439 +++++++++++++++++++++++-----------------------
 fs/iomap.c                |  12 +-
 include/linux/blk_types.h |   1 +
 include/linux/uio.h       |  24 ++-
 7 files changed, 284 insertions(+), 257 deletions(-)

-- 
Jens Axboe

