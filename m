Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9F0C35242
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 19:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0B20848
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581708334;
	bh=tyju13CgUvbXPl2B9jTqCRzgT5ohzts5EZFKsOU+Dcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=to1uy8fNn7k5cc10k4ibBCXn5aWdpNt8LbSiyOK1MOLbUkcRvqvRoybn01bntXx/8
	 9tOIWRqplcCdGEAtlW8yrGZ+pCVCWTljBJ0onwDbHEJ1xaNbYWiXt/j2+cO9HCt+sw
	 Ge1//z+qHPS8KvOwDGcW3b6Z0r5Ka+Uf0naOkLPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbgBNTZd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:25:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbgBNTZd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 14:25:33 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1401F20848;
        Fri, 14 Feb 2020 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581708333;
        bh=tyju13CgUvbXPl2B9jTqCRzgT5ohzts5EZFKsOU+Dcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlSpAFXxo/0djg8LXjILp/J8v1iYkBQLN9it0AYOrkaH8NgJSjhuPxSL5Uyahgsvp
         024Jm8nkjI31Y8bN3p0U7FcdlXnGyDq+Fkru7gbW8s7cyPLAr5qhJ39D8KnOEtlQ8F
         QkFaU3SVIFzxb2uiUTyvHkEFrWVRkhlrdm940ffc=
Date:   Sat, 15 Feb 2020 04:25:26 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCH v2 2/2] md: enable io polling
Message-ID: <20200214192526.GA10991@redsun51.ssa.fujisawa.hgst.com>
References: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
 <20200211191729.4745-3-andrzej.jakowski@linux.intel.com>
 <20200211211334.GB3837@redsun51.ssa.fujisawa.hgst.com>
 <e9941d4d-c403-4177-526d-b3086207f31a@linux.intel.com>
 <20200212214207.GA6409@redsun51.ssa.fujisawa.hgst.com>
 <f516e2b2-1988-03ca-f966-5f26771717ff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f516e2b2-1988-03ca-f966-5f26771717ff@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 13, 2020 at 01:19:42PM -0700, Andrzej Jakowski wrote:
> On 2/12/20 2:42 PM, Keith Busch wrote:
> > Okay, that's a nice subtlety. But it means the original caller gets the
> > cookie from the last submission in the chain. If md recieves a single
> > request that has to be split among more than one member disk, the cookie
> > you're using to control the polling is valid only for one of the
> > request_queue's and may break others.
> 
> Correct, I agree that it is an issue. I can see at least two ways how to solve it:
>  1. Provide a mechanism in md accounting for outstanding IOs, storing cookie information 
>     for them. md_poll() will then use valid cookie's
>  2. Provide similar mechanism abstracted for stackable block devices and block layer could
>     handle completions for subordinate bios in an abstracted way in blk_poll() routine.
> How do you Guys see this going?

Honestly, I don't see how this is can be successful without a more
significant change than you may be anticipating. I'd be happy to hear if
there's a better solution, but here's what I'm thinking:

You'd need each stacking layer to return a cookie that its poll function
can turn into a list of { request_queue, blk_qc_t } tuples for each bio
the stacking layer created so that it can chain the poll request to the
next layers.

The problems are that the stacking layers don't get a cookie for the
bio's it submits from within the same md_make_request() context. Even if
you could get the cookie associated with those bios, you either allocate
more memory to track these things, or need polling bio list link fields
added 'struct bio', neither of which seem very appealing.

Do you have a better way in mind?
