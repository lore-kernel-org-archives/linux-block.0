Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F98C433ED
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 08:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C65E61353
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhEUI4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 04:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229726AbhEUI4W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 04:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621587299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ydRlG8rmkOuafGhn4nS+0AIX2/p8n4/weSdjmgLGpI=;
        b=fBnU7JGuocA9wXnSuba7N5/+nTjZVqFB8Fe+8I0FV2EMtX2YiI5hzBukCiGEkz8EWZZ5AI
        hLCjf78Ujqvs++1VbRocxJFuE+QwPsVixxlf8TBsMCWm5Wi9au0W9Rfxoodrwf8bpq7q4H
        o9cv/TpIurgwum0SDGRWKK0G6tuXOro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-DY9ZmPtvMn-HQz57me9lPw-1; Fri, 21 May 2021 04:54:57 -0400
X-MC-Unique: DY9ZmPtvMn-HQz57me9lPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89D6F8049D1;
        Fri, 21 May 2021 08:54:56 +0000 (UTC)
Received: from T590 (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4DBC5D9C6;
        Fri, 21 May 2021 08:54:49 +0000 (UTC)
Date:   Fri, 21 May 2021 16:54:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <YKd1VS5gkzQRn+7x@T590>
References: <YKcouuVR/y/L4T58@T590>
 <20210521071727.GA11473@lst.de>
 <YKdhuUZBtKMxDpsr@T590>
 <20210521073547.GA11955@lst.de>
 <YKdwtzp+WWQ3krhI@T590>
 <20210521083635.GA15311@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521083635.GA15311@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 10:36:35AM +0200, Christoph Hellwig wrote:
> On Fri, May 21, 2021 at 04:35:03PM +0800, Ming Lei wrote:
> > Just wondering why the ioend isn't submitted out after it becomes full?
> 
> block layer plugging?  Although failing bio allocations will kick that,
> so that is not a deadlock risk.

These ioends are just added to one list stored on local stack variable(submit_list),
how can block layer plugging observe & submit them out?

Chained bios have been submitted already, but all can't be completed/freed
until the whole ioend is done, that submission won't make forward progress.


Thanks,
Ming

