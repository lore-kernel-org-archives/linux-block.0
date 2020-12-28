Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5D4C41620
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C0A223C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgL1Wzz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729513AbgL1V3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 16:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609190885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qVMK6IxmOzpSDV8a9YuDOltfRsHC4fRSqCD71/ci2bg=;
        b=BbJlGVdLPxW8/0ohgsAgEpMSB6FlCCeRv6iolmwGLhbOYAzIdT/zyq7F3XHnOmv/9yKHNu
        lHSBBtS8Bo9yl1yYzs6FvbKwPOl3J20F5eYH05vXvbX2rHfLr5JbRhlznVY9vVy/fRAQys
        VA3nLAlQpo0EGKKLVIKeWyWMoQqVh5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-zFsOb0bOOu-KDnpYQDe0oA-1; Mon, 28 Dec 2020 16:28:03 -0500
X-MC-Unique: zFsOb0bOOu-KDnpYQDe0oA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23B43801B12;
        Mon, 28 Dec 2020 21:28:02 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B24A360BE5;
        Mon, 28 Dec 2020 21:27:58 +0000 (UTC)
Date:   Mon, 28 Dec 2020 16:27:58 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Milan Broz <gmazyland@gmail.com>,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: [git pull] device mapper fix for 5.11-rc2
Message-ID: <20201228212757.GA26267@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit b77709237e72d6467fb27bfbad163f7221ecd648:

  dm cache: simplify the return expression of load_mapping() (2020-12-22 09:54:48 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-fix

for you to fetch changes up to 48b0777cd93dbd800d3966b6f5c34714aad5c203:

  Revert "dm crypt: export sysfs of kcryptd workqueue" (2020-12-28 16:13:52 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
Revert WQ_SYSFS change that broke reencryption (and all other
functionality that requires reloading a dm-crypt DM table).

----------------------------------------------------------------
Mike Snitzer (1):
      Revert "dm crypt: export sysfs of kcryptd workqueue"

 drivers/md/dm-crypt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

