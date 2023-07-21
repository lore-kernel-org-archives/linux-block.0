Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F2EEB64DC
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 13:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGUNtl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjGUNtk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 09:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095C72737
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689947336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lEHOwQGRbHONIV7WbvaGQ4WoVRbLM0jhseLXBJ3YjIE=;
        b=MEou//W23tsBdKP34RRdzRe0YjCqs9LXQ3IpideXm5Y82nfsZtFmz+IKq/mPbZN+jnL2fX
        e/Tc6yYUMU6winzO1ZFKKCiRQ6FfdOcQa2QsgkenJy0vA3wIY5iTfvgwUS6h2kf9tDJ+bq
        pI9BMhf63XEUuEIgA2tMMuXl85PPC1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-SYeHu2hLPCWYb5jWMY7RTQ-1; Fri, 21 Jul 2023 09:48:52 -0400
X-MC-Unique: SYeHu2hLPCWYb5jWMY7RTQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 124D4101A528;
        Fri, 21 Jul 2023 13:48:52 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F14E3492C13;
        Fri, 21 Jul 2023 13:48:51 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id DFC4A30C0457; Fri, 21 Jul 2023 13:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id DB56A3FB76;
        Fri, 21 Jul 2023 15:48:51 +0200 (CEST)
Date:   Fri, 21 Jul 2023 15:48:51 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v2 0/3] brd discard patches
Message-ID: <9933f5df-dd43-3447-dce3-f513368578@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a new version of the brd discard patches.

