Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1FC34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741BB206E2
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kySvMotf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBSQdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:33:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgBSQc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Iv9s1m6y0FbmfZ8mnurdq7ew1/pc50IKzonMUk6MHg=; b=kySvMotf4OaWku5JVAz2NwHg/0
        vkpIamQZgNbWtkloCyuH3tX+Nd9PwjCssEGOw81eA6DVfOupZFaDLkeROgtnLiOHwa6ExwNFEDKVF
        RVozgRl8QKjdHgRfnBGzTScRAJBYH9tarebGYyWa+dOfx4JVtWkFsemdcay8IkYoNPaDr7Aw85jbv
        fJS1L0rXfRHC3+exv+Aj5/81JzCSBqBuuo4lOkm6e50zDYAaVJtCPmPvT8X0HJVUfwTKkt/a5WZ3s
        rOY1DQWU//t06lTQsIOomS/vf+ZpctaThtqM6h3isLua9/BPfL9wGpFJ+Bw/QDcmRv9w21kyJRu1b
        j4nD8wTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SHS-0005f5-TU; Wed, 19 Feb 2020 16:32:58 +0000
Date:   Wed, 19 Feb 2020 08:32:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Simon Glass <sjg@chromium.org>
Subject: Re: dd, close(), sync, and the Linux disk cache
Message-ID: <20200219163258.GB18377@infradead.org>
References: <b7ad1223-4224-da46-4c48-50427360f31c@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ad1223-4224-da46-4c48-50427360f31c@wwwdotorg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 12, 2020 at 05:02:43PM -0700, Stephen Warren wrote:
> Jens et. al.,
> 
> If I dd to an SD card (e.g. via a USB SD card reader), is it required to run
> sync afterward in order to guarantee that all written data is written to the
> SD card? I'm running dd with a simple command-line like "dd if=file.img
> of=/dev/sdc".

Yes.  Or use of=dsync on the dd command line.
