Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10677C4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 00:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E687061004
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 00:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhHJAgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 20:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233500AbhHJAgm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Aug 2021 20:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628555781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l5pGJKBgiJlcPrpWmMR12I4ayDVX2H02Rv8WzNW8h4U=;
        b=IEs8eNg4mFZmB/EIcHZOBF4UPFscR/25trh0kWHNE7QKJxvd7yXkqTbvKWsLDAhdCGrv9F
        pwsRIgW+vux7rBMjS0mEl+MxyaoURKb/OunS/RTwDhmd4bp5LsbF6g11tpF/UDwAe0QB5A
        syV4+TvSnyXAVxIUCKdKG+/lo6g3ERw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-sIqRlJqJPZmyTHpIX9M3Lg-1; Mon, 09 Aug 2021 20:36:19 -0400
X-MC-Unique: sIqRlJqJPZmyTHpIX9M3Lg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C94EE802922;
        Tue, 10 Aug 2021 00:36:18 +0000 (UTC)
Received: from agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (agk-cloud1.hosts.prod.upshift.rdu2.redhat.com [10.0.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E5F819D9B;
        Tue, 10 Aug 2021 00:36:08 +0000 (UTC)
Received: by agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 3883)
        id BD08742C4190; Tue, 10 Aug 2021 01:36:08 +0100 (BST)
Date:   Tue, 10 Aug 2021 01:36:08 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] use regular gendisk registration in device mapper v2
Message-ID: <20210810003608.GB101579@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20210804094147.459763-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804094147.459763-1-hch@lst.de>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
 03798903. Registered Office: Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 04, 2021 at 11:41:39AM +0200, Christoph Hellwig wrote:
> allows device mapper to use the normal scheme
> of calling add_disk when it is ready to accept I/O.

For clarity, even after this patchset, the device is not ready to accept
I/O when add_disk is called.  It is ready to accept I/O later if a 
'resume' happens triggering the 'change' uevent that userspace reacts
to by setting up the /dev entries for it.
 
Alasdair

