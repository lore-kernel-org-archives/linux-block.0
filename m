Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C117C433F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 16:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355200AbiALQYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 11:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355168AbiALQYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 11:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642004674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=K9t/QyNYgC/u/98MlWWWeCxOnDJcq4vk+x/vzUZHkCI=;
        b=ZlBDcPLceEFVOoVLZ/GL1Er2O7mMf1UhrzPZiMuIUg2AeVlEtjGoUNqHlqYAc5UwwK/BWy
        1Kc6yLhOgkqW/flJlXUWj1pPoyWQRKmpy6m2xhVAA4zBfjrF3DtCsAEHpZFL05BhRehoXD
        7grtqxQq9f+8dZRrM5gVvDBapBxJTkY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-U6hRQ35aO6aEeDxS3qWRvA-1; Wed, 12 Jan 2022 11:24:31 -0500
X-MC-Unique: U6hRQ35aO6aEeDxS3qWRvA-1
Received: by mail-qk1-f200.google.com with SMTP id y21-20020a05620a09d500b004776ac05419so2203852qky.6
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 08:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=K9t/QyNYgC/u/98MlWWWeCxOnDJcq4vk+x/vzUZHkCI=;
        b=FXmdUGg4sJLG9Wn3CRyrsfxuiektSXFQeX+C69F6htyvrREjn+d5jqgCenE7zA6Iss
         GydJnpTLGiJY2rcRgxq5t9IUiyJe32w/Se10QaduZw3u9JlSZiF8V0nrDA+KI1XjstAN
         Xh3xgHDmtBSoxpUMKyiZtOkpn9labX/MrtwHGCoLzYLXnCgyNiL+5ayxWLt/Ngmin6Nu
         gRmrkBzenu/DAGeFOoa7Hyh3bDJbbAu6whsP3oDHZcvTSK7CZElq9rbkzgAgpG7oTCjW
         5TlisXseUEi+8Ep3RXFcs5kDn8grIfzlpH+q8vhxkRYt41OyNPYNsXhYem16wCdlMzSj
         4GzQ==
X-Gm-Message-State: AOAM533UnuqxlXYvilychWwRnAdABki7CJt/K1XnsrSz2RHTRh/ekD+w
        YqVKGB1cwuuOsr6qUUglXkVRmbWMpNG5Ndk+JBg1wWRfg/4VVqO+K9xp9pW9dzlp9WjvynYGp1e
        vZlEqfS7g7bIIULnkqD87yQ==
X-Received: by 2002:a05:620a:470f:: with SMTP id bs15mr374249qkb.246.1642004671151;
        Wed, 12 Jan 2022 08:24:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8lSelr28m+//ajK7hUfZdmxYtAbWM43Sg5O0Q8BHEHnwkIhq2Wfe+hTeXjlnWzzmTLTQy7w==
X-Received: by 2002:a05:620a:470f:: with SMTP id bs15mr374235qkb.246.1642004670915;
        Wed, 12 Jan 2022 08:24:30 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d17sm132541qtx.96.2022.01.12.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 08:24:30 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:24:29 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Thornber <ejt@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [git pull] device mapper changes for 5.17
Message-ID: <Yd8AveH8D+Nk2ILp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

  Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.17/dm-changes

for you to fetch changes up to eaac0b590a47c717ef36cbfd1c528cd154c965a1:

  dm sysfs: use default_groups in kobj_type (2022-01-06 09:48:55 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fixes and improvements to dm btree and dm space map code in
  persistent-data library used by thinp and cache.

- Update DM integrity to use struct_group() to zero struct
  journal_sector.

- Update DM sysfs to use default_groups in kobj_type.

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      dm sysfs: use default_groups in kobj_type

Joe Thornber (5):
      dm btree spine: remove extra node_check function declaration
      dm btree spine: eliminate duplicate le32_to_cpu() in node_check()
      dm btree remove: change a bunch of BUG_ON() calls to proper errors
      dm btree: add a defensive bounds check to insert_at()
      dm space map common: add bounds check to sm_ll_lookup_bitmap()

Kees Cook (1):
      dm integrity: Use struct_group() to zero struct journal_sector

 drivers/md/dm-integrity.c                        |   9 +-
 drivers/md/dm-sysfs.c                            |   3 +-
 drivers/md/persistent-data/dm-btree-remove.c     | 173 ++++++++++++++++-------
 drivers/md/persistent-data/dm-btree-spine.c      |  12 +-
 drivers/md/persistent-data/dm-btree.c            |   8 +-
 drivers/md/persistent-data/dm-space-map-common.c |   5 +
 6 files changed, 145 insertions(+), 65 deletions(-)

