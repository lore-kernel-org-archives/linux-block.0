Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F9C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 17:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjDDRLV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjDDRLV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 13:11:21 -0400
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D325B4
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 10:11:19 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680628276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SfNQzMQnV5G0sUJpcQd4isXTb9aoOYu+NvTnxsp8EvI=;
        b=CtIxww6xOOgBCj5q+4I2QDmpNNy8WIxdoOI7fMi5Ai5hFZjP+419sfrxDGIU8UuzxcYK4z
        EygdLGzFEWWlPMgrfAKEJx38WW+NKzLUhY8HAYV4zYmYWfdQwNsUU1O0f8uwDHUzg9k5Kk
        jOVNE3SVuK01PY+qToqZuZftc8y4c5g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCxaMIP/l7BeLzz7@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org>
 <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org>
 <ZCsAhDpsiNWpiAxS@moria.home.lan>
 <ZCxAIR8pxOfSE6OR@infradead.org>
 <ZCxGdj3JKl2RPUJW@moria.home.lan>
 <2bbdb38b-a3ac-5127-23c0-56badd113538@kernel.dk>
 <ZCxLGLdcN5wYnxfr@moria.home.lan>
 <86c63b44-7832-6a03-11d9-d389fdaf3c16@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c63b44-7832-6a03-11d9-d389fdaf3c16@kernel.dk>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 04, 2023 at 10:14:36AM -0600, Jens Axboe wrote:
> On 4/4/23 10:06?AM, Kent Overstreet wrote:
> > On Tue, Apr 04, 2023 at 10:01:58AM -0600, Jens Axboe wrote:
> >>>> Starting to get personal instead tends to not help to convince your
> >>>> reviewers that it's really useful in general.
> >>>
> >>> I know you and others like to talk a lot about what you want as
> >>> maintainers and reviewers - but I find that the people who are the
> >>> loudest and the most authoritarian in that respect tend not to be the
> >>> people who drive discussions forward in productive ways.
> >>
> >> One issue is certainly that nobody wants to engage with people that
> >> instantly try and make this personal, or just uncomfortable in general.
> > 
> > Yeah, you like to respond to technical discussion with a *plonk*.
> > 
> > *eyeroll*
> > 
> > Christoph can handle himself, he doesn't need you defending him.
> 
> I'm not defending Christoph, I'm trying to help YOU understand why
> your patchsets always turn sour. And I'm trying to get this toxicity off
> the list, because it's frankly not productive at all and it's hurting
> the developer environment for everybody else.
> 
> If everybody else seems like an asshole, maybe it's actually you? A
> little introspection would be prudent. If you can't change your tone,
> please just go somewhere else. I'm not interested.

Let's just leave this aside for now and talk about it at LSF.
