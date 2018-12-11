Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB0C07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2BD2084C
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IFQvOj97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2BD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeLKOGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:06:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeLKOGu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 09:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UvLFsa9SZ6uuPmy2x9nKquz5bZPQJpo4zbQgSy7l+iU=; b=IFQvOj97WvSLGwW7N8k2xNzMF
        x2CuZp6jI5qcIvpIkUtjba3wJVaIUYEiy0lXoJoiXBK5bo3IlEUu8qFkSK9YKoeaPJUz7qHIFG4bZ
        RZkO6PGaB7JiI4L1uLidCt7Khp7yGwJWrAJckDsnmMN5L154+XZd+TQoxobFAoiS74fvUYs0+58GR
        av63+NKnumfOSE5pK+DPdOfQwtWrrjTuQz0J4kVGS3x1rfLWVjesuGZrMEs4ekNi40qob6EtcR+eQ
        fpaEXKr7lHPTuzR85qocOdQga9Ucr77mKepHxWDJsnEDFzgj0vx33welrzjspnt83BT4s/oOWeZ5z
        6AaGS9nGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWigN-0003LL-CY; Tue, 11 Dec 2018 14:06:43 +0000
Date:   Tue, 11 Dec 2018 06:06:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     axboe@kernel.dk, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, davem@davemloft.net,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, jbacik@fb.com, michaelcallahan@fb.com,
        snitzer@redhat.com, osandov@fb.com, keith.busch@intel.com,
        ming.lei@redhat.com, shli@fb.com, dennisszhou@gmail.com,
        adouglas@cadence.com, jank@cadence.com, rafalc@cadence.com
Subject: Re: [PATCH 0/2] scsi: ufs: add real time/inline crypto support to
 UFS HCD
Message-ID: <20181211140643.GA6576@infradead.org>
References: <20181211094910.GA28288@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211094910.GA28288@lvlogina.cadence.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch 1 is missing in your series.

But even without looking at it I think your design doesn't make a whole
lot of sense.  If the encryption is implemented in the ufs driver you
should not need device mapper support for it, just ufs driver support
and maybe a little block layer glue.
