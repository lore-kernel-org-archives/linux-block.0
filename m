Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C214AC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFE820679
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="GNme8U1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFAMhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgFAMhO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 08:37:14 -0400
X-Greylist: delayed 71854 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Jun 2020 05:37:14 PDT
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B6EC061A0E;
        Mon,  1 Jun 2020 05:37:14 -0700 (PDT)
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 8F31B2E1545;
        Mon,  1 Jun 2020 15:37:08 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id Arbn6tmlSd-b7e8sZjq;
        Mon, 01 Jun 2020 15:37:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591015028; bh=G1tdKoEj5u0IeOvuwPmSyZ1Bkd4kxnX5aPNmkUwjLXg=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=GNme8U1iVUNzLFv3VQ/8pUjwIRyMDa68Y4N5sYHj0hsv80d2qzR3ZNhZEXmve/PZV
         Tdb8d84s142zV2R1Vt4L7wNqWrkbgoTkN0EGF5j2D55QHKWFLfh48UXnxszQt38UIf
         39NVnFdD9itz94WfJwLcNaGNaOlANazfMCXL1ZtY=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:6420::1:8])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Ol7mDqdGP7-b1WG8Prs;
        Mon, 01 Jun 2020 15:37:01 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 0/3] block: allow REQ_NOWAIT to some bio-based/stacked
 devices
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>
Date:   Mon, 01 Jun 2020 15:37:01 +0300
Message-ID: <159101473169.180989.12175693728191972447.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here is pretty straight forward attempt of handling REQ_NOWAIT for
bio-based and stacked devices.

They are marked with flag queue->limits.nowait_requests which tells that
queue method make_request() handles REQ_NOWAIT or doesn't delay requests,
and all backend devices do the same.

As a example second/third patches add support into md-raid0 and dm-linear.

---

Konstantin Khlebnikov (3):
      block: add flag 'nowait_requests' into queue limits
      md/raid0: enable REQ_NOWAIT
      dm: add support for REQ_NOWAIT and enable for target dm-linear


 drivers/md/dm-linear.c        | 5 +++--
 drivers/md/dm-table.c         | 3 +++
 drivers/md/dm.c               | 4 +++-
 drivers/md/raid0.c            | 3 +++
 include/linux/device-mapper.h | 6 ++++++
 5 files changed, 18 insertions(+), 3 deletions(-)

--
Signature
