Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968CBC072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 07:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A9520879
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 07:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbfEXHzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 03:55:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbfEXHzs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 03:55:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63A1E307D98D;
        Fri, 24 May 2019 07:55:48 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B40918232;
        Fri, 24 May 2019 07:55:45 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 0/2] Add examples/ and test/ binaries to .gitignore
Date:   Fri, 24 May 2019 08:55:41 +0100
Message-Id: <20190524075543.30338-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 24 May 2019 07:55:48 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The git-status(1) output is noisy since it includes the examples/ and test/
binaries.  They should not be committed so add them to .gitignore.

I noticed this when trying Aarushi's io_uring code for QEMU at
https://github.com/rooshm/qemu/tree/io_uring.

Stefan Hajnoczi (2):
  Add example binaries to .gitignore
  Add test binaries to .gitignore

 .gitignore | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.21.0

