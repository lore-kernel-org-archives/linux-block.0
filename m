Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572A5C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C0A2075B
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="sBLqmqbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfBKMZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:25:18 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:42690 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfBKMZS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 07:25:18 -0500
Received: by mail-lf1-f54.google.com with SMTP id l10so7548723lfh.9
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 04:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0LmP2Rom2wV5lLYeSlUU4Oq6xb8AnDzQ7AHYtuMInk=;
        b=sBLqmqbjbb57m8IIONvqOU/NsIwNRoytBeUeWO/aVH+cCCtGLWUz2CKDxFH82fl3f1
         PKvfCo2Hk4dB1TGMgwP1sPUbY3fNiq5hc2OxgbGVnTl85J3E2uMrNUitN/4QwwKItt9+
         CbVShIaLangnV/rhdPlB/Sq7CaFZKIIO6qGlCUgQWR92f2TIdpRAE3KzYKZneRHEsiKn
         13Xp3/9fYjU85x+13bpa3aGQIrYDUTlYovjPn1EMK0wmFAr+uXnR44+FGWvXqNXvgGQf
         ERoW7TduI/TBLYnKNUzMXrEf9iq+pmF1AKC/MwkIIsXQMGW7eQArB/vnJD8eXIsE5AVI
         iMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0LmP2Rom2wV5lLYeSlUU4Oq6xb8AnDzQ7AHYtuMInk=;
        b=EkNRqpgzTjIPPyYiMuqYBIWqvhog/VofPpvMkiyfRbFYmGv78tOt1obBCezUF2AFTp
         h8430bxVwzNC3TDpk2w12XkDHDF4eqFEx7hq/ovSlOfLPWAy3I3jG3VfhHJuzmCunTEn
         opj8ck+RqRB3uvMlA73M0paMAjkSPGIgP1pcG/tw93NBporOkMcyypaztQJ0tpNcWIzb
         vt3VsWpnY6MYq00wS7Z/3FneZbpQV0aAb+yIi9shVv2oKyLNshSm39/MVKH3jQeFjLVP
         IYXdFhoBZlIldHVDmBnorM8M+5bhAJYy/UhKP1UdYlEkgFOyPvgvnZGUc5aCKeTGGG9d
         DBIg==
X-Gm-Message-State: AHQUAuY/v2VQniU5otrb2XDIZpRXcqCOulkwQdQlu33xW0p9xzfCHIjA
        3DDduzlj1AHfxoD9RncYxBYJUQ==
X-Google-Smtp-Source: AHgI3IZNWPr+0CXVF4PNxZnNeBPUB4tSsn4c6Ttbrt4OSQf5iYLz8Ux0jff2pEkWEAKaevZ9FjFF+g==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr19686766lfe.45.1549887915793;
        Mon, 11 Feb 2019 04:25:15 -0800 (PST)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id d70sm2278481lfe.14.2019.02.11.04.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:25:14 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 0/8] lightnvm updates for 5.1
Date:   Mon, 11 Feb 2019 13:25:01 +0100
Message-Id: <20190211122509.19910-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Would you please pick up the following patches for 5.1?

It is a bunch of misc patches this time. A couple of fixes and cleanups.

Andy Shevchenko (2):
  lightnvm: Use u64 instead of __le64 for CPU visible side
  lightnvm: pblk: Switch to use new generic UUID API

Hans Holmberg (3):
  lightnvm: pblk: stop taking the free lock in in pblk_lines_free
  lightnvm: pblk: use vfree to free metadata on error path
  lightnvm: pblk: extend line wp balance check

Heiner Litz (1):
  lightnvm: pblk: fix race condition on GC

Javier González (1):
  lightnvm: pblk: prevent stall due to wb threshold

Masahiro Yamada (1):
  lightnvm: pblk: fix TRACE_INCLUDE_PATH

 drivers/lightnvm/pblk-core.c     |  8 ++--
 drivers/lightnvm/pblk-gc.c       | 22 +++++++----
 drivers/lightnvm/pblk-init.c     |  4 +-
 drivers/lightnvm/pblk-map.c      |  1 +
 drivers/lightnvm/pblk-rb.c       | 26 ++++++++++---
 drivers/lightnvm/pblk-recovery.c | 64 +++++++++++++++++++++-----------
 drivers/lightnvm/pblk-rl.c       |  5 +--
 drivers/lightnvm/pblk-trace.h    |  2 +-
 drivers/lightnvm/pblk-write.c    |  1 +
 drivers/lightnvm/pblk.h          | 17 +++------
 10 files changed, 93 insertions(+), 57 deletions(-)

-- 
2.19.1

