Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0028DC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCQU2p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCQU2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 16:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFFBAB88D
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679084873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DV4XApSba1H+jI1EziaiPZNIFxJwaca8BPvrUrvzx4E=;
        b=TeTlmhniVO1xlH1VusJuVvlFGrNoudTdTodv1dZ38ta7FP9xLNIOPSSVFKov9ve3m0r41E
        bAOnv4sbIFjQA/IhuiRkLoU1Ky8Ff0VFbs7I+07quQ01x58UpTeBfGXtDOElSJaqVGHQf8
        hH+DbIui10cWZV/61IG2bhgp9R0eSUg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-4mtHtnXROQi3iVu07KYAzQ-1; Fri, 17 Mar 2023 16:27:52 -0400
X-MC-Unique: 4mtHtnXROQi3iVu07KYAzQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F9383C025C0;
        Fri, 17 Mar 2023 20:27:51 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6BEB492B02;
        Fri, 17 Mar 2023 20:27:50 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] nbd: s/handle/cookie/
Date:   Fri, 17 Mar 2023 15:27:44 -0500
Message-Id: <20230317202749.419094-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v1 was here: https://lkml.org/lkml/2023/3/10/1162
since then:
- split original 1/3 into 1/5 and 5/5
- new patch 2/5
- reorder members of anon union
- always send cookie in network order

Eric Blake (5):
  uapi nbd: improve doc links to userspace spec
  block nbd: send handle in network order
  uapi nbd: add cookie alias to handle
  block nbd: use req.cookie instead of req.handle
  docs nbd: userspace NBD now favors github over sourceforge

 Documentation/admin-guide/blockdev/nbd.rst |  2 +-
 drivers/block/nbd.c                        |  6 +++---
 include/uapi/linux/nbd.h                   | 25 +++++++++++++++++-----
 3 files changed, 24 insertions(+), 9 deletions(-)


base-commit: 8d3c682a5e3d9dfc2448ecbb22f4cd48359b9e21
-- 
2.39.2

