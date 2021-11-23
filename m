Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE0AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhKWWd6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:33:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34614 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhKWWd5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 17:33:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7DC2C218EF;
        Tue, 23 Nov 2021 22:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637706648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3RHsiwVoPkTRjhpeXmi2muHyWL6m9C8vnS6qda+mPQ=;
        b=ARauiyamk23LIz+yAMjOSunHeNlYnmzgdqtXuWSoZmLS1/SjIa7Bkf/lBjABYaRlXaSTff
        pgIsmzrF71G6CcecA7FU1RHZ16+xBO2aLmzFxP4lZ3jwBXITI42My8n/ovm0YDiIs5WTzi
        UQfkumgk7MxXIzTR0A0N+TkG7VDFWaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637706648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3RHsiwVoPkTRjhpeXmi2muHyWL6m9C8vnS6qda+mPQ=;
        b=W1kl607gv8PRnGfyNtYyq2qVKQgOg76ti4GXT5UfCy5vqETPKnkgO9ELfOTzUS7BX5Rjwo
        cwbGr61L4zlFaCBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 71A99A3B81;
        Tue, 23 Nov 2021 22:30:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DBCF1E1328; Tue, 23 Nov 2021 23:30:45 +0100 (CET)
Date:   Tue, 23 Nov 2021 23:30:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 1/8] block: Provide icq in request allocation data
Message-ID: <20211123223045.GC8583@quack2.suse.cz>
References: <20211123101109.20879-1-jack@suse.cz>
 <20211123103158.17284-1-jack@suse.cz>
 <4cae86cc-e484-cb91-7189-0afbe84f69b9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cae86cc-e484-cb91-7189-0afbe84f69b9@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 23-11-21 09:06:47, Jens Axboe wrote:
> On 11/23/21 3:29 AM, Jan Kara wrote:
> > Currently we lookup ICQ only after the request is allocated. However BFQ
> > will want to decide how many scheduler tags it allows a given bfq queue
> > (effectively a process) to consume based on cgroup weight. So lookup ICQ
> > earlier and provide it in struct blk_mq_alloc_data so that BFQ can use
> > it.
> 
> I've been trying to clean this path up a bit, since I don't like having
> something that just one scheduler needs in the fast path. See:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=perf-wip&id=f1f8191a8f9a0cdcd5ad99dfd7e551e8f444bec5
> 
> Would be better if we could avoid adding io_cq to blk_mq_alloc_data for
> that reason, would it be possible to hide this away in the sched code
> instead on top of the above?

Understood. We could certainly handle ICQ allocation & assignment only inside
BFQ. Just this would mean we would need to lookup ICQ once in
bfq_limit_depth() and then second time in bfq_prepare_request(). I guess
not a huge deal given the amount of work BFQ does for each request anyway.
So can I pull the above commit into the series and rebase this patch on top
of it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
