Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E62C3F6B0
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbiHETKz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Aug 2022 15:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbiHETKy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Aug 2022 15:10:54 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60802D106
        for <linux-block@vger.kernel.org>; Fri,  5 Aug 2022 12:10:53 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id v1so2526772qkg.11
        for <linux-block@vger.kernel.org>; Fri, 05 Aug 2022 12:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=M9gX/uf12sWsOSRDHrNVPPG966ZdqGBVh/pkIWrHveQ=;
        b=VwE8xOmN8aCY6Wsxz87izWUvMfEO/5Bu+9zEJwu6R4EEOyVEe3gLJX6l1jWI58Qliz
         /fhYfY2QqwDb21MGI5SK0Gxvqp2NYQsZ4lZvpbq8gWO/RzlgGp+yrEkGcceYZTgcr6J1
         P4gQhQYHn7HFRS0w9w+pVczN4ZVhzMU68yr8MrUiltww90DmRcQAwfba4CF6DVd322UN
         aMVBdmnWiWf2RzDP4nuSkdiVcmdKdtYCmMF52kNUvya5Z+iobwmmjLeKrU3K67yr1CwE
         tYwi5p/K2Uwt8W5i1TQOohicsJHdzzycXaK7ST+8cxbi0Cpx3qqNk2ZwFFyRhaUof4h0
         5uzg==
X-Gm-Message-State: ACgBeo1ci4S7ZVrwTYvFzBSXJduy/qcdee7hqrxwJOIqLD5+w6rqZeK0
        tLMNlILmy1uQzQgzJqBiCzsl
X-Google-Smtp-Source: AA6agR4BAS+hM+EUim+IVcRyzqXoa4HKnh/Tj6GF+O0Vtd8DD4LdM/Qa2nW6CnG7PB2XkzY2m+F19A==
X-Received: by 2002:a05:620a:2545:b0:6b6:6773:f278 with SMTP id s5-20020a05620a254500b006b66773f278mr6337214qko.390.1659726652464;
        Fri, 05 Aug 2022 12:10:52 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id ew7-20020a05622a514700b0031eb65e1cb6sm3124914qtb.5.2022.08.05.12.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 12:10:52 -0700 (PDT)
Date:   Fri, 5 Aug 2022 15:10:50 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [git pull] Additional device mapper changes for 6.0
Message-ID: <Yu1rOopN++GWylUi@redhat.com>
References: <YugiaQ1TO+vT1FQ5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YugiaQ1TO+vT1FQ5@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

In my previous 6.0 pull request I should have forecast the potential
for sending another one.

The changes in this pull request add an optional feature to the DM 
verity target. These changes were proposed for inclussion on dm-devel
a couple weeks before the merge window opened. I reviewed and worked
the changes with Nathan and others for about a week. At that time the
changes still had some clear issues (exposed with the additional
testing Milan Broz provided in terms of a revised cryptsetup testsuite
that introduced veritysetup's --use-tasklets). I had to put it aside
once this merge window opened but Nathan continued to investigate.

Nathan found and fixed the remaining issues on Tuesday/Wednesday:
https://listman.redhat.com/archives/dm-devel/2022-August/051766.html 

Yesterday I then folded the fixes in, and refined the code a bit
further in response. The crytpsetup testsuite passes now (both with
and without the use of veritysetup's --use-tasklets flag).

All said: I think it worthwhile to merge these changes for 6.0, rather
than hold until 6.1, now that we have confidence this _optional_ DM
verity feature is working as expected. Please be aware there was a
small linux-next merge fixup needed:
https://lore.kernel.org/all/20220805125744.475531-1-broonie@kernel.org/T/

The following changes since commit 9dd1cd3220eca534f2d47afad7ce85f4c40118d8:

  dm: fix dm-raid crash if md_handle_request() splits bio (2022-07-28 17:36:30 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.0/dm-changes-2

for you to fetch changes up to 12907efde6ad984f2d76cc1a7dbaae132384d8a5:

  dm verity: have verify_wq use WQ_HIGHPRI if "try_verify_in_tasklet" (2022-08-04 15:59:52 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Add flags argument to dm_bufio_client_create and introduce
  DM_BUFIO_CLIENT_NO_SLEEP flag to have dm-bufio use spinlock rather
  than mutex for its locking.

- Add optional "try_verify_in_tasklet" feature to DM verity target.
  This feature gives users the option to improve IO latency by using a
  tasklet to verify, using hashes in bufio's cache, rather than wait
  to schedule a work item via workqueue. But if there is a bufio cache
  miss, or an error, then the tasklet will fallback to using workqueue.

- Incremental changes to both dm-bufio and the DM verity target to use
  jump_label to minimize cost of branching associated with the niche
  "try_verify_in_tasklet" feature. DM-bufio in particular is used by
  quite a few other DM targets so it doesn't make sense to incur
  additional bufio cost in those targets purely for the benefit of
  this niche verity feature if the feature isn't ever used.

- Optimize verity_verify_io, which is used by both workqueue and
  tasklet based verification, if FEC is not configured or tasklet
  based verification isn't used.

- Remove DM verity target's verify_wq's use of the WQ_CPU_INTENSIVE
  flag since it uses WQ_UNBOUND. Also, use the WQ_HIGHPRI flag if
  "try_verify_in_tasklet" is specified.

----------------------------------------------------------------
Mike Snitzer (7):
      dm verity: allow optional args to alter primary args handling
      dm bufio: conditionally enable branching for DM_BUFIO_CLIENT_NO_SLEEP
      dm verity: conditionally enable branching for "try_verify_in_tasklet"
      dm verity: optimize verity_verify_io if FEC not configured
      dm verity: only copy bvec_iter in verity_verify_io if in_tasklet
      dm verity: remove WQ_CPU_INTENSIVE flag since using WQ_UNBOUND
      dm verity: have verify_wq use WQ_HIGHPRI if "try_verify_in_tasklet"

Nathan Huckleberry (3):
      dm bufio: Add flags argument to dm_bufio_client_create
      dm bufio: Add DM_BUFIO_CLIENT_NO_SLEEP flag
      dm verity: Add optional "try_verify_in_tasklet" feature

 drivers/md/dm-bufio.c                         |  32 +++++-
 drivers/md/dm-ebs-target.c                    |   3 +-
 drivers/md/dm-integrity.c                     |   2 +-
 drivers/md/dm-snap-persistent.c               |   2 +-
 drivers/md/dm-verity-fec.c                    |   4 +-
 drivers/md/dm-verity-target.c                 | 160 ++++++++++++++++++++++----
 drivers/md/dm-verity.h                        |   6 +-
 drivers/md/persistent-data/dm-block-manager.c |   3 +-
 include/linux/dm-bufio.h                      |   8 +-
 9 files changed, 187 insertions(+), 33 deletions(-)
