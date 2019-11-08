Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A65C5DF60
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 10:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E992178F
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 10:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxhFI/2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKHKQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:16:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47707 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726103AbfKHKQC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Nov 2019 05:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573208161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oVW94E+UJuYbDBjDnewIxo0S95SVdk0c6wdaaNxEVvk=;
        b=GxhFI/2Am7lURoPqdHxPlE/eyVqo/Z6TSKYu0BP3u5TmkUO2Rhd9502ydFkK9Po36cPw/L
        ciB7f0M+1hUKQVptzEj4XzTKvKIx3pHtpaKaTWzcWRumYoYbczV8+fWNHp52VC2UvrtDwH
        LnGpHkZd4hF8Xiqz6Ps3GzQ7OQygF2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-nt5GR5eiOUiuza1fzH7b8g-1; Fri, 08 Nov 2019 05:16:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8759C1005502;
        Fri,  8 Nov 2019 10:15:59 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E512A608FB;
        Fri,  8 Nov 2019 10:15:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] block: two fixes on avoiding bio splitting
Date:   Fri,  8 Nov 2019 18:15:26 +0800
Message-Id: <20191108101528.31735-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nt5GR5eiOUiuza1fzH7b8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch fixes kernel panic issue which is caused by not
splitting bio.

The 2nd patch requets to change the limit as SZ_4K instead of
PAGE_SIZE which can be big enough to break some devies.

Thanks,

Ming Lei (2):
  block: still try to split bio if the bvec crosses pages
  block: split bio if the only bvec's length is > SZ_4K

 block/blk-merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Cc: Christoph Hellwig <hch@lst.de>

--=20
2.20.1

