Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59755C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 13:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDLNRk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjDLNRa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 09:17:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABEF7D93;
        Wed, 12 Apr 2023 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4VlHv/eebtSZNw6qu18EWYsd77UMuH83TrbZ82hi3l0=; b=wJABmqoHBB/1fbJ+CFk75TYDpj
        A2zXjfrZgJ++GI4OYOnjfDTS+OSmfq1uj9xYjZaSTVcKK0r6fSRhzj/WQ3bE/ET6bWUPDh+g39VMt
        KTElskCTjuo/Kvu27Qyyh6dxJvpvbPJPJmYNLjBowGg3WlAwxMdFG7YxSUcWGsAay1c9nqm1Vxn98
        N8YZqBRqYRrVR/AcQx/wP8sRKwxULN94IM7yOiU2koGBo8LKIpqaTLBGZlXZF1RoOU7kLBFF7Rs7w
        gHWu7CB35+j4NH//ricdi3SsKdWQBcURwfXDHNkF1A1UmW9o6mnbzs+nW1c7uyEcHDE9TS0tou5+E
        9GfhWBjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmaKv-006tS5-Kq; Wed, 12 Apr 2023 13:16:33 +0000
Date:   Wed, 12 Apr 2023 14:16:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Sunsetting buffer_heads
Message-ID: <ZDavMfPMwEeWa4uQ@casper.infradead.org>
References: <6ca617db-5370-7f06-8b4e-c9e10f2fa567@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca617db-5370-7f06-8b4e-c9e10f2fa567@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 12, 2023 at 12:18:29PM +0200, Hannes Reinecke wrote:
> Ceterum censeo ...
> 
> Having looked at implementing large blocksizes I constantly get bogged down
> by buffer_heads and being as they are intricately linked into filesystems
> and mm.
> 
> And also everyone seems to have agreed to phase out buffer_heads eventually.
> 
> So maybe it's time to start discussing exactly _how_ this could be done.
> And LSF/MM seems to be the idea location for it.
> 
> So far I've came across the following issues:
> 
> - reading superblocks / bread(): maybe convert to ->read_folio() ?
> - bh_lru and friends (maybe pointless once bread() has been converted)
> - How to handle legacy filesystems still running on buffer_heads
> 
> I'm sure this is an incomplete list, and I'm equally sure that several
> people have their own ideas what should or need to be done.
> 
> So this BOF will be about collecting these ideas and coming up with a design
> how we can deprecated buffer_heads.

Might be worth reviewing this thread:

https://lore.kernel.org/linux-fsdevel/20230129044645.3cb2ayyxwxvxzhah@garbanzo/
