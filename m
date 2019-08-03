Return-Path: <SRS0=u38M=V7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D1C433FF
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE85521783
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbfHCIpy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Aug 2019 04:45:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbfHCIpy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 3 Aug 2019 04:45:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4EFB307D970;
        Sat,  3 Aug 2019 08:45:53 +0000 (UTC)
Received: from localhost (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E679E608C2;
        Sat,  3 Aug 2019 08:45:50 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 0/4] spec: rpmlint fixes in preparation for Fedora packaging
Date:   Sat,  3 Aug 2019 09:45:22 +0100
Message-Id: <20190803084526.3837-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sat, 03 Aug 2019 08:45:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series addresses the remaining rpm issues that I'm aware of.

Jens: Once the patches are merged and you publish a 0.1 release tag I could
roll the first liburing rpm for Fedora.  liburing itself is in good shape for
wider consumption but maybe it makes sense to wait for kernel issues to settle.
There are qemu-iotests failures that are probably kernel bugs (hopefully known
ones!) and will be investigated soon.

Stefan Hajnoczi (4):
  COPYING: update to latest LGPL v2.1 text
  spec: use Fedora "LGPLv2+" license identifier
  spec: add URL tag
  spec: fix <liburing/*.h> permissions

 COPYING       | 79 +++++++++++++++++++++------------------------------
 liburing.spec |  5 ++--
 2 files changed, 36 insertions(+), 48 deletions(-)

-- 
2.21.0

