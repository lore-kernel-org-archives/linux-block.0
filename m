Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7164AC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 13:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AE12084F
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 13:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfBUN3S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:29:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:33014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfBUN3S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 08:29:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5B5DAF94;
        Thu, 21 Feb 2019 13:29:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 49DCC1E0900; Thu, 21 Feb 2019 14:29:16 +0100 (CET)
Date:   Thu, 21 Feb 2019 14:29:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
Message-ID: <20190221132916.GA22886@quack2.suse.cz>
References: <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
 <20190216174536.GC23000@mit.edu>
 <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
 <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
 <20190219132026.GA28293@quack2.suse.cz>
 <20190219144454.GB12668@bombadil.infradead.org>
 <d444f653-9b99-5e9b-3b47-97f824c29b0e@linux.ee>
 <20190220094813.GA27474@quack2.suse.cz>
 <2381c264-92f5-db43-b6a5-8e00bd881fef@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2381c264-92f5-db43-b6a5-8e00bd881fef@linux.ee>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 21-02-19 01:23:50, Meelis Roos wrote:
> > > First, I found out that both the problematic alphas had memory compaction and
> > > page migration and bounce buffers turned on, and working alphas had them off.
> > > 
> > > Next, turing off these options makes the problematic alphas work.
> > 
> > OK, thanks for testing! Can you narrow down whether the problem is due to
> > CONFIG_BOUNCE or CONFIG_MIGRATION + CONFIG_COMPACTION? These are two
> > completely different things so knowing where to look will help. Thanks!
> 
> Tested both.
> 
> Just CONFIG_MIGRATION + CONFIG_COMPACTION breaks the alpha.
> Just CONFIG_BOUNCE has no effect in 5 tries.

OK, so page migration is problematic. Thanks for confirmation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
