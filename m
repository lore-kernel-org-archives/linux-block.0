Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D69AC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CE5206B6
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="asVdSbVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfC1RHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:07:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfC1RHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 13:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=//JAcNLZUteK0g7i6WC7u0t4UGSViUgVaWpijq5Nhns=; b=asVdSbVoQnDgudWNUjvBlMGnn
        SHWgajVDbF/1desEOh9N9mHBp83lGr+86HPmXUFVx0hDHY6srn1cSV2DHkNUIVFEaarahQB6ArHJV
        IkMQcfZvgQphY1OikxCKjat5FR3hb+Rw26WgvH8aD+TWQijOj8bPyhz0LREfraEEH9mXuWoDlenq7
        CXqkkZ2djFOdNdovzMb4unTfxxCy1JGMQO9lOgNfnwurEqeORAq21T3K7U9p7/Tp+90b1mVN8H7pT
        DtZPIiekt3QC5Nnsd0dGCtuoGmyczYBPp0vdKwKMc+o9iARb94Kr9ZHzgjQhZsXNjwKF8YFRiDA5p
        O10fWG/6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9YVD-0002of-8m; Thu, 28 Mar 2019 17:07:43 +0000
Date:   Thu, 28 Mar 2019 10:07:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 14/16] block: sed-opal: pass steps via argument rather
 than via opal_dev
Message-ID: <20190328170743.GF27845@infradead.org>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1550103368-4605-15-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550103368-4605-15-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 01:16:06AM +0100, David Kozub wrote:
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
