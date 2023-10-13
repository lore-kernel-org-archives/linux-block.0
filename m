Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D867ECDB47E
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 12:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjJMMY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Oct 2023 08:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjJMMY2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2023 08:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C0BD
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2023 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697199823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwN+VRkxykWHFEl4T0SvO4kStJ12qK5OjC3MhcTM/F4=;
        b=Z1Pz5RNY4VSO7SHu5WFaKhdPBOOcVGhsD6Ls+gA12lMza6DxyQMkCJX/XBMadpPkyk84hx
        bUSf9Cl6vmreS/S76z93HfWrWcmVVsTgYfczIY2970j7r2VyzhcrPyxgpDXyr0J2yaqTcr
        EL2UHFTMYr/xa172zJ9FQX0RiwOHMjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-Tn6ZvY3WOyGPTjrkKiO8Hw-1; Fri, 13 Oct 2023 08:23:38 -0400
X-MC-Unique: Tn6ZvY3WOyGPTjrkKiO8Hw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEE4F81D785;
        Fri, 13 Oct 2023 12:23:37 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7E13903;
        Fri, 13 Oct 2023 12:23:32 +0000 (UTC)
Date:   Fri, 13 Oct 2023 20:23:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>
Subject: Re: [PATCH] blk-mq: add module parameter to not run block kworker on
 isolated CPUs
Message-ID: <ZSk2wNH4KIR4rR+N@fedora>
References: <20231010142216.1114752-1-ming.lei@redhat.com>
 <ZSWb2DNV9cIPYv5H@slm.duckdns.org>
 <ZSkpUFlw8FINofLG@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkpUFlw8FINofLG@lothringen>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 13, 2023 at 01:26:08PM +0200, Frederic Weisbecker wrote:
> On Tue, Oct 10, 2023 at 08:45:44AM -1000, Tejun Heo wrote:
> > > +static bool respect_cpu_isolation;
> > > +module_param(respect_cpu_isolation, bool, 0444);
> > > +MODULE_PARM_DESC(respect_cpu_isolation,
> > > +		"Don't schedule blk-mq worker on isolated CPUs passed in "
> > > +		"isolcpus= or nohz_full=. User need to guarantee to not run "
> > > +		"block IO on isolated CPUs (default: false)");
> > 
> > Any chance we can centralize these? It's no fun to try to hunt down module
> > params to opt in different subsystems and the housekeeping interface does
> > have some provisions for selecting different parts. I'd much prefer to see
> > these settings to be collected into a central place.
> 
> Do we need this parameter in the first place? Shouldn't we avoid scheduling
> blk-mq worker on isolated CPUs in any case?

Yeah, I think this parameter isn't necessary, will remove it in V2.


Thanks,
Ming

