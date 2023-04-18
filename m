Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC514C77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 10:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDRKBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 06:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDRKBC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 06:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5E0AD
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681812017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=u2LTqRsAYE6Tv8i4iZiNhi3zYrhn075iEkPVHXLSnAs=;
        b=jQvpE8ZZbSse8jwr7n0EyBkUp46RZqRo7lZDrwWCVjz5iOxkuslR019M8jgYyOzgOl6Yba
        zIuU+6izSnl7aycIIQw5m7stB1vvm+T6MqanQh1YrD176h2vFehlaLgC+Tb8WtdyI8iGV2
        UPswYHq0kT4ugNu4MvViGCy0kS5KXKA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-JdPb6AOZP-CatszGhD--UA-1; Tue, 18 Apr 2023 06:00:13 -0400
X-MC-Unique: JdPb6AOZP-CatszGhD--UA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FF4B280AA24;
        Tue, 18 Apr 2023 10:00:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEBE140C6E6F;
        Tue, 18 Apr 2023 10:00:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     hch@lst.de
cc:     dhowells@redhat.com, linux-block@vger.kernel.org
Subject: How best to get the size of a blockdev from a file?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1609850.1681812012.1@warthog.procyon.org.uk>
Date:   Tue, 18 Apr 2023 11:00:12 +0100
Message-ID: <1609851.1681812012@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

It seems that my use of i_size_read(file_inode(in)) in filemap_splice_read()
to get the size of the file to be spliced from doesn't work in the case of
blockdevs and it always returns 0.

What would be the best way to get the blockdev size?  Look at
file->f_mapping->i_size maybe?

David

