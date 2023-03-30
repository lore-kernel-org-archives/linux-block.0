Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA42C761A6
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 16:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjC3QUd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjC3QUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 12:20:32 -0400
Received: from out-23.mta0.migadu.com (out-23.mta0.migadu.com [IPv6:2001:41d0:1004:224b::17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8FB777
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 09:20:28 -0700 (PDT)
Date:   Thu, 30 Mar 2023 12:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680193226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wWLlciqwRfofnoVgofNDoDEIRXrlVm6b9CM/A7H2cxc=;
        b=SEFi96CLZZpO5S41cm2o4hB9YxU9oubwwDBdWVZufD5quY6qg6tIAEH0wCMjsRldsK0Pn2
        oZiIoYZdfOzRn5gusS/03gtKIGtioqX/BxrgPCXeevZq7jyqMgjB5H8pMBqM04oyCqHtUm
        bTREaKUzZ3ap7MU6Qi448ARAS5eqBFo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: [PATCH 1/2] block: Rework bio_for_each_segment_all()
Message-ID: <ZCW2xmJmVnFtRV2/@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-2-kent.overstreet@linux.dev>
 <ZCV3Q+TUMvTZZ/Tl@ovpn-8-19.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCV3Q+TUMvTZZ/Tl@ovpn-8-19.pek2.redhat.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 30, 2023 at 07:49:23PM +0800, Ming Lei wrote:
> bio_for_each_segment_all is supposed to be used by bio which owns the
> bvec table, so it is just fine to return bvec pointer by bio_for_each_segment_all
> to save extra bvec copy.

No. And you wrote this code, so I'd expect you to know this:
bio_for_each_segment_all() can _not_ return a pointer into the original
bvec table, it has to synthesize bvecs - same as regular
bio_for_each_segment() - because it has to break bvecs up into
individiual pages.

There was zero benefit to the way you were doing it, you were just
adding pointer access to something that was on the caller's stack.

> And the change becomes not efficient any more.

Based on _what_?

Code size doesn't change, as I already showed hch. What's your claim?
