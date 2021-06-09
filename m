Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A2CC48BD1
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 18:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405BC613D5
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFIScj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhFISch (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 14:32:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F429C061574;
        Wed,  9 Jun 2021 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MjblxCUCOzYHrNducYPCvaRb+3zgVqvJu23vUfKX0+k=; b=c5rt3jzGtTLNFja84l9vIEupml
        eGOEFlvj9dNmIfk+6Cwy9PcL/LQVt3cMEVZtSmnByl1QZEO6YIPYfa6AB6/PqIFaAuyIwlo9D06/W
        s3SEiMt2QEDk6eHyiUM6BulEH6DNkGAVHJ/kc95mjKQh64MJQNFrSkZqF5H12dAXEqP2WzzfoYCCI
        7bRbx6/GMAyC8S+P5A4/fxJwlOWib2T27rZw/L75Fav5lwUYJ2AJ5bnCDsH+RhyhLExhggdOBHs5K
        v9nmZGEQbLijJOgIBFIxLpuPUDFaJFl867U1Cxcs1vgq+hffNi3AARq4+T7ArTxC6jvyumMy+ltho
        xFW/g8Cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lr2xw-000nJ2-9z; Wed, 09 Jun 2021 18:30:14 +0000
Date:   Wed, 9 Jun 2021 19:30:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ric Wheeler <ricwheeler@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
Message-ID: <YMEItMNXG2bHgJE+@casper.infradead.org>
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 09, 2021 at 11:05:22AM -0700, Bart Van Assche wrote:
> On 6/9/21 3:53 AM, Ric Wheeler wrote:
> > Consumer devices are pushed to use the highest capacity emmc class
> > devices, but they have horrible write durability.
> > 
> > At the same time, we layer on top of these devices our normal stack -
> > device mapper and ext4 or f2fs are common configurations today - which
> > causes write amplification and can burn out storage even faster. I think
> > it would be useful to discuss how we can minimize the write
> > amplification when we need to run on these low end parts & see where the
> > stack needs updating.
> > 
> > Great background paper which inspired me to spend time tormenting emmc
> > parts is:
> > 
> > http://www.cs.unc.edu/~porter/pubs/hotos17-final29.pdf
> 
> Without having read that paper, has zoned storage been considered? F2FS
> already supports zoned block devices. I'm not aware of a better solution
> to reduce write amplification for flash devices. Maybe I'm missing
> something?

maybe you should read the paper.

" Thiscomparison demonstrates that using F2FS, a flash-friendly file
sys-tem, does not mitigate the wear-out problem, except inasmuch asit
inadvertently rate limitsallI/O to the device"

> More information is available in this paper:
> https://dl.acm.org/doi/pdf/10.1145/3458336.3465300.
> 
> Thanks,
> 
> Bart.
