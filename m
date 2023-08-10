Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA86C001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 10:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjHJKH5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjHJKH4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 06:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8E02694
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691662030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YAIXur9/zjvpt3QLnPAZLkxzH2bFiTCiU8Fw4kqatWo=;
        b=WfxggSYWV8F9vZn9rIqFzI1X8avMvEMNoBnrv+nzTjvDSf1JlKbiqFQXsNnkkM0INxbzsI
        9OFKzJY6X7DL8D9tKRTULTL0BbxMJAMIoXcXXTxPo14LsGkl09hVkN9WFTjBzdUSLIFlhk
        qmTD0+IfkYqMgiYuTP5VWGthteGKVjs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-3pqGgrY8NLWvLf2Wv_WPtw-1; Thu, 10 Aug 2023 06:07:08 -0400
X-MC-Unique: 3pqGgrY8NLWvLf2Wv_WPtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55E4E3C025C6;
        Thu, 10 Aug 2023 10:07:08 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 465011121314;
        Thu, 10 Aug 2023 10:07:08 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 979E530B9C07; Thu, 10 Aug 2023 10:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 860CE3F7CF;
        Thu, 10 Aug 2023 12:07:07 +0200 (CEST)
Date:   Thu, 10 Aug 2023 12:07:07 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 0/4] brd discard patches
Message-ID: <2dacc73-854-e71c-1746-99b017401c9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

Here I'm submitting the ramdisk discard patches for the next merge window. 
If you want to make some more changes, please let me now.

Changes since version 2:
There are no functional changes, I only moved the switch statement 
conversion to a separate patch, so that it's easier to review.

Patch 1: introduce a switch statement in brd_submit_bio
Patch 2: extend the rcu regions to cover read and write
Patch 3: enable discard
Patch 4: implement write zeroes

Mikulas

