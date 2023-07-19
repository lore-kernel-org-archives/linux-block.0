Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01667C0015E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 20:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGSUTO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 16:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGSUTO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 16:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2294135
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689797910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sixrwhdcHeyVU46WBGRg4sIj4fphYG/wlDK1MYC4mZI=;
        b=NXUF45rIMNFUEgEKfSlKM3EEv14XlGsG2RgdGLrvU44OoyA/CoL3gi3VS8guaHH40q52sm
        l1Yim2QphFrGsjzpk2NHgh0fXF3s3smhNv3fkQGST/sdavqp6KCj0K/bRV70RxYlhrvZfy
        J9x7W6ndHzee5QwukEynvCjB9RMl2x4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-yrcPj2h0OkyL7CEbqx-_2w-1; Wed, 19 Jul 2023 16:18:23 -0400
X-MC-Unique: yrcPj2h0OkyL7CEbqx-_2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F4838564EF;
        Wed, 19 Jul 2023 20:18:23 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CC1C1454142;
        Wed, 19 Jul 2023 20:18:23 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 07EA13096A42; Wed, 19 Jul 2023 20:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 04DA73F7CF;
        Wed, 19 Jul 2023 22:18:23 +0200 (CEST)
Date:   Wed, 19 Jul 2023 22:18:22 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 0/3] brd discard patches
Message-ID: <11cf5962-181f-7e57-6d78-7251aa60816@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

Here I'm submitting another version of the brd discard patches, updated 
for the current kernel.

Mikulas

