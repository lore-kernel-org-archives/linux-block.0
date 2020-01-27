Return-Path: <SRS0=/Ic2=3Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122ACC2D0DB
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 19:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70D124679
	for <linux-block@archiver.kernel.org>; Mon, 27 Jan 2020 19:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WTTyEJcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgA0TiQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:38:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38044 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgA0TiQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 14:38:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so5375467pfc.5
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2020 11:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IviKpoSVXk3V+icqZuLHtitdbGwv55zNNuWiiDfwmg8=;
        b=WTTyEJcNLyE5qrdwgIr9zr2uHDb4MvkBqUvOy8WbYFs8J3a6ae11e92HirRKHxj2yz
         Uo2FpNbuvxNK43xTBZe+OeUY0W8b9S/KOFwz9viZfcbY8kp2Bt9ZXmhvrwjQvbthhWsY
         fAcef+OgOgeDL3njNpbkisTJnhn17ocCv+BweyHnCfwiOomzWhUfpww6BQ8+v811BrvG
         eav8BkbYXWNYv7zLkJNPhg1dqHGjTinKLUj4zfmDXoYe0LCzQ+VjmUx7qE3YO7NrT/5M
         G/7q757HlBGKyFkIIaPADMKFIz/OgVlWih0Gop6tIU8dYK3RblRr+kZz3FXSv/HtNZYy
         j/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IviKpoSVXk3V+icqZuLHtitdbGwv55zNNuWiiDfwmg8=;
        b=WE63G87jIni0jJecPn8Rob8cG9tXAqAE+tjy0Thnki3Zomjkxtv2DY4X/Y5+7m6g1z
         dTcfKB4p4cgSMqLRXIJ4I/pqMVHgYzqdfssIWeVy5xmvuv0yh8eGe1KIf9bfNz8OLjBJ
         Z1zab6Z5ej1SDAuvvJeAULSOmcTrwYGg4Dlk/8RWYk5GY/tIP09SknIQ3moMsmpJ8vOd
         09sHf4YIUuXhdPxiT2wstHzXt/IScIJ/bYfwIPOJfiHN6EhardDb7a7s/+aD5FJXsCxo
         RhCi4glOWtIzjbaIZ+t0dUNleL64/W/Z123/A6isUyVJW3BEhzlLbCLC59000WLlBruS
         IYgA==
X-Gm-Message-State: APjAAAUFqyLh4S/zPwwW5ZSRi/sPflWGFdDOjeKAM4Pn4XH+vCBv9q65
        g4h38VvpU7Tq6w7Bl3j4srLhEdRB1lA=
X-Google-Smtp-Source: APXvYqwzZoNK2YiYdZGAGAal9TDAUMuiYpb876nydBWcVMMyrb8xxPeTFA8oFxxkfcako3w0kOjTvA==
X-Received: by 2002:a63:1f16:: with SMTP id f22mr20194293pgf.2.1580153895169;
        Mon, 27 Jan 2020 11:38:15 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::11c2? ([2620:10d:c090:180::dec1])
        by smtp.gmail.com with ESMTPSA id l14sm16224361pjq.5.2020.01.27.11.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 11:38:14 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver changes for 5.6-rc
Message-ID: <d6948ecb-b1c2-9822-307a-a2dd52cf6759@kernel.dk>
Date:   Mon, 27 Jan 2020 12:38:13 -0700
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

On top of the core changes, though not even strictly needed this time as
they are no dependencies, here are the block driver changes queued up
for 5.6. Like the core side, not a lot of changes here, just two main
items:

- Series of patches (via Coly) with fixes for bcache (Coly, Christoph)

- MD pull request from Song

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.6/drivers-2020-01-27


----------------------------------------------------------------
Ben Dooks (Codethink) (1):
      lib: crc64: include <linux/crc64.h> for 'crc64_be'

Christoph Hellwig (6):
      bcache: use a separate data structure for the on-disk super block
      bcache: rework error unwinding in register_bcache
      bcache: transfer the sb_page reference to register_{bdev,cache}
      bcache: return a pointer to the on-disk sb from read_super
      bcache: store a pointer to the on-disk sb in the cache and cached_dev structures
      bcache: use read_cache_page_gfp to read the superblock

Coly Li (7):
      bcache: properly initialize 'path' and 'err' in register_bcache()
      bcache: fix use-after-free in register_bcache()
      bcache: add code comments for state->pool in __btree_sort()
      bcache: avoid unnecessary btree nodes flushing in btree_flush_write()
      bcache: remove member accessed from struct btree
      bcache: reap c->btree_cache_freeable from the tail in bch_mca_scan()
      bcache: reap from tail of c->btree_cache in bch_mca_scan()

Guoju Fang (1):
      bcache: print written and keys in trace_bcache_btree_write

Guoqing Jiang (11):
      raid5: remove worker_cnt_per_group argument from alloc_thread_groups
      md: rename wb stuffs
      md: fix a typo s/creat/create
      md: prepare for enable raid1 io serialization
      md: add serialize_policy sysfs node for raid1
      md: reorgnize mddev_create/destroy_serial_pool
      raid1: serialize the overlap write
      md: don't destroy serial_info_pool if serialize_policy is true
      md: introduce a new struct for IO serialization
      md/raid1: use bucket based mechanism for IO serialization
      md/raid1: introduce wait_for_serialization

Jens Axboe (1):
      Merge branch 'md-next' of git://git.kernel.org/.../song/md into for-5.6/drivers

Liang Chen (1):
      bcache: cached_dev_free needs to put the sb page

Zhengyuan Liu (3):
      raid6/test: fix a compilation error
      raid6/test: fix a compilation warning
      md/raid6: fix algorithm choice under larger PAGE_SIZE

Zhiqiang Liu (1):
      md-bitmap: small cleanups

 drivers/md/bcache/bcache.h    |   2 +
 drivers/md/bcache/bset.c      |   5 +
 drivers/md/bcache/btree.c     |  24 ++--
 drivers/md/bcache/btree.h     |   2 -
 drivers/md/bcache/journal.c   |  80 ++++++++++++-
 drivers/md/bcache/super.c     | 136 +++++++++++-----------
 drivers/md/md-bitmap.c        |  25 ++---
 drivers/md/md.c               | 254 +++++++++++++++++++++++++++++++++---------
 drivers/md/md.h               |  45 +++++---
 drivers/md/raid1.c            | 111 +++++++++---------
 drivers/md/raid5.c            |  21 ++--
 include/linux/raid/pq.h       |   7 +-
 include/trace/events/bcache.h |   3 +-
 include/uapi/linux/bcache.h   |  52 +++++++++
 lib/crc64.c                   |   1 +
 lib/raid6/algos.c             |  63 +++++++----
 lib/raid6/mktables.c          |   2 +-
 17 files changed, 571 insertions(+), 262 deletions(-)

-- 
Jens Axboe

