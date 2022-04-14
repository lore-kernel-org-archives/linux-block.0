Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465D8C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 00:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiDNAar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 20:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiDNAaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 20:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5699205E0
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 17:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649896102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WDVzxH2Zh+Ac17PYnjP7+6qsryp2Xznf9MOgNVACJUc=;
        b=GFPzzFGhJ/V/CVDHePAsqq6F1t5viH7wOUkTn3tkaSooYkATxQ0lPRAfOD3vepopLBjHx6
        BuXNHwFFMWXoaqNbBpN1eV0qhWFyQ3LPAmBO2vpkoYKAS1UiQc64H62lwMuU1xcbF174vx
        zRL/gsnW01cZTGmsrH3h/fQtV+5r/Yw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-r-mYmVnlOHmKMKgvRmte9A-1; Wed, 13 Apr 2022 20:28:19 -0400
X-MC-Unique: r-mYmVnlOHmKMKgvRmte9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E972802803;
        Thu, 14 Apr 2022 00:28:19 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BB86407F77F;
        Thu, 14 Apr 2022 00:28:16 +0000 (UTC)
Date:   Thu, 14 Apr 2022 08:28:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Eric Wheeler <linux-block@lists.ewheeler.net>
Cc:     linux-block@vger.kernel.org
Subject: Re: loop: it looks like REQ_OP_FLUSH could return before IO
 completion.
Message-ID: <YldqnL79xH5NJGKW@T590>
References: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net>
 <YjfFHvTCENCC29WS@T590>
 <c03de7ac-63e9-2680-ca5b-8be62e4e177f@ewheeler.net>
 <bd5f9817-c65e-7915-18b-9c68bb34488e@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5f9817-c65e-7915-18b-9c68bb34488e@ewheeler.net>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 03:49:07PM -0700, Eric Wheeler wrote:
> On Tue, 22 Mar 2022, Eric Wheeler wrote:
> > On Mon, 21 Mar 2022, Ming Lei wrote:
> > > On Sat, Mar 19, 2022 at 10:14:29AM -0700, Eric Wheeler wrote:
> > > > Hello all,
> > > > 
> > > > In loop.c do_req_filebacked() for REQ_OP_FLUSH, lo_req_flush() is called: 
> > > > it does not appear that lo_req_flush() does anything to make sure 
> > > > ki_complete has been called for pending work, it just calls vfs_fsync().
> > > > 
> > > > Is this a consistency problem?
> > > 
> > > No. What FLUSH command provides is just flushing cache in device side to
> > > storage medium, so it is nothing to do with pending request.
> > 
> > If a flush follows a series of writes, would it be best if the flush 
> > happened _after_ those writes complete?  Then then the storage medium will 
> > be sure to flush what was intended to be written.
> > 
> > It seems that this series of events could lead to inconsistent data:
> > 	loop		->	filesystem
> > 	write a
> > 	write b
> > 	flush
> > 				write a
> > 				flush
> > 				write b
> > 				crash, b is lost
> > 
> > If write+flush ordering is _not_ important, then can you help me 
> > understand why?
> > 
> 
> Hi Ming, just checking in: did you see the message above?
> 
> Do you really mean to say that reordering writes around a flush is safe 
> in the presence of a crash?

Sorry, replied too quick.

BTW, what is the actual crash? Any dmesg log? From the above description, b is
just not flushed to storage when running flush, and sooner or later it will
land, so what is the real issue?


Thanks,
Ming

