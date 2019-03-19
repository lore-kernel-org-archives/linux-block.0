Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6545FC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387A220857
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 07:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfCSH6a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfCSH6a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 03:58:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B2953082E3F;
        Tue, 19 Mar 2019 07:58:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92C0C611DC;
        Tue, 19 Mar 2019 07:58:21 +0000 (UTC)
Date:   Tue, 19 Mar 2019 15:58:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] sbitmap: order RW on old associated instance and setting
 clear bit
Message-ID: <20190319075815.GA28327@ming.t460p>
References: <20190319042447.27580-1-ming.lei@redhat.com>
 <9e784c48-2865-a14a-d8f4-e6c74f258f48@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e784c48-2865-a14a-d8f4-e6c74f258f48@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 19 Mar 2019 07:58:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 19, 2019 at 01:17:31PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 3/19/19 12:24 PM, Ming Lei wrote:
> > @@ -591,6 +591,15 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
> >  void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
> >  			 unsigned int cpu)
> >  {
> > +	/*
> > +	 * Once the clear bit is set, it will be visible to allocation
> > +	 * side.
> > +	 *
> > +	 * This memory barrier orders any READ/WRITE on the to-be-freed
> > +	 * asssociated instance for avoiding potential use-after-free, and
> > +	 * its pair is the memory barrier implied in sbitmap_get().
> which one ?

test_and_set_bit_lock() in __sbitmap_get_word().

> 
> > +	 */
> > +	smp_mb();
> 
> smp_mb_before_atomic should be enough.

Right, will change to it in V2.

Thanks,
Ming
