Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEFFC10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 21:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5963520880
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 21:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="E0xCPl0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDOVU1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:20:27 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:30176 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfDOVU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 17:20:27 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 17:20:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=404; q=dns/txt; s=iport;
  t=1555363227; x=1556572827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f/WdhfG3pTiRRVi/EJOmdgVJ9y2tz3vO4Xc70lk4d9o=;
  b=E0xCPl0jkp7sU7gur67dR/P1/f7ZSIM34CzTWbKBn/SAFmcen4QbHolf
   rxzj+0/HcDT4aiqDrK9esYo37EUdqWvpQGb3q8eZ/2BHT9R485G37Y2ex
   z3wynysWT80tMZNP+LUFLBHthX4X+YoUahf8n1K1dC+fYP3KU0eQbzbig
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AHAAA687Rc/5RdJa1mGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGCEIFsjFKWY48BgXsQhG0ChXojNAkOAQMBAQo?=
 =?us-ascii?q?BAgECbSiFSwYyAUYQUVcHgzSBdRMBqn+KLhSBHgGGc4RWF4FAP4RhiiUDima?=
 =?us-ascii?q?IImCSSgmCB5ILDBqBeAGSeQEtizmUQ4FPOIFWcBWDKJBrH45TKoIoAQE?=
X-IronPort-AV: E=Sophos;i="5.60,355,1549929600"; 
   d="scan'208";a="536758931"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Apr 2019 21:13:22 +0000
Received: from sjc-ads-2720.cisco.com (sjc-ads-2720.cisco.com [171.70.32.155])
        by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTP id x3FLDLDD014016;
        Mon, 15 Apr 2019 21:13:21 GMT
From:   grygorii tertychnyi <gtertych@cisco.com>
To:     jaegeuk@kernel.org, gwendal@chromium.org
Cc:     xe-linux-external@cisco.com, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] loop: drop caches if offset or block_size are changed
Date:   Mon, 15 Apr 2019 14:13:21 -0700
Message-Id: <20190415211321.58681-1-gtertych@cisco.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <CAPUE2uushZ3Zc6mt01q3OkSx63YmQLq7SKqAktdZVnrb9bVnHA@mail.gmail.com>
References: <CAPUE2uushZ3Zc6mt01q3OkSx63YmQLq7SKqAktdZVnrb9bVnHA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.32.155, sjc-ads-2720.cisco.com
X-Outbound-Node: rcdn-core-12.cisco.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jaegeuk,

We also observed an issue with this patch.

After heavely working with image.bin (haxdump with different offsets)
next mount call fails:

# mount -o ro,loop,offset=45967633 -t squashfs image.bin /tmp/gi45
mount: image.bin: failed to setup loop device: Resource temporarily unavailable

# dmesg | tail -n1
loop_set_status: loop2 () has still dirty pages (nrpages=1)


-- Grygorii
