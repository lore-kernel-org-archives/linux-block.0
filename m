Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C81CC6FA82
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 17:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiITRwp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiITRwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 13:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950A1EEFF
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663696362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=952B8t8Jxn0YSK/zxruehujUz7GVrZ3uB+H+Prt9SJA=;
        b=CgpNv5+4gAibPGON/nfrwxWtTlMjRxofD0XcYTyTPxk8MMGPIgDVGsVJ77t8gnQe8kKwgX
        f3RCwLZhGD6uUserKkKnkjK4ZVIxnnvEX3idx8Yni8xBFJZmAhKe0x/4ra+e0jGQh5copT
        SNT+IPiAsTbdMCnjbmEYwtqT71XY9Lo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-LUNOjU8CPL2pIu2JaGOmCw-1; Tue, 20 Sep 2022 13:52:39 -0400
X-MC-Unique: LUNOjU8CPL2pIu2JaGOmCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F15D185A583;
        Tue, 20 Sep 2022 17:52:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E59B3C15BA4;
        Tue, 20 Sep 2022 17:52:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28KHqcAP026230;
        Tue, 20 Sep 2022 13:52:38 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28KHqcEp026226;
        Tue, 20 Sep 2022 13:52:38 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 20 Sep 2022 13:52:38 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v2 0/4] brd: implement discard
Message-ID: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

Here I'm sending second version of the brd discard patches.

Mikulas

