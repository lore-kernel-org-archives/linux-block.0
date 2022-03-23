Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A8C433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 06:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiCWGQb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 02:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiCWGQa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 02:16:30 -0400
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC125A17B
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 23:15:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id A51AE81;
        Tue, 22 Mar 2022 23:14:58 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HM-s5RCIFE8f; Tue, 22 Mar 2022 23:14:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id CA19840;
        Tue, 22 Mar 2022 23:14:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net CA19840
Date:   Tue, 22 Mar 2022 23:14:56 -0700 (PDT)
From:   Eric Wheeler <linux-block@lists.ewheeler.net>
To:     Ming Lei <ming.lei@redhat.com>
cc:     linux-block@vger.kernel.org
Subject: Re: loop: it looks like REQ_OP_FLUSH could return before IO
 completion.
In-Reply-To: <YjfFHvTCENCC29WS@T590>
Message-ID: <c03de7ac-63e9-2680-ca5b-8be62e4e177f@ewheeler.net>
References: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net> <YjfFHvTCENCC29WS@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 21 Mar 2022, Ming Lei wrote:
> On Sat, Mar 19, 2022 at 10:14:29AM -0700, Eric Wheeler wrote:
> > Hello all,
> > 
> > In loop.c do_req_filebacked() for REQ_OP_FLUSH, lo_req_flush() is called: 
> > it does not appear that lo_req_flush() does anything to make sure 
> > ki_complete has been called for pending work, it just calls vfs_fsync().
> > 
> > Is this a consistency problem?
> 
> No. What FLUSH command provides is just flushing cache in device side to
> storage medium, so it is nothing to do with pending request.

If a flush follows a series of writes, would it be best if the flush 
happened _after_ those writes complete?  Then then the storage medium will 
be sure to flush what was intended to be written.

It seems that this series of events could lead to inconsistent data:
	loop		->	filesystem
	write a
	write b
	flush
				write a
				flush
				write b
				crash, b is lost

If write+flush ordering is _not_ important, then can you help me 
understand why?

-Eric



> 
> 
> Thanks, 
> Ming
> 
> 
