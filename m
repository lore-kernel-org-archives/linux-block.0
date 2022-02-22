Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A8CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 08:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiBVIMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 03:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiBVIMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 03:12:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32515D19E;
        Tue, 22 Feb 2022 00:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=dul9sacnT62Fh6qrEyvfptELUnlOXPcLIgRbu5E5sqY=; b=uqX1NH1XmOuLv4BXXAnwW7Rty/
        fciJosUQiifkTTjspBfPQ5RHqP7OoaGX6myGjUPs03t+f8M+i6jyRISLVmIMmlRkr2iwNDDxZ9zo0
        jMu7HKTfOacSPTX8I5xBQ5+HDQ7byjZpWbUWs3KpEbJ3b7VUE8J4PVa3vtMhjd2uPGlKe7KMrWnMJ
        4k/yCBarQXDGAiffrCaQO15DOv6ky7PsWsLFuZuncjjK9ZvTBF96ITuGKlLdZzPq8UGwsYAeiYx8P
        1W34tiJGqh2rVcPYg2H6+n85a5rOqP0ECN8Zb8DAg9nJOBjj2cH5Bio+rNV98cglY7W1P0RdwZ91E
        HTETuCOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMQHP-008Sra-0y; Tue, 22 Feb 2022 08:12:15 +0000
Date:   Tue, 22 Feb 2022 00:12:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 2/6] blk-wbt: make wbt pluggable
Message-ID: <YhSa30p1cPm4CVCg@infradead.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-3-jianchao.wan9@gmail.com>
 <Yg4MQSUZZu9D+qJu@infradead.org>
 <6e6df16c-3609-71ef-c147-435920e59e8c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e6df16c-3609-71ef-c147-435920e59e8c@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 18, 2022 at 11:41:11AM +0800, Wang Jianchao wrote:
> 
> 
> On 2022/2/17 4:50 下午, Christoph Hellwig wrote:
> >> +struct rq_qos *wbt_rq_qos(struct request_queue *q);
> >>  int wbt_init(struct request_queue *);
> > 
> > 
> > Please move the wb_lat sysfs attribute into blk-wbt.c as well, which
> > removes the need to expose these two functions.
> > 
> 
> Given this patchset:
> (1) Do we need to reserve the wb_lat sysfs when we turn off the wbt ?
> (2) Do we need to disable wbt automatically when switch io scheduler
>     to bfq ? Or just tell the user turn off the wbt by themselves ?

I don't think this needs any changes to what is done there today,
i.e. keep the sysfs attribute around.
