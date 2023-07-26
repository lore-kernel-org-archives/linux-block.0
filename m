Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFD8C001DC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 14:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGZOqD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjGZOqC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 10:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7894410F9
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dkQqdaN7caXUtQeNTBWQKbs4Fa2X5gkvVGK60fqbnSY=;
        b=MOC/UNZ+71b5MtS7b5sfSm8w8C+acF7r4vUfs0+DBIeOYVkRRH0ykuH4ObnbMv/mlJ6MRh
        zYSb7vRozfNZXD/QI5KyAqdCCwGZXiQnEOL46Uu66s9C8sjaA8mOPJ1TY1vZi+fCHqZ75B
        YB+zpjYfCqb+76j23qZXPfZCmu7ookc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-EbiUDK0bPaCW2CL1Hav0SA-1; Wed, 26 Jul 2023 10:45:14 -0400
X-MC-Unique: EbiUDK0bPaCW2CL1Hav0SA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0AD3185A7A3;
        Wed, 26 Jul 2023 14:45:13 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF68DC2C7D3;
        Wed, 26 Jul 2023 14:45:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        German Maglione <gmaglione@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] ublk: fail to start/recover/del device if interrupted by signal
Date:   Wed, 26 Jul 2023 22:44:59 +0800
Message-Id: <20230726144502.566785-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

The 1st & 2nd patch fixes kernel oops if user interrupts the current
ublk task.

The 3rd patch returns -EINTR if user interrupts the device deletion.

V2:
	- add patch 2&3, as reported by Stefano

Ming Lei (3):
  ublk: fail to start device if queue setup is interrupted
  ublk: fail to recover device if queue setup is interrupted
  ublk: return -EINTR if breaking from waiting for existed users in
    DEL_DEV

 drivers/block/ublk_drv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.40.1

