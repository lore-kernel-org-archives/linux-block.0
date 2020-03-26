Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63065C2D0E7
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 09:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376D52073E
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 09:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olbIXlgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCZJ36 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:29:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgCZJ36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 05:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dG5pPHs14OBzWSVcRXLG0d0hpdMtIjiZ05XYggJN7Nw=; b=olbIXlgRMRYIuRBimP12omMlMf
        qniCU91DEn3QcBZif8E9ZHHXEHuxyEImoFcq421j3RYxfsEGB4HIt4ACQMQ4A52je9dlbLNu+l9R2
        DCZGhCnkyzbZKJdgbvSkRV5SR3Z76Zm71qw/x2GRBhrZ5B+iV4mAktYlQmLh6fbv+zN2SDyeJyiAr
        TMy9g1dH4+NmPyjVbAg/uKUnOvvBCDTSvrPPPmCgESua3nLpqouFCD4kGGDuSYC+U3fPKzTxmbCvM
        c6TPM73XIQ/CTiAQ0ucsBmDkG6gRa81JKCjhoMNeOHD3XAEpMwKBj4ZiWY77jkfq4kZk/3kctdhWI
        liblYJtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHOpT-0001iz-SO; Thu, 26 Mar 2020 09:29:35 +0000
Date:   Thu, 26 Mar 2020 02:29:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, axboe@kernel.dk,
        bob.liu@oracle.com, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, song@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] block: Introduce REQ_ALLOCATE flag for
 REQ_OP_WRITE_ZEROES
Message-ID: <20200326092935.GA6478@infradead.org>
References: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
 <e2b7cbab-d91f-fd7b-de6f-a671caa6f5eb@virtuozzo.com>
 <69c0b8a4-656f-98c4-eb55-2fd1184f5fc9@virtuozzo.com>
 <67d63190-c16f-cd26-6b67-641c8943dc3d@virtuozzo.com>
 <20200319102819.GA26418@infradead.org>
 <yq1tv2k8pjn.fsf@oracle.com>
 <20200325162656.GJ29351@magnolia>
 <20200325163223.GA27156@infradead.org>
 <yq1d090jqlm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1d090jqlm.fsf@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 25, 2020 at 01:23:33PM -0400, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > I am very much against that for the following reason:
> >
> >  - the current REQ_OP_DISCARD is purely a hint, and implementations can
> >    (and do) choose to ignore it
> >
> >  - REQ_OP_WRITE_ZEROES is an actual data integrity operation with
> >    everything that entails
> 
> If you want to keep emphasis on the "integrity operation" instead of the
> provisioning aspect, would you expect REQ_ALLOCATE (which may or may not
> zero blocks) to be considered a deterministic operation or a
> non-deterministic one? Should this depend on whether the device
> guarantees zeroing when provisioning blocks or not?

That's why I don't like the whole flags game very much.  I'd rather
have REQ_OP_WRITE_ZEROES as the integrity operation that gurantees
zeroing, and a REQ_ALLOCATE that doesn't guarantee zeroing, just some
deterministic state of the blocks.
