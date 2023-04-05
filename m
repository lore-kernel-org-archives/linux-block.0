Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3961C76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 11:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbjDELNv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbjDELNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 07:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36681131
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680693182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2WEGFg+V4u6XnztR8qf+aGaXUcX43OBgKgkW4HEXss=;
        b=JtRLKinxdxa/QOen9mdarZGBs5/83HlLZYuk5Sa4kVgvli215dvzVf9ud5bdOdgKruPbpM
        QVdm2bItnaDNdCBBdbmkyqL7eKDe4saFmkzi3ryuPwOTopJyxm8B80vsYbHrTu0RnoiGjI
        GJUAEwRVJ3OtfE/SKMPWaH8AjXHK298=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-NjK3AVpnPzaKvNItKZVo0w-1; Wed, 05 Apr 2023 07:12:59 -0400
X-MC-Unique: NjK3AVpnPzaKvNItKZVo0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E45238123AA;
        Wed,  5 Apr 2023 11:12:58 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CF0A40C6EC4;
        Wed,  5 Apr 2023 11:12:57 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, jonathan.derrick@linux.dev,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH v2 0/5] sed-opal: add command to read locking range attributes
Date:   Wed,  5 Apr 2023 13:12:18 +0200
Message-Id: <20230405111223.272816-1-okozina@redhat.com>
In-Reply-To: <20230322151604.401680-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch set aims to add ability to user authorities to read locking
range attributes.

It's achieved in two steps (except SUM enabled drives):

1) Patch IOC_OPAL_ADD_USR_TO_LR command so that user authority (together with
OPAL_ADMIN1) is added in ACE that allows getting locking range attributes.

2) Add new ioctl command IOC_OPAL_GET_LR_STATUS to get locking range
attributes to user authority assigned to specific locking range.

libcryptsetup plans to support OPAL2 drives and needs to verify locking
range parameters before device activation (LR unlock) takes place since
it's considered undesirable to have (for example) partition mapped beyond
locking range boundaries.

Changes since previous version:

v2:
  - Mostly code style fixes (overly long lines)
  - Refactored helper for adding user authorities in ACE (added boolean
    operators defines, explained addition of boolean ace operator
    when adding more than one user authority in ACE)

Ondrej Kozina (5):
  sed-opal: do not add same authority twice in boolean ace.
  sed-opal: add helper for adding user authorities in ACE.
  sed-opal: allow user authority to get locking range attributes.
  sed-opal: add helper to get multiple columns at once.
  sed-opal: Add command to read locking range parameters.

 block/opal_proto.h            |  10 ++
 block/sed-opal.c              | 301 +++++++++++++++++++++++++++++-----
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h |  11 ++
 4 files changed, 280 insertions(+), 43 deletions(-)

-- 
2.31.1

