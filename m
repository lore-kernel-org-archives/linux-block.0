Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11073C433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbiKRRMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 12:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiKRRMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 12:12:14 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24608C7A6
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 09:11:17 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id h21so3531394qtu.2
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 09:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7+2TgRGIdW1STbzllen0rzoQfGY94f4zA/Ot6KcCYY=;
        b=RMa/41vz26DMSV1Z6ro61QKMmDTqbgeIgRaRx1+uitWma6BZCxkuodYggrEN4EKFO2
         KqndfnRIxSeug2ASERDbeDKNroRqnikcC2KaAY1M9rPQMoaRmIXTMfNvBs4AmWbYP8fF
         Hvj9wry8xQ50Q/0zR2rt1T6rEZEChvI7J0490TbnXMUPL572hEBemnmXe3TiCcqPaY+M
         MV1MZG5jGcLOPEwYzdfEeDDAANDZzPLWFqjFEXNIlNWat7xPEjRPw0PUyJOPrRS/ZDXN
         qeYWTXVSLbLDg8kiK7hAJWUd5z9CIGTV4/87yPuDtPulMxKNcnywQR/syJe6n7kREyRo
         FIPA==
X-Gm-Message-State: ANoB5pnum47eCxHZFRA3iZyLDY5RD31Q7EtOaKY9wmPyS9s6Oc6psb1K
        o/DPMJGv9KFHeVUlXacMy3dL
X-Google-Smtp-Source: AA0mqf40Cb/Q2ArDuq4Sb1wFuRuW0OH54uAPKDI2SSl5r/UBqaSQPi2UcMm7IezJNpSi1Sng79SwDw==
X-Received: by 2002:ac8:5ed5:0:b0:3a4:f479:e147 with SMTP id s21-20020ac85ed5000000b003a4f479e147mr7564332qtx.243.1668791476800;
        Fri, 18 Nov 2022 09:11:16 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bx15-20020a05622a090f00b003a4f22c6507sm2307568qtb.48.2022.11.18.09.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:11:06 -0800 (PST)
Date:   Fri, 18 Nov 2022 12:10:54 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 6.1-rc6
Message-ID: <Y3e8nulXd803OoEn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-fixes-2

for you to fetch changes up to 984bf2cc531e778e49298fdf6730e0396166aa21:

  dm integrity: clear the journal on suspend (2022-11-18 11:05:09 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix misbehavior if list_versions DM ioctl races with module
  loading.

- Fix missing decrement of no_sleep_enabled if dm_bufio_client_create
  failed.

- Allow DM integrity devices to be activated in read-only mode.

----------------------------------------------------------------
Mikulas Patocka (3):
      dm ioctl: fix misbehavior if list_versions races with module loading
      dm integrity: flush the journal on suspend
      dm integrity: clear the journal on suspend

Zhihao Cheng (1):
      dm bufio: Fix missing decrement of no_sleep_enabled if dm_bufio_client_create failed

 drivers/md/dm-bufio.c     |  2 ++
 drivers/md/dm-integrity.c | 20 ++++++++++++++------
 drivers/md/dm-ioctl.c     |  4 ++--
 3 files changed, 18 insertions(+), 8 deletions(-)
