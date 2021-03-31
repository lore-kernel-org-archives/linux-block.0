Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFB1C433DB
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 00:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1BA619CA
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 00:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhCaARS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232805AbhCaARJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 20:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617149828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jpzj3I1Cp4N4TRFAijczwqSsbB26ItTieKnqXo2KsP0=;
        b=LA3l3etU3Hz/KrAtSlqLnmqKp1Fg4z5Dv9T+bjhFHX/dmggiQQRg6FytE9iORgLh2X0+KG
        rlgikri5IxE+Fqf2SjlfSfVcbyCh/kmo5ooDPzSmP0hMnRGRxYkSlncsmlbxVy1lW2cgKI
        iLvOMoHRPCpjDrKuOPBalKCz5tnSmeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-HW9HcCmpOymkbY2AsFs2EQ-1; Tue, 30 Mar 2021 20:17:03 -0400
X-MC-Unique: HW9HcCmpOymkbY2AsFs2EQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9991C83DD20;
        Wed, 31 Mar 2021 00:17:02 +0000 (UTC)
Received: from T590 (ovpn-12-104.pek2.redhat.com [10.72.12.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 157FF19C59;
        Wed, 31 Mar 2021 00:16:54 +0000 (UTC)
Date:   Wed, 31 Mar 2021 08:16:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: shutdown blktrace in case of fatal signal
 pending
Message-ID: <YGO/cpalyGevAJjn@T590>
References: <20210323081440.81343-1-ming.lei@redhat.com>
 <20210323081440.81343-2-ming.lei@redhat.com>
 <20210330165330.GA13829@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330165330.GA13829@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 30, 2021 at 06:53:30PM +0200, Christoph Hellwig wrote:
> On Tue, Mar 23, 2021 at 04:14:39PM +0800, Ming Lei wrote:
> > blktrace may allocate lots of memory, if the process is terminated
> > by user or OOM, we need to provide one chance to remove the trace
> > buffer, otherwise memory leak may be caused.
> > 
> > Fix the issue by shutdown blktrace in case of task exiting in
> > blkdev_close().
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> This just seems weird.  blktrace has no relationship to open
> block device instances.

blktrace still needs to open one blkdev, then send its own ioctl
commands to block layer. In case of OOM, the allocated memory in
these ioctl commands won't be released.

Or any other suggestion?

-- 
Ming

