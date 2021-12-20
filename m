Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE9C433FE
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 19:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhLTT37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:29:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234329AbhLTT36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 14:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640028598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fqm5Ze2V0Gl8GYLwVVKJv69uCeILdqmihxImspZQdCg=;
        b=RAlzgnnjnA2553Y3cfc7cWx762fUy+Hk6fYt2xhs9Fj+qVwhKjuG/nsHdEGG0ybguqAZaN
        IKJTGHKSNmuA35wQdhIwiFtEJKBpVxBiGIVIyrWpXPgmgvizDrm0CXT3drUQmMPEHTKKvF
        BEQtz1axJn8tRWxcAP9lj2dTZeUxmAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-uyum5v7CMmSjPaMeCDJEXg-1; Mon, 20 Dec 2021 14:29:52 -0500
X-MC-Unique: uyum5v7CMmSjPaMeCDJEXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F62C801AC5;
        Mon, 20 Dec 2021 19:29:51 +0000 (UTC)
Received: from wcosta.com (ovpn-116-93.gru2.redhat.com [10.97.116.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41346108D3;
        Mon, 20 Dec 2021 19:29:46 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v5 0/1] blktrace: switch trace spinlock to a raw spinlock
Date:   Mon, 20 Dec 2021 16:29:37 -0300
Message-Id: <20211220192937.38374-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I mistakenly generated v4 from the wrong tree (again). Sorry about that.

Wander Lairson Costa (1):
  blktrace: switch trace spinlock to a raw spinlock

 kernel/trace/blktrace.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.27.0

