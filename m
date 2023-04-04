Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEB1C77B62
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 16:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjDDQJE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjDDQJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 12:09:02 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3601940FD
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 09:08:59 -0700 (PDT)
Date:   Tue, 4 Apr 2023 12:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680624537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyCLxViJqffO2RtjQVHeduVY3sH5QHnlhhux3iPUjvk=;
        b=wk8RQWlmOXB1XprrkDl7o+IHy+eTCznzjllx8djhLuzMyUZn21ffFyprwZAOxHmuZys1aK
        Y1F2tmJMjd9r6b8HV5lzmLFPv2ZiI08KE0JbsAnSwoVduSe4WFqYX556qOdTOc77F0EhtL
        3GP0ZPFh0v3gnWDIFBmDAJsXc90N0mw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCxLlraw6z00qrXD@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org>
 <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org>
 <ZCsAhDpsiNWpiAxS@moria.home.lan>
 <ZCxAIR8pxOfSE6OR@infradead.org>
 <ZCxGdj3JKl2RPUJW@moria.home.lan>
 <ZCxJd33jY6vbm2x2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCxJd33jY6vbm2x2@infradead.org>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 04, 2023 at 08:59:51AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 04, 2023 at 11:47:02AM -0400, Kent Overstreet wrote:
> > Yeah, you're not trying to advance the discussion here, you're just
> > restating your original position. I heard you, and I responded.
> 
> Hi Kent,
> 
> it might sound unusual to you, but yes, sometimes people ask questions
> to advance "the discussion" or to try to find out what someone else is
> actuall trying to do because it wasn't obvious.  It then greatly
> helps if you treat it as just a question and not a personal attack.

"Asking the question", when the question is basic and already been
discussed/responded to, can also be a form of obtuse trolling.
