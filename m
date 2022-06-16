Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4906C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 11:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiFPLY6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 07:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiFPLY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 07:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A29D45251E
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655378695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YNFibKj3gf/eijxgCi7qw0c7bBrSPK5mswMMdYMTenE=;
        b=dgWKbmDp3cq0djcCBpQZkETpOq6VhBjcfnYeP4vv3so6v7sTyaMRikiyVlWkUGaF8qSIBd
        6JV/hxIBQe4Yl7UaUDgVvSNJWrHjQqRic1wcjrJgwgUYRhQvbjAGgvQmme9fBH1gobwUI3
        mXaq0xJng5p9gUz4/pK0etw/cmhPb9k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-r82OFgTuOuWWwMFtiqJihg-1; Thu, 16 Jun 2022 07:24:52 -0400
X-MC-Unique: r82OFgTuOuWWwMFtiqJihg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AF5C95B48A;
        Thu, 16 Jun 2022 11:24:52 +0000 (UTC)
Received: from pick.home.annexia.org (unknown [10.39.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95D3F1121314;
        Thu, 16 Jun 2022 11:24:50 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     josef@toxicpanda.com
Cc:     axboe@kernel.dk, prasanna.kalever@redhat.com, xiubli@redhat.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com
Subject: [PATCH] nbd: Permit nbd-client to set minimum and optimal I/O sizes
Date:   Thu, 16 Jun 2022 12:24:48 +0100
Message-Id: <20220616112449.3222664-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a small change to the nbd kernel driver which allows the
client to set minimum_io_size and optimal_io_size hints for the NBD
device.

There is an accompanying patch for nbd-client (userspace tool) which I
will send separately.

Rich.


