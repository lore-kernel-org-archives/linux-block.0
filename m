Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CC1C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 07:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EC221852
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 07:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iLvSk7z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeLSH22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:28:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSH21 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 02:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rN7cf6PJ1S/Bs+bWUViGAZoujcsoE+ptF5pR1pNet3s=; b=iLvSk7z31tQ5hyg1P037okPtW
        ieYtpbbZOmDEBLkTQUwfK6vz41LtntSQxN8yTnS/RVw584RfRR1uEppBNrk8jTojXLCPOLVQYZTHs
        o5TUP/mUrbpJ03l8ks5GhVZSAQ9FGifdYjG6MWgI20Tm0XBKIJaTKo+/Hf4GA0Dz7YY7ldv210fbH
        31qFvBv1Yh7PFRYFTPyVd+0l2IRGOdHayZHVOeD4UHruaT+0TwwyJSZbswfDaUpVY6ip75sLMPu2M
        qG1XcrmddMUqg8FlNa/4wRqFkHEI8FHcC6QZCRC7S+sbcBEZ93SXZd69ONhz/OkqoOHZQTAlqSFPH
        zuccvYZCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZWHF-0000W2-1U; Wed, 19 Dec 2018 07:28:21 +0000
Date:   Tue, 18 Dec 2018 23:28:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: remove the "clustering" flag V2
Message-ID: <20181219072820.GA1798@infradead.org>
References: <20181213151710.30036-1-hch@lst.de>
 <20181218070826.GA1787@lst.de>
 <yq136qui1q3.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq136qui1q3.fsf@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 11:23:32PM -0500, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > can we get this reviewed and merge before the end of the merge window?
> > That gets the clustering put of the way for the multipage-biovec work
> > from Ming which we want to land in the block tree early in the next
> > merge window.
> 
> I have been somewhat hesitant to apply this just before the merge
> window.  However, I did go through it fairly carefully and since it's a
> mostly mechanical change, I did apply it.
> 
> There were a few things I needed to tweak by hand and patch 9 forgot to
> update myrs and myrb.

Hmm, there should have been two patches to drop these flags entirely
for those, given that the DAC960 driver didn't have any such
limitations.  Not sure why those got skipped.  But I'll send follow ons
for that.
