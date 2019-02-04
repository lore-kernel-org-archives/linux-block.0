Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37360C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AF22082F
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TVI1dtNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfBDOn1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:43:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfBDOn1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 09:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OmLsCG+gp0bmsADnf3/Pqc0qlzApnXnac80JJOqMX0Q=; b=TVI1dtNKit6ANKuWZp6e8WI94
        lZlyMKnpJDQlNIhWSrxTIgBBljgkoXlVgV36f0mdtzvR1L/7Rz6wIdiO87O4QurJknziAY4jZ5V8Q
        hLBd773jxIi52kEyCyUgZ3jC5o/CjvyoE//KIH58DmXraexoc+ibURiUecOJcolzLeLZAYqrntRch
        N5t8az6WulIXOf/LjVy3TY42pCKI6GB1N1YWegljoS7eKV47tkckQQhYrOl2mJZvm4F+a5c3i8Bed
        9684lIsfjuxpUysFvfyboIZdA1QBeUsVKJY2fXB/SuHw0dhhmkIYXWOmoqJnq4IPrzYLHS2MMWBCD
        c+I14loeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfT2-0008FZ-47; Mon, 04 Feb 2019 14:43:24 +0000
Date:   Mon, 4 Feb 2019 06:43:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 02/16] block: sed-opal: use correct macro for method
 length
Message-ID: <20190204144323.GB31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-3-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-3-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 09:50:09PM +0100, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> Also the values of OPAL_UID_LENGTH and OPAL_METHOD_LENGTH are the same,
> it is weird to use OPAL_UID_LENGTH for the definition of the methods.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Dave, when you resubmit other peoples patches you should also add
your Signed-off-by: line to the end of the signoff chain.
