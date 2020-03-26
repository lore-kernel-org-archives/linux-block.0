Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB27C43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 14:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8077220775
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 14:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UepjjWiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgCZOqZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:46:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgCZOqZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 10:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8TwPFh8funJBhnnT2SeFgIP/csO3dTH9SO/ivFg6Uxs=; b=UepjjWiXc9vzYPwcUqhdIfi8zC
        m4KZWLMEHyvsO2cRfgXAJ32RTfI/M972gzAGipDF6F4QO4kiraCPQhrDbDzLQsc7PVPiwSMxgtfBs
        OlbPLimvj7YrM0GlAwRg7T08V16m3jsjEconFunvyhpyJFOysq0VYm+CsNGb/+uGjiiz1mgELA7xn
        HjJcUFsPCIu2q4NpYr/IoUFWpdViqKjIszlNGhrfB2wnP6VU2tKWQwffGcB0c2lsdO5H0BrnpcAkl
        HS9EvEFFnQBFRtXGySmWRD600rWIG0agEy44vBqJI7m79C9ZYXevI/WGLn+9eimjGI/ogG18GqJ5I
        kmBLDlqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHTlc-0002Pb-5G; Thu, 26 Mar 2020 14:45:56 +0000
Date:   Thu, 26 Mar 2020 07:45:56 -0700
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
Message-ID: <20200326144556.GA4317@infradead.org>
References: <e2b7cbab-d91f-fd7b-de6f-a671caa6f5eb@virtuozzo.com>
 <69c0b8a4-656f-98c4-eb55-2fd1184f5fc9@virtuozzo.com>
 <67d63190-c16f-cd26-6b67-641c8943dc3d@virtuozzo.com>
 <20200319102819.GA26418@infradead.org>
 <yq1tv2k8pjn.fsf@oracle.com>
 <20200325162656.GJ29351@magnolia>
 <20200325163223.GA27156@infradead.org>
 <yq1d090jqlm.fsf@oracle.com>
 <20200326092935.GA6478@infradead.org>
 <yq1lfnngp6l.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1lfnngp6l.fsf@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 26, 2020 at 10:34:42AM -0400, Martin K. Petersen wrote:
> I just worry about the proliferation of identical merging and splitting
> code throughout the block stack as we add additional single-range, no
> payload operations (Verify, etc.). I prefer to enforce the semantics in
> the LLD and not in the plumbing. But I won't object to a separate
> REQ_OP_ALLOCATE if you find the resulting code duplication acceptable.

I find it acceptable for now.  And I think we should find some way
(e.g. by being table driven) to share code between differnet opcodes.
