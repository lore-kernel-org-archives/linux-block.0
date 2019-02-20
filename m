Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1602C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 09:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5952147C
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 09:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfBTJsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:48:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:42788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfBTJsQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 04:48:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9EFDAFBB;
        Wed, 20 Feb 2019 09:48:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 136A51E0880; Wed, 20 Feb 2019 10:48:13 +0100 (CET)
Date:   Wed, 20 Feb 2019 10:48:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
Message-ID: <20190220094813.GA27474@quack2.suse.cz>
References: <fb63a4d0-d124-21c8-7395-90b34b57c85a@linux.ee>
 <1c26eab4-3277-9066-5dce-6734ca9abb96@linux.ee>
 <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
 <20190216174536.GC23000@mit.edu>
 <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
 <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
 <20190219132026.GA28293@quack2.suse.cz>
 <20190219144454.GB12668@bombadil.infradead.org>
 <d444f653-9b99-5e9b-3b47-97f824c29b0e@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d444f653-9b99-5e9b-3b47-97f824c29b0e@linux.ee>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 20-02-19 08:31:05, Meelis Roos wrote:
> > Could
> > https://lore.kernel.org/linux-mm/20190219123212.29838-1-larper@axis.com/T/#u
> > be relevant?
> 
> Tried it, still broken.

OK, I didn't put too much hope into this patch as you see filesystem
metadata corruption so icache/dcache coherency issues seemed unlikely.
Still good that you've tried so that we are sure.

> I wrote:
> 
> > But my kernel config had memory compaction (that turned on page migration) and
> > bounce buffers. I do not remember why I found them necessary but I will try
> > without them.
> 
> First, I found out that both the problematic alphas had memory compaction and
> page migration and bounce buffers turned on, and working alphas had them off.
> 
> Next, turing off these options makes the problematic alphas work.

OK, thanks for testing! Can you narrow down whether the problem is due to
CONFIG_BOUNCE or CONFIG_MIGRATION + CONFIG_COMPACTION? These are two
completely different things so knowing where to look will help. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
