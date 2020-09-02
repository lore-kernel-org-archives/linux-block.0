Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2167FC433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0EB206EB
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 18:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtMa+Ddv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgIBSCy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgIBSCv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 14:02:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3C3C061247
        for <linux-block@vger.kernel.org>; Wed,  2 Sep 2020 11:02:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so502649qke.12
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vIBmK6vhWxHKs0ESDe7uLeTvdWL4ZGeuqEYmWXXwi70=;
        b=XtMa+DdvvfIEqcBTjAdt2A/srePqSVhE7u/05tBy2zK091Utupe5n7cJvIaQCWomLm
         DBnGBCclQpFoFWmfbmraXatp4c7vmdKro6TKJL7r6Q46O8PT55MzTFljP81yRVChOEDL
         vW0AS+oMhYSt1YxCmtTL4V7AXWfNfGHroJKW42Y1AO9AkQg2M14Ghi4BfnxrWFHoD+/f
         j6C2oHRMNfs+lvENIsVowmbAHaVchXQMCIHr+2PrenTx0GfnWL9THSf53U1PvjWnUNu1
         SJ5QtfgloWuQnDSDHexlwmT+K6fePie4sJSijIXgH4eR1AVNJ9oW+l29QwAh4d10K9/G
         LxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=vIBmK6vhWxHKs0ESDe7uLeTvdWL4ZGeuqEYmWXXwi70=;
        b=sNatpQTdtpxp1RUR/yXpOC4amKwKDJRwCUZXYHMD0fVkyppntc4fX7j7JE+VMGbi8C
         oeAewN9r+r5+MoMaHEAW0PFKF3WOHml553nnKzMw/Af9MIrbZMb9NAUO6HMnPotMqIGr
         eKwmWkuxhMYjc9pbv0DOtxBkwayo2K0/VTueJaW01wgznI4UPhlTTzDynYPl2hKqL/LG
         KxKF1bbxNUqYYBQ9H/48PuDHIllWGrHb1HLHTNfQtJzmHqqPx2iqoCLoYfqxJpcoa99e
         TmP+Pp1TlXx6qaHWg1NgfBqcPHJvl2W6Uqm1ghheKM5bMRa3nEWPQqVlcUEqdUL+SVjM
         gJKw==
X-Gm-Message-State: AOAM531llffRnjb6CA04Uk5NemeHMYlttboSaQrjKG83X0sBnU9y7ksJ
        khwrOGg4pF3haw80lv6J+8Y=
X-Google-Smtp-Source: ABdhPJxh4bvVqdx4jTSEyzKQqDoihYZ1SjWbcCZtlvmyVjXHii7UmKhk8J7z1pGn28RKclTIuz6+Bw==
X-Received: by 2002:a05:620a:1025:: with SMTP id a5mr8206499qkk.490.1599069770211;
        Wed, 02 Sep 2020 11:02:50 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id i7sm246793qkb.131.2020.09.02.11.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 11:02:49 -0700 (PDT)
Date:   Wed, 2 Sep 2020 14:02:48 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ye Bin <yebin10@huawei.com>
Subject: [git pull] device mapper fixes for 5.9-rc4
Message-ID: <20200902180248.GA32957@lobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-fixes

for you to fetch changes up to 3a653b205f29b3f9827a01a0c88bfbcb0d169494:

  dm thin metadata: Fix use-after-free in dm_bm_set_read_only (2020-09-02 13:38:40 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- DM writecache fix to allow dax_direct_access() to partitioned pmem
  devices.

- DM multipath fix to avoid any Path Group initialization if
  'pg_init_in_progress' isn't set.

- DM crypt fix to use DECLARE_CRYPTO_WAIT() for onstack wait
  structures.

- DM integrity fix to properly check integrity after device creation
  when in bitmap mode.

- DM thinp and cache target __create_persistent_data_objects() fixes
  to reset the metadata's dm_block_manager pointer from PTR_ERR to
  NULL before returning from error path.

- DM persistent-data block manager fix to guard against
  dm_block_manager NULL pointer dereference in dm_bm_is_read_only()
  and update various opencoded bm->read_only checks to use
  dm_bm_is_read_only() instead.

----------------------------------------------------------------
Damien Le Moal (1):
      dm crypt: Initialize crypto wait structures

Mike Snitzer (1):
      dm mpath: fix racey management of PG initialization

Mikulas Patocka (2):
      dm writecache: handle DAX to partitions on persistent memory correctly
      dm integrity: fix error reporting in bitmap mode after creation

Ye Bin (3):
      dm cache metadata: Avoid returning cmd->bm wild pointer on error
      dm thin metadata:  Avoid returning cmd->bm wild pointer on error
      dm thin metadata: Fix use-after-free in dm_bm_set_read_only

 drivers/md/dm-cache-metadata.c                |  8 ++++++--
 drivers/md/dm-crypt.c                         |  4 ++--
 drivers/md/dm-integrity.c                     | 12 ++++++++++++
 drivers/md/dm-mpath.c                         | 22 +++++++++++++++-------
 drivers/md/dm-thin-metadata.c                 | 10 +++++++---
 drivers/md/dm-writecache.c                    | 12 ++++++++++--
 drivers/md/persistent-data/dm-block-manager.c | 14 ++++++++------
 7 files changed, 60 insertions(+), 22 deletions(-)
