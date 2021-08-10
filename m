Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC24C4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 15:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934B160F02
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 15:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhHJPF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 11:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237554AbhHJPFx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 11:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628607930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ji0wLdKoyLvqMlNeQl0ABhWK0GZExKOPu50UlZ6eE7E=;
        b=Wt27ENp3pBhBTbsOoDRd5wcGCMkZuu3M1XPwLS+eBQPrDS8O/c6t8xb3NdYbhAMHOi/wWq
        ja7aR0CMc2G0LGlvT1zld5HrQb4J6eQ28Gt6qiIhP2UeevNyQJEnjgmXzwlsUSaZg0jX2o
        gWWI3aKMwEVYNi6G22QGXzdzZ+JIlWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-HdayQ-15PfWoASr_ZdwlNg-1; Tue, 10 Aug 2021 11:05:27 -0400
X-MC-Unique: HdayQ-15PfWoASr_ZdwlNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 294913E74D;
        Tue, 10 Aug 2021 15:05:26 +0000 (UTC)
Received: from agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (agk-cloud1.hosts.prod.upshift.rdu2.redhat.com [10.0.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0AE027CA4;
        Tue, 10 Aug 2021 15:05:11 +0000 (UTC)
Received: by agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 3883)
        id 9D0E541FBD38; Tue, 10 Aug 2021 16:05:12 +0100 (BST)
Date:   Tue, 10 Aug 2021 16:05:12 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     Peter Rajnoha <prajnoha@redhat.com>
Cc:     Alasdair G Kergon <agk@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH 7/8] dm: delay registering the gendisk
Message-ID: <20210810150512.GA102700@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Mail-Followup-To: Peter Rajnoha <prajnoha@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20210804094147.459763-8-hch@lst.de>
 <20210809233143.GA101480@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
 <20210810131227.ofgfi62agal64nqd@alatyr-rpi.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810131227.ofgfi62agal64nqd@alatyr-rpi.brq.redhat.com>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
 03798903. Registered Office: Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 10, 2021 at 03:12:27PM +0200, Peter Rajnoha wrote:
> (I'm not counting the very corner use case of
> 'dmsetup --addnodeoncreate --verifyudev' which now ends up with a dev node
> in /dev that logically returns -ENODEV when accessed instead of zero-sized
> device as it was before.)
 
Yes.  That facility was provided to assist people having to work with
old or incorrect code or misconfigured systems and breaking it in this
way shouldn't be a concern.  (We could possibly still patch it up to
continue to do the best thing after the patchset goes in.)

Alasdair

