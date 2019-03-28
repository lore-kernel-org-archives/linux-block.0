Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEAEC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE332183F
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QPKPoHl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfC1RGf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:06:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1RGe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 13:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uRLMmlCtxjK43/f+Dv/wuEqUOC5RktobzhD5YwYe8/4=; b=QPKPoHl9etGIR208j04fzT/zO
        yk7IIl/vAYHKo+or5sCDFOfMEmoI4Hl6GL5XqPVD1yBt0wCuBeA0x8n/q3FxW9By7MPZNgwbLeA2/
        F/zulW5SQpXtD7VXdVYbSo2Qt2cu1DtVvkAWJurJQ5KC98Tjr591VzYM9SH5CwBAYtrf+qgs0nDJb
        AYZxhdXRfNfbOPLI5nga/nPYpzfR9fmIaYGPfSRzY4rw2Aqk5ozVLY3xVr3h9zPar1fgETSD4qIIG
        rjPSkdMymib3UK4CUA2yFikh01UmB9oqCBbSojuylgF8GKsE5PPbHvFnAikuiwJDKZxbIruDT4QuC
        +DptLIU5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9YU2-000268-Tf; Thu, 28 Mar 2019 17:06:30 +0000
Date:   Thu, 28 Mar 2019 10:06:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 13/16] block: sed-opal: use named Opal tokens instead of
 integer literals
Message-ID: <20190328170630.GE27845@infradead.org>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1550103368-4605-14-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550103368-4605-14-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 01:16:05AM +0100, David Kozub wrote:
> Replace integer literals by Opal tokens defined in opal_proto.h where
> possible.
> 
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
