Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B957C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623CB20823
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kIjDDL9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfC1RFo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:05:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1RFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 13:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=kIjDDL9/39W6Z8k9L6FHN3cB4
        ly+rkZBPuDXQO8khCRad0nixDFxTspUg756e9GKx3tQSTihL+nedMCeVvGwq3UHJJ7WHAXwhZMlKh
        k7qxaphIdOY/fJLWMZZfxKWC9cakf8vEP8u/zR1chXSd8WaFQYkRg9gg4jQiXPsO3MpRFSbnrJdQD
        vqQdRDJkHlsO7IeHw91OS4tEdOmpZBjo/Trg++WE/j/e0ZsVUmqACj7bRnj/VCRVJsn0X9dv7P+o/
        T5Xtlvbv3uJcJYVDV4ZWv1YTY8G+9ZeKCcNx4HvcSpGrjdjMPyQe9vqJV1TIjGu5+ObRj0Ns8VckX
        Wl/7+NT6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9YTF-0000rN-Ah; Thu, 28 Mar 2019 17:05:41 +0000
Date:   Thu, 28 Mar 2019 10:05:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 04/16] block: sed-opal: unify space check in add_token_*
Message-ID: <20190328170541.GC27845@infradead.org>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1550103368-4605-5-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550103368-4605-5-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
