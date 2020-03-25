Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F919C43331
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B352078A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="CLopwyrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCYNHG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:07:06 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:38412 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727129AbgCYNHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 09:07:05 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 1D9C72E15E0;
        Wed, 25 Mar 2020 16:07:03 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id mcZa33whj9-72YaEGHq;
        Wed, 25 Mar 2020 16:07:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585141623; bh=MmDSH51e7oidVyu0h0NZyr6OzP7Te9DF1c+cTCaNP/Q=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=CLopwyrvQooX+H/lBYtsrKh4IyXX/K3Le0VstZQDxDTkiYJCovjDfeAeeE4eEGjVq
         vsZbRRuDISQmybsJYFwNjIc+0vFt0/0XMgN0nq8r+9N8Fkd5LhS8WFln3iwsbBL+xL
         9de0XUle0711gGZoL2ovn1lU2i22uPKRm/aeXKGk=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8204::1:e])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id cFVHxoSefV-72caHIwA;
        Wed, 25 Mar 2020 16:07:02 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v4 0/3] block/diskstats: more accurate io_ticks and
 optimization
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Date:   Wed, 25 Mar 2020 16:07:01 +0300
Message-ID: <158514148436.7009.1234367408038809210.stgit@buzz>
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
v3: https://lore.kernel.org/lkml/158503038812.1955.7827988255138056389.stgit@buzz/
 * update documentation
 * rebase to current linux-next
 * fix compilation for CONFIG_SMP=n
v4:
 * rebase to for-5.7/block
 * make part_stat_read_all static in block/genhd.c

---

Konstantin Khlebnikov (3):
      block/diskstats: more accurate approximation of io_ticks for slow disks
      block/diskstats: accumulate all per-cpu counters in one pass
      block/diskstats: replace time_in_queue with sum of request times


 Documentation/admin-guide/iostats.rst |    5 +-
 block/bio.c                           |    9 +--
 block/blk-core.c                      |    5 +-
 block/genhd.c                         |  109 +++++++++++++++++++++++----------
 include/linux/genhd.h                 |    6 --
 5 files changed, 88 insertions(+), 46 deletions(-)

--
Signature
