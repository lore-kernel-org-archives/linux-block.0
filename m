Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D40C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 17:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbhLPRtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 12:49:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240407AbhLPRtU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 12:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639676959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Uus2LlgeYJCvwWfnb8E4TOJ1KGMOueUkeobkNgmBkvc=;
        b=Obc1bN4k6kJjuyOqmZTvIfVXpThoYEozAgcnkKheE43VSHbHbOf2XkClGLNxm6CZmCPMTv
        a1eYD7bJKgWBv3qE55jBW5Jar5smtJ7jxd4s0hndnP9n5FnHT9OCBkL2JEElnmTZ+X2pHA
        F+XNsJDM8DyOhYEADnpfjGcakxPFr2g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-a9LethoDN0Gulrekocs_Kw-1; Thu, 16 Dec 2021 12:49:18 -0500
X-MC-Unique: a9LethoDN0Gulrekocs_Kw-1
Received: by mail-qk1-f197.google.com with SMTP id c1-20020a05620a0ce100b00468060d41ecso21181851qkj.19
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 09:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Uus2LlgeYJCvwWfnb8E4TOJ1KGMOueUkeobkNgmBkvc=;
        b=sLBRIrkHel7wsCL+mIoWLfX1i4xLwIk67IPns4P4NEOCOaumYFBqtTU2rhpyE5Gk+x
         VWN546EzCKMEe2wfQ0W8Px8v47fn62ZjIf/Gjuz6Q89JY47q6cczS6oGO2ODoRwk7r53
         P6rbTuARSLJ74wKPgASv6iiWxZ9buwm2642MuLOYPNt1VL6OCzvmdX53ULN8mtuYdkEI
         GvlNK3FKNcDY9HhMxva5EqK8KLwgV9PEJDrCS9zlPumK5WoGWhLt2c1njfcaBZZgCTIu
         nYnudfW4VziWz9KH/Lc+v9nsmSjS0pkCIz3I7KNJbjCIvSiUSmP1aWDm+3eTAVv2VYOd
         uZqw==
X-Gm-Message-State: AOAM531Q3m4gKioLxxt0NPtbzK2jfGShkDT4P1K8sK03px877Am2SIFx
        VHW0DObbu/k5fnurZcQ4HaKnJcHChpSf3ALqmi6FwM0dEjah/oC92UIQlNhW5xhjZqQYwdLZHJe
        TsgUSAFQYDbvdbZhjKAjSVw==
X-Received: by 2002:a05:6214:21e8:: with SMTP id p8mr3290972qvj.99.1639676957910;
        Thu, 16 Dec 2021 09:49:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfr9CXl+tDzP8DP1paHbyAMY7lcF94YJrxp3xBRUedepEpRuRV2qjHKsXyT4vNfpZctqGQRQ==
X-Received: by 2002:a05:6214:21e8:: with SMTP id p8mr3290965qvj.99.1639676957735;
        Thu, 16 Dec 2021 09:49:17 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id bm35sm3169317qkb.86.2021.12.16.09.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:49:17 -0800 (PST)
Date:   Thu, 16 Dec 2021 12:49:16 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Joe Thornber <ejt@redhat.com>
Subject: [git pull] device mapper fixes for 5.16-rc6
Message-ID: <Ybt8HMQUZn7mlvTG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.16/dm-fixes

for you to fetch changes up to 1cef171abd39102dcc862c6bfbf7f954f4f1f66f:

  dm integrity: fix data corruption due to improper use of bvec_kmap_local (2021-12-15 14:16:35 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix use after free in DM btree remove's rebalance_children().

- Fix DM integrity data corruption, introduced during 5.16 merge, due
  to improper use of bvec_kmap_local().

----------------------------------------------------------------
Joe Thornber (1):
      dm btree remove: fix use after free in rebalance_children()

Mike Snitzer (1):
      dm integrity: fix data corruption due to improper use of bvec_kmap_local

 drivers/md/dm-integrity.c                    | 2 +-
 drivers/md/persistent-data/dm-btree-remove.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

