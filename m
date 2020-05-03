Return-Path: <SRS0=GZIg=6R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41930C3A5A9
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 01:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1254C21835
	for <linux-block@archiver.kernel.org>; Sun,  3 May 2020 01:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgfSnaGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgECBoK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 21:44:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726684AbgECBoK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 May 2020 21:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588470248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDdv1M7hX8nZEdrcY713baUdG44eVKvPf/toFMXtYiQ=;
        b=EgfSnaGNuvnauxqNRalNtsjQYtVjYml610zjL6JhooLfg1S/W/VlcRHXX8jafpq0n/D44Q
        MkZPKlnyq0465JDmVvZOFZ2JvqMnasW9pFTdXsUKvweaRVBmdmVpXbg+/oqRXvT2heaom5
        dQGvcziyYR80pSAquPXPE+ncbO6UV/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-cB7eZPHaNHm9pz6liCeauQ-1; Sat, 02 May 2020 21:43:57 -0400
X-MC-Unique: cB7eZPHaNHm9pz6liCeauQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC0FE80B70B;
        Sun,  3 May 2020 01:43:55 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53EEE2B4DF;
        Sun,  3 May 2020 01:43:48 +0000 (UTC)
Date:   Sun, 3 May 2020 09:43:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: add blk_default_io_timeout() for avoiding
 task hung in sync IO
Message-ID: <20200503014343.GA1120601@T590>
References: <20200428074657.645441-1-ming.lei@redhat.com>
 <20200428074657.645441-2-ming.lei@redhat.com>
 <7e339c3d-8600-4a9b-99bf-24afb023c4dd@acm.org>
 <20200429011728.GA671522@T590>
 <61520b08-326d-036b-e69d-08e2cad4d3c8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61520b08-326d-036b-e69d-08e2cad4d3c8@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 08:08:03PM -0700, Bart Van Assche wrote:
> On 2020-04-28 18:17, Ming Lei wrote:
> > On Tue, Apr 28, 2020 at 07:19:33AM -0700, Bart Van Assche wrote:
> >> On 2020-04-28 00:46, Ming Lei wrote:
> >>> +/*
> >>> + * Used in sync IO for avoiding to triger task hung warning, which may
> >>> + * cause system panic or reboot.
> >>> + */
> >>> +static inline unsigned long blk_default_io_timeout(void)
> >>> +{
> >>> +	return sysctl_hung_task_timeout_secs * (HZ / 2);
> >>> +}
> >>> +
> >>>  #endif
> >>
> >> This function is only used inside the block layer. Has it been
> >> considered to move this function from the public block layer API into a
> >> private header file, e.g. block/blk.h?
> > 
> > Please look at the commit log or the 2nd patch, and the helper will be
> > used in 2nd patch in dio code.
> 
> Has it been considered to use the expression
> "sysctl_hung_task_timeout_secs * (HZ / 2)" directly instead of wrapping
> that expression in a function? I think using the expression directly may
> be more clear. Additionally, it is slightly confusing that the function
> name starts with "blk_" but that nothing in the implementation of that
> function is specific to the block layer.

Fine, will do it in V2.

thanks,
Ming

