Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E18C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 15:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbiGWPHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jul 2022 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGWPHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jul 2022 11:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2005C1A814
        for <linux-block@vger.kernel.org>; Sat, 23 Jul 2022 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658588849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T+9xOE3QvcNeGAMXCxmSqvUJPxnVcLCrEvEVpGo3UTA=;
        b=TEstmX1YTVjy5FcK4AevoAGHObKdiD4HSACXTB9DH56KrizO87BNSo2VtBqd2BDpAtEjGt
        UxVfml+fR0SYAiXiqhiJotpe0bu1pF3ql8sieCIz4+jkUThpEuv954WL5/OLjB8lo/IUzd
        0UxH31PCFFVhw1cCpTRRhf+oltgyO6c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-kOVa_NLHN2aHPtq1XyxI5g-1; Sat, 23 Jul 2022 11:07:25 -0400
X-MC-Unique: kOVa_NLHN2aHPtq1XyxI5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FE3F3801F4B;
        Sat, 23 Jul 2022 15:07:25 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8849940E80E0;
        Sat, 23 Jul 2022 15:07:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] ublk_drv: add generic mechanism to get/set parameters
Date:   Sat, 23 Jul 2022 23:07:11 +0800
Message-Id: <20220723150713.750369-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch implements generic mechanism to store & validate & apply
parameters.

The 2nd patch adds SET_PARA/GET_PARA control commands to support to
get/set parameters from userspace.

At least block device parameters and feature parameters can be supported
to get/set with this approach, so it could be easier to implement all
kinds of generic userspace block device with all sort of setting,
meantime can be extended easily in future.

Verified by two examples(demo_null.c & demo_event.c) in the following branch:

https://github.com/ming1/ubdsrv/tree/set_get_para

BTW, I plan to switch to exchange data between control and io task by json
first, then use SET/GET PARA command in ublksrv_tgt.c.

Ming Lei (2):
  ublk_drv: store device parameters
  ublk_drv: add SET_PARA/GET_PARA control command

 drivers/block/ublk_drv.c      | 349 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  45 +++++
 2 files changed, 382 insertions(+), 12 deletions(-)

-- 
2.31.1

