Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08899C433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D7B20838
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 08:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g5lOD2we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgHMIMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:12:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:59253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMIMM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 04:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597306330;
        bh=4jlBCMFtOfsc6uVGBmGE+OxhxOL92xWXiRzZtd+7SAU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=g5lOD2weZwVhnZwhIOnnqCWna3qbLxChWesJB9U41bYW6M7M5KMro84vWTwLa9ltp
         Gj5ZSMPeVCVtgQjD+8hgOqBgSl3gTD5c7+1FBWCZlqV3D/xBmqgEQU0iSMrXfs6PEo
         SgwxmPHy6VnXC+aoz6rrRGB7zsFHi3QZ+aCsW0iw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls00508.pb.local ([62.217.45.26]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiDd-1kLB143Tvr-00QEYA; Thu, 13
 Aug 2020 10:12:09 +0200
From:   Guoqing Jiang <guoqing.jiang@gmx.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     jinpu.wang@cloud.ionos.com, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V3 0/4] block: add two statistic tables
Date:   Thu, 13 Aug 2020 10:11:23 +0200
Message-Id: <20200813081127.4914-1-guoqing.jiang@gmx.com>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:3rgowWQiUhK/qb+O1Cjn1J8m4iIZGdIMbNLuR9qzSqnDrFY9UIL
 RUBF1RZ1MUiK5pEysij2hmkLSiRtRPUd/TVhqNZdSUwRd2dejbFjFi0oE5JeQFKoni8rBSC
 RvBoF/IzhZhuamuhTWABth3kkV5Qpco3BK9+2VOTlGE3fALf5iRFZ69tUEsvk2Oo5UgMifS
 aXm330TYgQK/rds4tw1sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kxd4XBIysF8=:E50jQb3niVrcMZcr+fw0Np
 9RIWgOkc8abVn8/MHtv6myqwxG5yAyGZXhKy4VJzyyBRhIuwCtCIUOyfxXWwrKwYsjmF4qCY4
 MRbWcfHNQwtdwn53t8uauT3bsD/wy7Hm4f5J1176eD2uNwNJGfp5D7PSr3fkPjxLdERyZk/SH
 igD6/V++0+jKMD/0Zjlxq1U87/8wCzJyDeRe4UW4CSOb41jxTjs8YQZxcTjaiPXu0ym6pbKOd
 O012kPOHSHe/OoLWnFac0WtTW4RUDr+5VOGJyyhyg0bN63S5+/VZ/FapzEmK8UquFU/UYMrVi
 pqtTLzicJh5E9rXPKBOOhjjkOlxzr2KiO4WX2mdYBS/9voLSCGu7L/i097xerwuwrdyhcgpb3
 +X1Bg5CqgeSAuRXVoWhl6Jiumb2Kf4OwFithbWOxtcTS+i2PtwSiE0qa6wjLmb6ENaGAoCB7O
 BIpLkPiOl+Hea6t46Y25ZXMq1H1NAynn6FGTMZVDH3B8+00YqzZjCBEdzLHuE3FKQTbvfAum9
 XFtrHy6QEDS7Z1VVBWSFKAOJoMKjuazRs19AND8hSJquAGQpSeG3Mu/sHwGOkpShFM6xPrXwz
 mD6X/bUbjgFBwRMyqJzTY+C/m6FgQffBy4RjxdXSUze6vIUEto3JD41X3MzTMZL5/SBqAYvia
 w/UNmPEczRMeLgjALFzXS9YGhSsTl5ZyHNahKNvCE380C0RYNLYHlyFmDB/QDGDCy9i0NSM/w
 p3LKyiKdl3LYGfBWRVqZ2jnb2ioGzRjsuS3HXi4vwoyv8me4dlxrm+O6n7DgQ+1ypm7wyYEEJ
 /UHgUmEYnPiBWMKMShB0NeHwHOMwcD5+oHe80hD/TlmENYCwHOwXAmSGz2rcZS+MduK/GKyGq
 IpYYl2gP4TS3LebXUhLf3Hl5n4tfrll73eETOlARmHb7zlJbOcrQRyP+0d5w1gxcJvxzWcm+v
 TSubX/87wzQqr/8RjQiUtxGAlIvewyL1EXLX9Mt0xyll82j54FyUro1FpYNbc6uK+/zQK0UNk
 rqTZ+Yer/clzSXXXDnwqVV1XP4VkvEw6ojThtummjlllQ2PCpXmiwuNlatldVh03dJpxELKY+
 tiCyx3VkTolHGUopR4VP7+E6aB8Jw8jcIpQxuS8crqAwTtOh1QS3NL/1X3rDyyZeJzX+K+RDf
 GuB7liBmvM4PUExWhJDj7TPPjSgUjcjMDY0QTZq//2ZpalvalfpsQqCklCCUmmqQjQaYpHg7+
 +5t1QP4KKWThyRVBU7qlnuBvPcmtqVo9xoJ4lQA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Hi,

This version has below changes:

* Move the #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT into the function body
  per Johannes's comment.

* Tweak the output of two tables to make they are more intuitive. See
  below io_size table, and io_latency table replaces KB with ms.
# cat /sys/block/md0/io_size
[    0 - 1    ) KB: 0 0 0 0
[    1 - 2    ) KB: 0 0 0 0
[    2 - 4    ) KB: 0 0 0 0
[    4 - 8    ) KB: 0 0 0 0
[    8 - 16   ) KB: 0 0 0 0
[   16 - 32   ) KB: 0 0 0 0
[   32 - 64   ) KB: 0 0 0 0
[   64 - 128  ) KB: 0 0 0 0
[  128 - 256  ) KB: 0 0 0 0
[  256 - 512  ) KB: 0 0 0 0
[  512 - 1024 ) KB: 0 0 0 0
      >=3D 1024   KB: 0 0 0 0

Thanks,
Guoqing

RFC V2: https://marc.info/?l=3Dlinux-block&m=3D159467483514062&w=3D2
* don't call ktime_get_ns and drop unnecessary patches.
* add io_extra_stats to avoid potential overhead.

RFC V1: https://marc.info/?l=3Dlinux-block&m=3D159419516730386&w=3D2

Guoqing Jiang (4):
  block: add a statistic table for io latency
  block: add a statistic table for io sector
  block: add io_extra_stats node
  block: call blk_additional_{latency,sector} only when io_extra_stats
    is true

 Documentation/ABI/testing/sysfs-block | 26 +++++++++
 Documentation/block/queue-sysfs.rst   |  6 +++
 block/Kconfig                         |  9 ++++
 block/blk-core.c                      | 51 ++++++++++++++++++
 block/blk-sysfs.c                     |  8 +++
 block/genhd.c                         | 78 +++++++++++++++++++++++++++
 include/linux/blkdev.h                |  2 +
 include/linux/part_stat.h             |  8 +++
 8 files changed, 188 insertions(+)

=2D-
2.17.1

