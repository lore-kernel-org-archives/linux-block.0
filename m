Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0631C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 06:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B3A20714
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 06:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="JSTt9akt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCXGjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:39:42 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:45004 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgCXGjm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 02:39:42 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 89E032E132A;
        Tue, 24 Mar 2020 09:39:39 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id vElDNcnrnr-ddNSsLOn;
        Tue, 24 Mar 2020 09:39:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585031979; bh=DOHGkNP9wh1iO1J5OIkX8CL+OdPnCkXwDuHeEIAWHT0=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=JSTt9aktxoPRYRmgSYFdRM5tFN6PKg+ZRu3ARvNyAM97e7Ov0AgQuUcLOSMVBIiwq
         hzQSIG+dVrhQDphHO6d+jH2NavydF21wKHdQYH/lNe13KhIbFj5EiZPmouxcQm18jE
         rdJlOqStlp1n+DBUT7ZTwn65PGeEgOU4qhY72GjQ=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6410::1:2])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id LXCZcZNDPq-dcbO1YeB;
        Tue, 24 Mar 2020 09:39:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v3 0/3] block/diskstats: more accurate io_ticks and
 optimization
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Date:   Tue, 24 Mar 2020 09:39:38 +0300
Message-ID: <158503038812.1955.7827988255138056389.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simplified estimation for io_ticks introduced in patch
https://lore.kernel.org/linux-block/20181206164122.2166-5-snitzer@redhat.com/
could be very inaccurate for request longer than jiffy (i.e. any HDD)

There is at least one another report about this:
https://lore.kernel.org/linux-block/20200324031942.GA3060@ming.t460p/
See detail in comment for first patch.

v1: https://lore.kernel.org/lkml/155413438394.3201.15211440151043943989.stgit@buzz/
v2: https://lore.kernel.org/lkml/158314549775.1788.6529015932237292177.stgit@buzz/
v3:
 * update documentation
 * rebase to current linux-next
 * fix compilation for CONFIG_SMP=n

---

Konstantin Khlebnikov (3):
      block/diskstats: more accurate approximation of io_ticks for slow disks
      block/diskstats: accumulate all per-cpu counters in one pass
      block/diskstats: replace time_in_queue with sum of request times


 Documentation/admin-guide/iostats.rst |    5 ++-
 block/bio.c                           |    9 ++---
 block/blk-core.c                      |    5 +--
 block/genhd.c                         |   64 +++++++++++++++++++++++++--------
 block/partition-generic.c             |   39 ++++++++++++--------
 include/linux/genhd.h                 |   14 +++++--
 6 files changed, 90 insertions(+), 46 deletions(-)

--
Signature
