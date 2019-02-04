Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1969C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B761B2082E
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j223mACj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfBDPoT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:44:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731352AbfBDPoT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 10:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rsk552y1kwmLW+Bj9fNTE1RQXk8/xNRi5LW+9Vv/1FA=; b=j223mACjE9U1Q7WhHb6zUo4Q+
        Wm3UJlPJ5d2n7ei86JkKyhwK9a6sGpk19yEVm1S9Rczld++haayVvcS/41BQNnAFjnGxHTS8tELsm
        sK69BWoMIpLcxmv4oEmdyO1XPuU8RHCb7ysUX0ZgUAwteIIVzs0+wZRdKgnRthnQC3IURKNisFkqE
        yCyw+gzeSLlDJ2TQS5Z+Ho/a7KJ0tPBm9h8cdJi0E/YC+HnCjSfWevO+UtHKVewxWayigfs04z9o8
        KVyXyI4k4tWLS8Lt1kVJRVh/xJm48ONNUVqRiJYv3WXXLUtInkdgp3Mpm6+IJnexicgMVjNd8PayF
        PkFd1GTnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqgPn-00079K-OP; Mon, 04 Feb 2019 15:44:07 +0000
Date:   Mon, 4 Feb 2019 07:44:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Scott Bauer <sbauer@plzdonthack.me>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 00/16] block: sed-opal: support shadow MBR done flag
 and write
Message-ID: <20190204154407.GA27214@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190204150415.GO31132@infradead.org>
 <20190204153138.GA6512@hacktheplanet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204153138.GA6512@hacktheplanet>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 04, 2019 at 10:36:10AM -0500, Scott Bauer wrote:
> > Which brings up another question:  how do we get a properly maintained
> > version of the sed-opal tool up ASAP?  It's been a bit bitrotting
> > unfortunately, and the documentation and error handling hasn't been all
> > that great to start with.  Are we going to find a good home for it?
> > Util-linux for example?
> 
> I would also like to get it off my github and into a proper location as well.
> 
> Christoph, do you know off hand how we would get it in util-linux?

Maybe just ask util-linux@vger.kernel.org if they are interested?
