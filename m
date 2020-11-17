Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671AEC5519F
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA7D24655
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwQH6dRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgKQQKJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgKQQKI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 11:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605629407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OBqSjBCkKuBaodmhzyRhxe35Wz3x380gbiPIN3DFWCQ=;
        b=fwQH6dRHXXdgCU7Jbs93oyB8o/kmx8kcsBOcczLWd0JtAONHbm+hgNhZLRzaOrdXpgEFUA
        sc/zug3n1WCBMmJ+88KdZaSNLpv62NrL4IqdmoV/HActR0mQcRLNm2nsv8OyPOiWg23r8l
        3lPYmBlLXENXVjwIDZXVqTbHLnYkrQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-_tuNQ-u3OtWe1Wet8OKlJQ-1; Tue, 17 Nov 2020 11:10:04 -0500
X-MC-Unique: _tuNQ-u3OtWe1Wet8OKlJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 910818042A9;
        Tue, 17 Nov 2020 16:10:03 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0A3C62934;
        Tue, 17 Nov 2020 16:09:59 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:09:59 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: misc struct block_device related driver cleanups
Message-ID: <20201117160958.GB27085@redhat.com>
References: <20201116212020.1099154-1-hch@lst.de>
 <20201117154629.GA27085@redhat.com>
 <20201117155100.GA20977@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117155100.GA20977@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 17 2020 at 10:51am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Nov 17, 2020 at 10:46:29AM -0500, Mike Snitzer wrote:
> > On Mon, Nov 16 2020 at  4:20pm -0500,
> > Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > Hi Jens, Minchan and Mike,
> > > 
> > > this series cleans up a few interactions of driver with struct
> > > block_device, in preparation for big changes to struct block_device
> > > that I plan to send soon.
> > 
> > Thanks, I've picked up 5 and 6 for 5.11.
> 
> I actually need them in Jens' for-5.11/block tree for my next series..

Ah, OK.. no problem.

I'll reply with my Acked-by:s

