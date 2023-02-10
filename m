Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C68C05027
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 11:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjBJL36 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 06:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjBJL35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 06:29:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE49A5E8;
        Fri, 10 Feb 2023 03:29:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE56A3FB47;
        Fri, 10 Feb 2023 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676028594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lFG9hUKx5RRv1kRzAuMhtm3Isu2cMLDvawPdmQnL++E=;
        b=iLExC8SQhldLpRfnwmoj45BeA10gdTreaMJNx5DkhzCdq67WT0ELnmNQSnb4Jpn9Ym/bA7
        bEq8VFUcuITuRDnlS8094fQEFAqCnJDS9vKZ9dfoHPFf6iHAF2gTO+4XDqGNDxObuvy/fs
        QVyEfN5XKyiAY2E1oqwsd+esGVjdqak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676028594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lFG9hUKx5RRv1kRzAuMhtm3Isu2cMLDvawPdmQnL++E=;
        b=7PJxxC6zDK7A7R9L/dIFeqQwgCw2IKxRhmWZYd1WjAlizRCwq+fO7HPAvYeEaijjV/pe/l
        vAFSQbPgAT6J/SDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE5EE1325E;
        Fri, 10 Feb 2023 11:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UaF1LrIq5mPIagAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 10 Feb 2023 11:29:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3B18AA06D8; Fri, 10 Feb 2023 12:29:54 +0100 (CET)
Date:   Fri, 10 Feb 2023 12:29:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/5] mm: Do not reclaim private data from pinned page
Message-ID: <20230210112954.3yzlyi4hjgci36yn@quack3>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-1-jack@suse.cz>
 <Y+Ucq8A+WMT0ZUnd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Ucq8A+WMT0ZUnd@casper.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 09-02-23 16:17:47, Matthew Wilcox wrote:
> On Thu, Feb 09, 2023 at 01:31:53PM +0100, Jan Kara wrote:
> > If the page is pinned, there's no point in trying to reclaim it.
> > Furthermore if the page is from the page cache we don't want to reclaim
> > fs-private data from the page because the pinning process may be writing
> > to the page at any time and reclaiming fs private info on a dirty page
> > can upset the filesystem (see link below).
> > 
> > Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> 
> OK, but now I'm confused.  I've been told before that the reason we
> can't take pinned pages off the LRU list is that they need to be written
> back periodically for ... reasons.  But now the pages are going to be
> skipped if they're found on the LRU list, so why is this better than
> taking them off the LRU list?

You are mixing things together a bit :). Yes, we do need to writeback
pinned pages from time to time - for data integrity purposes like fsync(2).
This has nothing to do with taking the pinned page out of LRU. It would be
actually nice to be able to take pinned pages out of the LRU and
functionally that would make sense but as I've mentioned in my reply to you
[1], the problem here is the performance. I've now dug out the discussion
from 2018 where John actually tried to take pinned pages out of the LRU [2]
and the result was 20% IOPS degradation on his NVME drive because of the
cost of taking the LRU lock. I'm not even speaking how costly that would
get on any heavily parallel direct IO workload on some high-iops device...

								Honza

[1] https://lore.kernel.org/all/20230124102931.g7e33syuhfo7s36h@quack3
[2] https://lore.kernel.org/all/f5ad7210-05e0-3dc4-02df-01ce5346e198@nvidia.com

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
