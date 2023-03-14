Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBCEC74A5B
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 12:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCNMKa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 08:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjCNMKS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 08:10:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6528321292
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 05:09:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3742921AD9;
        Tue, 14 Mar 2023 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678795741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ka73pZB5mszYKPbebtOJmEifcI0qvE7WqftKCHQ4nTk=;
        b=GsUnQZ2Ad/zKEj5ZkwRU1PGYh+4NNTCEcwonKisksK5klwlyQyO2y2M9FEBjgauNzACyy9
        MM3VNTSdc/v1GbPc5FTR62RN4udKavU7OTSEgstOPo0qzprpJ8qai6Wr2iK7oPjTEnSNSM
        22l/UqSKPwCiZPpqhqUbFVNqU35fBiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678795741;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ka73pZB5mszYKPbebtOJmEifcI0qvE7WqftKCHQ4nTk=;
        b=H9ATt0zHqtVfSeX66uCdl2botnokeGyoC3vxRc0ICp8ouYUVNyziQkD3gLPhoNI3vt3neW
        7ZIZIFdqc0FFphAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C5EB13A26;
        Tue, 14 Mar 2023 12:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zZ3hBt1jEGR5SwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Mar 2023 12:09:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8DDD0A06FD; Tue, 14 Mar 2023 13:09:00 +0100 (CET)
Date:   Tue, 14 Mar 2023 13:09:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: do not reverse request order when flushing plug
 list
Message-ID: <20230314120900.u67czr5v4kd3my3r@quack3>
References: <20230313093002.11756-1-jack@suse.cz>
 <ZBBJ7CLOurvOO3OQ@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBJ7CLOurvOO3OQ@ovpn-8-18.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 14-03-23 18:18:20, Ming Lei wrote:
> On Mon, Mar 13, 2023 at 10:30:02AM +0100, Jan Kara wrote:
> > Commit 26fed4ac4eab ("block: flush plug based on hardware and software
> > queue order") changed flushing of plug list to submit requests one
> > device at a time. However while doing that it also started using
> > list_add_tail() instead of list_add() used previously thus effectively
> > submitting requests in reverse order. Also when forming a rq_list with
> > remaining requests (in case two or more devices are used), we
> > effectively reverse the ordering of the plug list for each device we
> > process. Submitting requests in reverse order has negative impact on
> > performance for rotational disks (when BFQ is not in use). We observe
> > 10-25% regression in random 4k write throughput, as well as ~20%
> > regression in MariaDB OLTP benchmark on rotational storage on btrfs
> > filesystem.
> > 
> > Fix the problem by preserving ordering of the plug list when inserting
> > requests into the queuelist as well as by appending to requeue_list
> > instead of prepending to it.
> 
> Also in case of !plug->multiple_queues && !plug->has_elevator, requests
> are still sent to device in reverse order, do we need to cover that case?

That's an interesting question. I suppose reversing the order in this case
could be suprising e.g. for shingled storage. I don't think it matters that
much for normal rotational storage as there you presumably run with at
least some IO scheduler (we were using mq-deadline in our testing).

Avoiding the reversal will require small changes to plug handling (so that
we append the plug list) but it shouldn't be too bad. Still I'd do it in a
separate patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
