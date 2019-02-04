Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3997C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8533214DA
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qym50gEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfBDOqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:46:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfBDOqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 09:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OsGEE78JUoskJbHOECoLD/JlbU9Mi9/yWhn4Mf5h8io=; b=qym50gExDlkAfbe8DgEm8GB+1
        3UrX7KWuJ+CNEdXb7LfJXUkd7+Td47gRDgUh9fjniBvDOxm0AdNLVg5/7g0isXpRfTPn52+taQOlJ
        LSqxVtAUnW4u26sYKqFI8aFwNswxbq+v1dYcHkVC+NDSYfET5N47A2g8s/zwfnN8j3K9EU1DCR/za
        HXeSTSkMvWCYBJOtu4hlFtoOHoSyr9keck5kZ/T/ZZQFkpRUbUQvdL9GnNvcjBElQgbeXRVME/y7X
        nLwSa8GSaxzanFefvS+W1lq5PiOvpKDyidsJdQlZ/7S5sw6sV3bdQwewQQ5fNejrgC4OZkPFOp3X3
        Lv8UGJZdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfW4-0001EW-Q8; Mon, 04 Feb 2019 14:46:32 +0000
Date:   Mon, 4 Feb 2019 06:46:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 07/16] block: sed-opal: reuse response_get_token to
 decrease code duplication
Message-ID: <20190204144632.GG31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-8-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-8-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 09:50:14PM +0100, David Kozub wrote:
> response_get_token had already been in place, its functionality had
> been duplicated within response_get_{u64,bytestring} with the same error
> handling. Unify the handling by reusing response_get_token within the
> other functions.
> 
> Co-authored-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
