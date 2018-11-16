Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13180C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5B8208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSJpJQye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5B8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeKPTE6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:04:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeKPTE6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 14:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9SJaGapMJKlxDbHZuR/8lf9PbO6uQTNQRJswk+1+ctg=; b=WSJpJQyeEXhdGp+ISSQVix8j8
        F22elv/VyRuE+d1Ee8dP7YMZLPGAJH7a72NHxt+MTHg6+5WA8Vbp/yERsVU1Rkf2GqWR/D6lYkIVP
        oqGRAWWPJUtA4wh4m0lSWDSoXHlNbolRC82IUIA87sdUdXl+9zoQRZMf60//Fw0V437s27qT6/dGk
        qaBQ3sjVV0369qqHNHye0Ryht8NjpVzvrFiad9eMz/+MrZNip+3dHyiQ5mxyp1M7Bh3UWACao6KKl
        zeyosLDk/X1tb4NeTAepbV6wnVBZk9t+INZoGTWXzMimz2O48CMnTi4Y2ip8jyF5bi1x9YlUStoEo
        a+he0aruw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZsb-0001CI-6r; Fri, 16 Nov 2018 08:53:33 +0000
Date:   Fri, 16 Nov 2018 00:53:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
Message-ID: <20181116085333.GA4544@infradead.org>
References: <20181113214337.20581-1-david@fromorbit.com>
 <10a8dd78-7c00-8593-9f4e-b20eb1161b92@kernel.dk>
 <20181115010651.GD32603@ming.t460p>
 <20181115012201.GX19305@dastard>
 <20181115031035.GE32603@ming.t460p>
 <20181115221337.GY19305@dastard>
 <20181115222419.GV4235@magnolia>
 <20181116040457.GA19305@dastard>
 <20181116083232.GA9023@infradead.org>
 <20181116084658.GT23828@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116084658.GT23828@vader>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 12:46:58AM -0800, Omar Sandoval wrote:
> > > generic/349     [not run] scsi_debug module not found
> > > generic/350     [not run] scsi_debug module not found
> > > generic/351     [not run] scsi_debug module not found
> > 
> > Same here, btw.  Any test that requires modules is a rather bad idea.
> 
> I'll plug my vm.py script that supports running a kernel build with
> modules without installing them into the VM (by mounting the modules
> over 9p): https://github.com/osandov/osandov-linux#vm-setup

All nice and good, but avoiding complexity is even better :)

Especially as there should be no reason to only allowing to configure
something at module load time in this century.
