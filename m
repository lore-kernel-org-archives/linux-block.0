Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC99C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 06:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E37120821
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 06:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tbjuyVED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBEG56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:57:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfBEG56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 01:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+qXX1CPqB0w4F+ENybBfnk9lYaRaGvQE+5VZom2V/Xo=; b=tbjuyVED0xwEXFWlMll+cBTaj
        5coN4W8S7Ulo+KzpcZWQDVzg4RsbATWUo1rF/7u+E5qja+oJVXKs74qbUewKklYlDCiRw7oaC+K4l
        o5NhuTKpv2FsrA3hf3XiOvflY5GbHDZmisN+yaB0glnaut6268yaSN4eWvhdmA25AiS/fbxbakeyi
        cCOgd4/MFxNiUg0QPPaQrV17iHSPGnARSxiSISZG7h8tgH6OIzkcD04nkJQCncogqMcqV/DY0sehA
        ipmmaxNeZvHBYmacPawHZBLJRmPiVjnMpPAUqE/0VKLsLRzYxLSt7DwiW5J5r/YOXzQ0UJiPcy/NI
        xXDPDocuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqufu-0001mJ-SO; Tue, 05 Feb 2019 06:57:42 +0000
Date:   Mon, 4 Feb 2019 22:57:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 00/16] block: sed-opal: support shadow MBR done flag
 and write
Message-ID: <20190205065742.GB1868@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190204150415.GO31132@infradead.org>
 <alpine.LRH.2.21.1902042344420.10661@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1902042344420.10661@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 05, 2019 at 12:06:54AM +0100, David Kozub wrote:
> This will unfortunately trigger some changes (conflict resolving - e.g. if I
> move the last two patches in the current series forward, in front of the
> patches with new functionality). What is the proper procedure w.r.t.
> Reviewed-by tags which were already given? Common sense would make me keep
> them for trivial changes and remove them if the patch should be re-reviewed.
> Is that correct?

I don't think there is a general rule.  As long as the change is trivial
I keep them personally, otherwise I drop them.

E.g. if you just remove a few hunk because of new code that isn't
present now I'd keep them, if there are more complex changes to the code
flow I would consider dropping them.

> FWIW I also hacked together a tool to cover my usecase:
> https://gitlab.com/zub2/opalctl
> 
> The selling point is that it can handle passwords the same way that sedutil
> (https://github.com/Drive-Trust-Alliance/sedutil) does.

That actually is pretty nice, as it allows people to migrate over
(not that I've heard of a whole lot of usage of sedutil, but being
compatible to some extent is always nice)
