Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EE2C4CEC4
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 16:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02A6218AF
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 16:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GvilIA4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfIRQi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:38:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfIRQi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 12:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ITimMHE51XTbgvvKwOn06fBbBvNL//zS0+nNhe0cDik=; b=GvilIA4pmSEDd7xNIWS5P/1E8
        0Wymiel7VN3+nM9iSGDwcSZimB0pn02p+K223yfF6/zYMxKJvPmEzdKQjh5StiOjFUmaweFRMATHk
        kb5AWQKQRdVBclCSngo16Q5Ypqjr34CzJIRAj8TIo5VaqBHk36hBDTN4NP58ZMx0XDuQFBTD8BsDQ
        vgMELhHzYwCo5iRpLnh1hUCN4H/7ZqTS5eCoRirtcUUnLqzqV9ljX+00zI2d6RnbhlnOB5WipXy4x
        A6u1rirwpvWKg90rxZWviTrrtYsytgptQ0Rli6WNJeVVn/g1vKYtR/Xu7NyccJbf5Ffe1c6lFB9xM
        2dWOBkNXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAcyI-00041d-GB; Wed, 18 Sep 2019 16:38:26 +0000
Date:   Wed, 18 Sep 2019 09:38:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, xiubli@redhat.com,
        josef@toxicpanda.com, mchristi@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCHv2 0/2] blk-mq: Avoid memory reclaim when allocating
 request map
Message-ID: <20190918163826.GA14377@infradead.org>
References: <20190916021631.4327-1-xiubli@redhat.com>
 <20190916090606.GA13266@infradead.org>
 <8c08e9f8-cf71-8fcc-cff3-0d92dd859a59@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c08e9f8-cf71-8fcc-cff3-0d92dd859a59@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 16, 2019 at 10:52:33AM -0600, Jens Axboe wrote:
> On 9/16/19 3:06 AM, Christoph Hellwig wrote:
> > On Mon, Sep 16, 2019 at 07:46:29AM +0530, xiubli@redhat.com wrote:
> >> From: Xiubo Li <xiubli@redhat.com>
> >>
> >> To make the patch more readable and cleaner I just split them into 2
> >> small ones to address the issue from @Ming Lei, thanks very much.
> > 
> > I'd be much happier to just see memalloc_noio_save +
> > memalloc_noio_restore calls in the right places over sprinkling even
> > more magic GFP_NOIO arguments.
> 
> Ugh, I always thought those were kind of lame and band aiding around
> places where people are too lazy to fix the path to the gfp args.
> Or maybe areas where it's just feasible.

The way I understood the discussion around the introduction of these
flags is that we want to phase out GFP_NOIO and GFP_NOFS in the long
run, given that ammending all calls is basically impossibly, while
marking contexts is pretty easy.
