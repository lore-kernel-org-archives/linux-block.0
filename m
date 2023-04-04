Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392F5C761A6
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjDDPUD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDDPUD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:20:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF681991;
        Tue,  4 Apr 2023 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tj3kQ/xkjwh/FcJIzh7Im+u/6vip0vVNABi+NEaNlls=; b=fxH/m3jrPiy5C8p1+aO8N15Cqv
        o4PpDeo3z3AL69aT8MumPpTQH+y3QdMrIwCtP3JWwWWZKVm3Oe+bLgSyStEk80WYqZx1gir2ZSB98
        jreo23KbFLeamVv/MB09ie6sjjXD7IistZkL2LLU2H+x/QQN6wdyfBUdn5YvdflqxG5UnXbwkIwru
        /GtWbVJpVpgoWMMOljkiNEDbtrnwHEHreAcEIgwZZVPAxUwpvnaPNM2NwV/ZY86Ukdt1UsfW+95ME
        6sR+0rASeI1o6XaUFaBfq/7glY7yaMMR6cwvtDa7ImcUActFdUXxZ3nzxmpdjXsbm/VlciOzbgy0x
        VbohhvOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiS1-001xkd-1S;
        Tue, 04 Apr 2023 15:20:01 +0000
Date:   Tue, 4 Apr 2023 08:20:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCxAIR8pxOfSE6OR@infradead.org>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org>
 <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org>
 <ZCsAhDpsiNWpiAxS@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCsAhDpsiNWpiAxS@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 03, 2023 at 12:36:20PM -0400, Kent Overstreet wrote:
> But this was all right there in the original commit message. And to be
> honest Christoph, these kinds of drive by "let's focus on the easiest
> thing to measure" comments are what I expect from you at this point,

I'm really just curious what the motivation is.  The code does not
seem much cleaner to me as the user of the API, and it doesn't reduce
code size.  Maybe there is a good reason for it, but then it needs to
be very clearly stated and you need to sell people on it.

Starting to get personal instead tends to not help to convince your
reviewers that it's really useful in general.
