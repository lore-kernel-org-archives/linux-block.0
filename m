Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213C5C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F46214DA
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gT6ON60R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfBDOsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:48:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfBDOsU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 09:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PPv0OJqQVcoWsAJ49m87BQt5Nw5xa1pBHuOMqSmT5IE=; b=gT6ON60R+/EBjb+canoFiD+jd
        T5H9SivIVncP/ccCsHJhHLV9ioxpnD0xXp0i3yuyj5+l1vF/Oil7vuLhZCujyjF0vOEtC3UVLtV5M
        ydW5wSZkxZcUwsgTscBOv3qRJfO1TrR7Uc9ZBDtao0IdSVjkqDJgf8Pgb9rwjJHK1GHGbHUAduRv4
        lZJ355iicnIB7fRREGQyMz/I+GXIwxGbosg6b+HnMndSIW/D1PJe12h/8QDDfCg9i3uFR7Aa+xN7R
        TU1L7iRD8sC+kIEnoBsn1ZE1EpYpi1LqMGSof3mL5zNeK4REY5uXBloWnVCjRR6ulASZjryFongbB
        PzeH7kV0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfXg-0001gM-1M; Mon, 04 Feb 2019 14:48:12 +0000
Date:   Mon, 4 Feb 2019 06:48:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 09/16] block: sed-opal: split generation of bytestring
 header and content
Message-ID: <20190204144811.GI31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-10-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-10-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	start = &cmd->cmd[cmd->pos];
> +	return start;

No need for the local start variable here, just return the computed
address directly.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
