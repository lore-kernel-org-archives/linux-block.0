Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE7DC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92C214DA
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tyw2N4it"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfBDO5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:57:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfBDO5l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 09:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ka3ApDo1KFkBB7AziKxoS5Q8SjUZY7kiFTCWcQkp8+0=; b=tyw2N4itmP7smkZxVHArZt99a
        my0Fk2yotEvqeFhPKKuvfpHPKfSrhnTAta5zVh6In9870upAYE+Py/PY8hVqQGPf/+G9TXWpDCXsw
        SiapeVItOaDZs3BiW3iuH/Zk2p6hsAJXxuWBA6eHz5Whkpu8vP9/zBo3S0L/Tz4fxkbwSMUh3BwWT
        svMSv92m4kQoRvZj2tfYPB+RpWXcJBTnAP//DCIeWwl0qhqGX/5vkZN9cuK791ihYVIKUliJVPB6D
        qGrZw2cQjcI6koOz1ygkzwP7n4yyHsPlPClGaZei9ddTtV3j6nVP+B84taZfUxlRtPAd5IfUCYcy5
        91Zny+wPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfgm-0004zW-GR; Mon, 04 Feb 2019 14:57:36 +0000
Date:   Mon, 4 Feb 2019 06:57:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 14/16] block: sed-opal: pass steps via argument rather
 than via opal_dev
Message-ID: <20190204145736.GL31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-15-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-15-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 09:50:21PM +0100, David Kozub wrote:
> The steps argument is only read by the next function, so it can
> be passed directly as an argument rather than via opal_dev.
> 
> Normally, the steps is an array on the stack, so the pointer stops
> being valid then the function that set opal_dev.steps returns.
> If opal_dev.steps was not set to NULL before return it would become
> a dangling pointer. When the steps are passed as argument this
> becomes easier to see and more difficult to misuse.
> 
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
