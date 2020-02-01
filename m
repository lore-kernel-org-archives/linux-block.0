Return-Path: <SRS0=B3LW=3V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072B7C33C9E
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 08:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6E22067C
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oIO7D1Dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgBAIUm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:20:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgBAIUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Feb 2020 03:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gE9Mx3W9x+ojBglaKL+EtPiMsFFLFj22q4iMOnSc8TM=; b=oIO7D1DmZpP8/qRY7jm6xdQb/
        VPeEbhJkRP+/M27gI9gnFQ4p0zh/L4svRplLCAP9x9cTrhoIYGduRUHT9zjbk/ctMo1UXdcVlOpJv
        VYUbUYCj2/6yb0SZRHVPPbKsZjGDrR6HFB+a2Z8WALrd2uSfONMCycox4paInD6sMEqHJeHzeCE7Y
        QDX+YZJcEqkN3aDPVisx4RBep9af/vcUWuVonYXwAektJibZf8QhaEy8AAPBvzdE4LUn8S5KPz7ZZ
        /rPw7im7gZbz3tnqpp/BajGRsha5NSf0MR22+vh9iHsdKI1EKl/ydsHtpS/CdGLobDOs474H6ZSzg
        YnKzjERYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixo14-0003cQ-1S; Sat, 01 Feb 2020 08:20:34 +0000
Date:   Sat, 1 Feb 2020 00:20:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCH 1/2] block: introduce polling on bio level
Message-ID: <20200201082034.GA8423@infradead.org>
References: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
 <20200126044138.5066-2-andrzej.jakowski@linux.intel.com>
 <20200131063407.GB6267@infradead.org>
 <081badca-ab0f-f666-1e5e-71992f93a157@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <081badca-ab0f-f666-1e5e-71992f93a157@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 31, 2020 at 11:51:43AM -0700, Andrzej Jakowski wrote:
> On 1/30/20 11:34 PM, Christoph Hellwig wrote:
> > Can you explain this check?  This looks weird to me  I think we need
> > a generalized check if a make_request based driver supports REQ_NOWAIT
> > instead (and as a separate patch / patchset).
> 
> Original check used to reject polled IO for stackable block devices as "not
> supported". To solve that situation I introduced additional check to reject
> all non REQ_HIPRI requests. That check is not intended to generalize, like
> you indicated, but to conservatively select which requests to accept.
> Perhaps there is better way to do that. Any suggestions?

REQ_NOWAIT and REQ_HIPRI are completley unrelated concepts and they need
to be dealt with entirely separately.
