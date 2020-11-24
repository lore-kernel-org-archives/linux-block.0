Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AADC56202
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19FE20721
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfnZCDNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgKXBEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:04:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgKXBEs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 20:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606179887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p0M+h/y/Ebc5H/p0Ytfn7RmBKjXUscZk0DsFDmKY9nU=;
        b=MfnZCDNiClx9n9L8N/p1HvNFLILDSQ+CevUMIVfEpAFQ7rPOrOcwHjkoJ7nH7xK/TzZUjZ
        EcDMx1xZMQ0teBZbnnfEgRczMwbY39tOY8OIRxupP777M5xVsxAYwytKv1ZEo65b7IrK4m
        z0hgOZ2oZSw1Sp1MdRkMoOBTF+WRm4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-7X4qjUAAOjiEEhIXa4Gb0w-1; Mon, 23 Nov 2020 20:04:45 -0500
X-MC-Unique: 7X4qjUAAOjiEEhIXa4Gb0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 297D780EDAC;
        Tue, 24 Nov 2020 01:04:44 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35A0F6062F;
        Tue, 24 Nov 2020 01:04:41 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH blktests 0/5] nvmeof-mp/srp/nvme-rdma misc fix and enhancement
Date:   Tue, 24 Nov 2020 09:04:22 +0800
Message-Id: <20201124010427.18595-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

This patch series addressed some failures when I run nvmeof-mp/srp
test and also add suport to use siw for nvme-rdma/nvmeof-mp testing
from cmdline, like this:

$ use_siw=1 nvme-trtype=rdma ./check nvme/
$ use_siw=1 ./check nvmeof-mp/

Thanks
Yi

Yi Zhang (5):
  tests/srp/rc: update the ib_srpt module name
  tests/nvmeof-mp/rc: run nvmeof-mp tests if we set multipath=N
  tests/nvmeof-mp/012: fix the schedulers list
  common/rc: _have_iproute2 fix for "ip -V" change
  common/multipath-over-rdma: allow to set use_siw

 common/multipath-over-rdma |  2 +-
 common/rc                  |  2 +-
 tests/nvmeof-mp/012        | 10 ++++++----
 tests/nvmeof-mp/rc         |  2 +-
 tests/srp/rc               |  4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.21.0

