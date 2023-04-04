Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2392C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjDDP76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbjDDP7y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:59:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59DE1A5;
        Tue,  4 Apr 2023 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RUrE94gl/ViVmB1xNbveS/uYIqvXscWI6aBgCGiuIMY=; b=rLQO8a82G3QDeVRKKPAMWIBFcx
        oH+RG5Un7DJfjaWYFs6+pArlkMxfHkZvFajl43ZnFesZL/2ArSkKE/x7inGMWF8y1wYwTYVJ4jdGJ
        /1kjZR5g1elsbnWUGOS3PeXEPTfUURLQNSwtkHxa/xrbE4yS/K9Yv6NVRwfOyHj6xCQGwPQTNswFW
        TEK8cIzvtiedwv5tH1dik8patD+eZdRHfgyI8sBDPvMnXI7zsaCu8ENpJQz3ZyHfDbgJx50pvOWpn
        MO3hqNN6ucik2hcZuf4SsQgR6JrmlREP3KgOwTwpkgsXTUrRB5gpeqoy7sZmgqSosZ720DOHXtB96
        7PwSYzUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjj4Z-00288m-2m;
        Tue, 04 Apr 2023 15:59:51 +0000
Date:   Tue, 4 Apr 2023 08:59:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCxJd33jY6vbm2x2@infradead.org>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org>
 <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org>
 <ZCsAhDpsiNWpiAxS@moria.home.lan>
 <ZCxAIR8pxOfSE6OR@infradead.org>
 <ZCxGdj3JKl2RPUJW@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCxGdj3JKl2RPUJW@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 04, 2023 at 11:47:02AM -0400, Kent Overstreet wrote:
> Yeah, you're not trying to advance the discussion here, you're just
> restating your original position. I heard you, and I responded.

Hi Kent,

it might sound unusual to you, but yes, sometimes people ask questions
to advance "the discussion" or to try to find out what someone else is
actuall trying to do because it wasn't obvious.  It then greatly
helps if you treat it as just a question and not a personal attack.
