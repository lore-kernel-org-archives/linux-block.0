Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C8EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 17:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFOR5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFOR5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 13:57:22 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631CB13E
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 10:56:33 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-75d528d0811so349642685a.0
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 10:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686851792; x=1689443792;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ux3LNqHXiVRVHHXI1YrGB67pM2l99TmywKdYzW7u9cw=;
        b=lVEwLz3FtGzcgpVHBXmZhcBlun7KLja962fqFIwmX3UYV577KGuYMmVTXXoZ9XVHzq
         Xzc4SyUuM+guBa3I4jipCdiD4OfcNerhsn+/CBcc5yWIiOaCbqQApx4ekDSEvLjuxV4L
         IX1Y3yj29nqModJ37s1nJDaLA5Bx0QpWlJsRLBYIM0An46xynk6b2Ohrc+wHJ8hLRgKz
         ejRDkgu7murI3GGHU5r2JF56jaTn+VstqX5ML0AuKj4Ue+vTDnLW1QepPBFx5KJn1LfD
         6tHrLlOFqesrl/UmW8daeNzkjhZ1cepw3nEZ3KHCKLKZF1D6VjjgsbdXyeo9Gr2Fek8r
         jTXA==
X-Gm-Message-State: AC+VfDyp1HHoD54CewvQLVXhULjdWwIxYDEZIvvJ3fZfTRStOXY8VnhT
        oLjFwZ/iObltz8xpEGcgKZOo
X-Google-Smtp-Source: ACHHUZ6Op1iJYarJUSJf4VP6LVaDkRcorQ86vr8KhtOl8L0D+NRk4TIHNaHjR7yqwmo6uTLBeO872w==
X-Received: by 2002:a05:6214:20e3:b0:625:775e:8802 with SMTP id 3-20020a05621420e300b00625775e8802mr24344268qvk.18.1686851792526;
        Thu, 15 Jun 2023 10:56:32 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id c17-20020a0ce651000000b00621268e14efsm6009526qvn.55.2023.06.15.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:56:32 -0700 (PDT)
Date:   Thu, 15 Jun 2023 13:56:30 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Li Lingfeng <lilingfeng3@huawei.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [git pull] device mapper fixes for 6.4-rc7
Message-ID: <ZItQzl4ommfR82jP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.4/dm-fixes

for you to fetch changes up to be04c14a1bd262a49e5764e5cf864259b7e740fd:

  dm: use op specific max_sectors when splitting abnormal io (2023-06-15
  12:47:16 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM thinp discard performance regression introduced during 6.4
  merge; where DM core was splitting large discards every 128K
  (max_sectors_kb) rather than every 64M (discard_max_bytes).

- Extend DM core LOCKFS fix, made during 6.4 merge, to also fix race
  between do_mount and dm's do_suspend (in addition to the earlier
  fix's do_mount race with dm's do_resume).

- Fix DM thin metadata operations to first check if the thin-pool is
  in "fail_io" mode; otherwise UAF can occur.

- Fix DM thinp's call to __blkdev_issue_discard to use GFP_NOIO rather
  than GFP_NOWAIT (__blkdev_issue_discard cannot handle NULL return
  from bio_alloc).
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmSLTh0ACgkQxSPxCi2d
A1rmqggAildPKBjT8nqZmU86lpsy60E03OwvBnGPkMF5pjkOUmTjkb5EWVSAmeuO
ojj0pWlC+1ZvVkiDfkWxt0NL/4ETD4q+5oy1ARBcOawPX6bj0eXLoBr6m10b+KOb
mKAoXgYrESEzQ2qPBe4a4Lj3zIBXzXpMpW9TtF23z4HnDpnwpED5xNPWBgiWc3O/
/6MF1ASLp0DWldoL+gmIp9hEzyQzbzgM4uBOGC4UAYk3U1I55qwX6bWDZ9cQNGMh
AqCSrphuKHvbsb31yb1X3hB3g1XbAeSvvcizgFY0g9ZpncddKm5gx0BWVDO7qGBG
UxLIec19kQ2CIEx/QJZIhEjneLlJ/g==
=mME4
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Li Lingfeng (2):
      dm: don't lock fs when the map is NULL during suspend or resume
      dm thin metadata: check fail_io before using data_sm

Mike Snitzer (2):
      dm thin: fix issue_discard to pass GFP_NOIO to __blkdev_issue_discard
      dm: use op specific max_sectors when splitting abnormal io

 drivers/md/dm-ioctl.c         |  5 +----
 drivers/md/dm-thin-metadata.c | 20 ++++++++++++--------
 drivers/md/dm-thin.c          |  3 +--
 drivers/md/dm.c               | 29 ++++++++++++++++++++---------
 4 files changed, 34 insertions(+), 23 deletions(-)
