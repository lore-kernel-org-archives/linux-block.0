Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD2C61DA4
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 08:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBNIeR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 03:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjBNIeM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 03:34:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357CAB771
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 00:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676363607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxYgsuBJ4XAlbnZ8B/FCrtTzmhGNPO8GU8/13IaMfwo=;
        b=Y20Dn16x8t0z5n/eBFy8EWPQK7NEkfhOZidkRUZtrMw68EgqyxFIq9tFZoKvMVe9zoEp1r
        Mc6Dqd9Nwn/vwB6NqpKH5yw46bqAU5J+biZnwoQz8WvpDUBdknyGCdab2hfmncVHWS5cGp
        mZIxEvXHA6WwBYWZnkGOnq4V4Ek36GU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-lWlaoe7zPqmL0hnpNL7vKQ-1; Tue, 14 Feb 2023 03:33:23 -0500
X-MC-Unique: lWlaoe7zPqmL0hnpNL7vKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 470C1800B23;
        Tue, 14 Feb 2023 08:33:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 463A7492B15;
        Tue, 14 Feb 2023 08:33:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+pdHFFTk1TTEBsO@makrotopia.org>
References: <Y+pdHFFTk1TTEBsO@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: regression in next-20230213: "splice: Do splice read from a buffered file without using ITER_PIPE"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2547025.1676363600.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 14 Feb 2023 08:33:20 +0000
Message-ID: <2547026.1676363600@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Daniel,

I've added a patch to my iov-extract-3 branch that I think should fix this=
:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Diov-extract-3

David

