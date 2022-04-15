Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E5C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 17:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbiDORiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 13:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243809AbiDORiI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 13:38:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7269D64724
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=teOR/cZGDAbtuMMMO0g+9BDIDFltSmEuSfnpRCClzTw=; b=jlnJV/V/8sFACrK28YE5DoSEte
        VKQhfWiE2wZLtrXNjruvET4sUEtJxa6h+re/sHUe20r7EITCRxQSdsobxWfnSzwkwXe1MqY3nYmk8
        J6OfiH1oD1/+ausoAMTEqfSQa7Fv61nzcCsAZ6dUCUP1ooK817D5ZxiQvZZpZf3dam8pzQ1h2QRzp
        FlgJdOryu+MtxWm+olp9E9uPPTMgv5jIneTWF8lsOkvznVhhaOl27o1eNFLdB4LiVKOXIp7A0mop5
        gh6Vh7R901nL941KBHHoi2ktSq18sM9pVJkE+11RWwLUtl9TKdBJyrXvxAQySl8z34ZZDYos6HY1W
        sTeV4m7Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfPr3-00B0xy-NN; Fri, 15 Apr 2022 17:35:33 +0000
Date:   Fri, 15 Apr 2022 10:35:33 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        shinichiro.kawasaki@wdc.com, Klaus Jensen <its@irrelevant.dk>,
        linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <Ylms5eFt2w8Cp1NI@bombadil.infradead.org>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220415010945.wvyztmss7rfqnlog@offworld>
 <20220415035438.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <20220415043021.awhfncjjt22vyajg@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415043021.awhfncjjt22vyajg@offworld>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 14, 2022 at 09:30:21PM -0700, Davidlohr Bueso wrote:
> On Thu, 14 Apr 2022, Paul E. McKenney wrote:
> 
> > On Thu, Apr 14, 2022 at 06:09:45PM -0700, Davidlohr Bueso wrote:
> > > No idea, however, why this would happen when using qemu as opposed to
> > > nbd.
> > 
> > This one is a bit strange, no two ways about it.
> > 
> > In theory, vCPU preemption is a possibility.  In practice, if the
> > RCU grace-period kthread's vCPU was preempted for so long, I would
> > have expected the RCU CPU stall warning to complain about starvation.
> > But it still might be worth tracing context switches on the underlying
> > hypervisor.
> 
> Right, but both cases are VMs which is what throws me off, regardless
> of the zns drive. Or is this not the case, Luis?

The nvme controller timeout and rcu splat happens on an 8 core KVM
guest. The hypervisor has no issues reported.

Does that answer the question?

 Luis
