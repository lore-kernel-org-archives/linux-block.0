Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC4C54EE9
	for <linux-block@archiver.kernel.org>; Fri, 16 Sep 2022 08:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiIPI7A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Sep 2022 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIPI66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2022 04:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C37A7232
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663318736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=J6Dg6Ku6i96uenaeiTA9tPXCjl+5pzDABUVKj0tpIIo=;
        b=SM6/ZGTtVxPIkOVNlT/iZf1Yz9B5YEIkJTXW4fjzpFEadHqzhjCJ7zBsoktyHoc6I2ipq9
        N+c6B/BdzsvKCvFxRlg8SL39UxezzMp09eual3CAyx/9ED9SiCcPQDhBKvOv3uYR1cabn3
        BrdRLt8ngrXq/sH06U83Cz59y+ESLOk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-n-vPcqqWMWKPMmxIwA0_6w-1; Fri, 16 Sep 2022 04:58:54 -0400
X-MC-Unique: n-vPcqqWMWKPMmxIwA0_6w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98BD2855423;
        Fri, 16 Sep 2022 08:58:54 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86678492CA4;
        Fri, 16 Sep 2022 08:58:54 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28G8wsKr000596;
        Fri, 16 Sep 2022 04:58:54 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28G8wsq8000592;
        Fri, 16 Sep 2022 04:58:54 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 16 Sep 2022 04:58:54 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 0/4] brd: implement discard
Message-ID: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

This series of patches implements discard, write_zeroes and secure_erase 
support for the brd driver.

Zdenek asked me to write it, because we use brd in the lvm2 testsuite and 
it would be benefical to run the testsuite with discard enabled in order 
to test discard handling.

This patch series should have no performance impact - it doesn't add any 
locks to the common I/O paths. It only extends rcu read region around 
lookup and reading or writing of a single page. Discarded pages are freed 
with "call_rcu" to make sure that if we mix discard with I/O, the I/O 
won't access freed memory.

Mikulas

