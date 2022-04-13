Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42297C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 22:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiDMWvd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbiDMWvc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 18:51:32 -0400
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1520758805
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 15:49:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id B9DC549;
        Wed, 13 Apr 2022 15:49:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OkzNb-rlLwB4; Wed, 13 Apr 2022 15:49:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id D441840;
        Wed, 13 Apr 2022 15:49:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net D441840
Date:   Wed, 13 Apr 2022 15:49:07 -0700 (PDT)
From:   Eric Wheeler <linux-block@lists.ewheeler.net>
To:     Ming Lei <ming.lei@redhat.com>
cc:     linux-block@vger.kernel.org
Subject: Re: loop: it looks like REQ_OP_FLUSH could return before IO
 completion.
In-Reply-To: <c03de7ac-63e9-2680-ca5b-8be62e4e177f@ewheeler.net>
Message-ID: <bd5f9817-c65e-7915-18b-9c68bb34488e@ewheeler.net>
References: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net> <YjfFHvTCENCC29WS@T590> <c03de7ac-63e9-2680-ca5b-8be62e4e177f@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Mar 2022, Eric Wheeler wrote:
> On Mon, 21 Mar 2022, Ming Lei wrote:
> > On Sat, Mar 19, 2022 at 10:14:29AM -0700, Eric Wheeler wrote:
> > > Hello all,
> > > 
> > > In loop.c do_req_filebacked() for REQ_OP_FLUSH, lo_req_flush() is called: 
> > > it does not appear that lo_req_flush() does anything to make sure 
> > > ki_complete has been called for pending work, it just calls vfs_fsync().
> > > 
> > > Is this a consistency problem?
> > 
> > No. What FLUSH command provides is just flushing cache in device side to
> > storage medium, so it is nothing to do with pending request.
> 
> If a flush follows a series of writes, would it be best if the flush 
> happened _after_ those writes complete?  Then then the storage medium will 
> be sure to flush what was intended to be written.
> 
> It seems that this series of events could lead to inconsistent data:
> 	loop		->	filesystem
> 	write a
> 	write b
> 	flush
> 				write a
> 				flush
> 				write b
> 				crash, b is lost
> 
> If write+flush ordering is _not_ important, then can you help me 
> understand why?
> 

Hi Ming, just checking in: did you see the message above?

Do you really mean to say that reordering writes around a flush is safe 
in the presence of a crash?


--
Eric Wheeler



> -Eric
> 
> 
> 
> > 
> > 
> > Thanks, 
> > Ming
> > 
> > 
> 
