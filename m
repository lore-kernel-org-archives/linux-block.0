Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082EBC10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 07:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EF821738
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 07:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0YJQGRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDGHvZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 03:51:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfDGHvZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 03:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZwPAuRwarno1qHU3/71DykSg1HdMD2lVJV4I2hDtuuQ=; b=m0YJQGRDjhVG3EMLdkPgJNxER
        UR1d9SdCeeioggL/Ll8ettjUrtlHdpn5zViBl0D6/OXx9fSIBO1ECEa6ox9lGC9K5txX29YRJ5XYl
        Wj0rx3Nxu9tcOnuURSiIQb6m88UJghXcE8ztdj+Igj7kpf1VbFh8Vjj7ku8zzfmOCXxyGrZWi+SZg
        tt5n1S0eJ/sYMpjA1SOz1H+fyqTe0N1VbkCAD8tV9/BYf8ZOY2CIRwaGpreul8PLYmaQT+LEFKeEL
        5ONp9khnjfzepcsgbhTSVA7jq85kAj65Q1CqZetka4IimsFM40RHffn3JRtqurd7MOjFC/b/Nk+J3
        3c6c27Rqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hD2aJ-0005pN-NP; Sun, 07 Apr 2019 07:51:23 +0000
Date:   Sun, 7 Apr 2019 00:51:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <keith.busch@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
Message-ID: <20190407075123.GA22003@infradead.org>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 05, 2019 at 05:36:32PM -0600, Keith Busch wrote:
> On Fri, Apr 5, 2019 at 5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> > Looking at current peak testing, I've got around 1.2% in queue enter
> > and exit. It's definitely not free, hence my question. Probably safe
> > to assume that we'll double that cycle counter, per IO.
> 
> Okay, that's not negligible at all. I don't know of a faster reference
> than the percpu_ref, but that much overhead would have to rule out
> having a per hctx counter.

Can we just replace queue_enter/exit with the per-hctx reference
entirely?
