Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A2FC7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 15:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjDUPqF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDUPqD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 11:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A9D12C9D
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682091906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Ot99w0O0FLjBJJyVPwePA1CUIWT3MpmICNNyt0ryn4U=;
        b=PSxK7CaVACIoqdfJ18WAoCMB1AtM0s8llFecM3ZXM4iAlV0BoIKfMfBYwmQl1WBaAT6UQE
        Yg3l/HeogpgsPAHK6M9Mj2w5wUOL0E37OgodZ8K4aI5Gl8v98eiIhdc3ycL1bsS3G1c78D
        qcgPt2/HGxgd/+2WQ3JPLk7QGcnpEZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-BAQZRyAINIuJ3VAlIwUK-Q-1; Fri, 21 Apr 2023 11:45:04 -0400
X-MC-Unique: BAQZRyAINIuJ3VAlIwUK-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E686085A5A3;
        Fri, 21 Apr 2023 15:45:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA65140EBF4;
        Fri, 21 Apr 2023 15:45:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     dhowells@redhat.com, Ayush Jain <ayush.jain3@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Steve French <stfrench@microsoft.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Can you drop the splice patches?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <208642.1682091901.1@warthog.procyon.org.uk>
Date:   Fri, 21 Apr 2023 16:45:01 +0100
Message-ID: <208643.1682091901@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Can you drop the splice patches for the moment, please?  Al spotted problems
with them.

David

