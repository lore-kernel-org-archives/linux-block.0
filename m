Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC40C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC0A20651
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="heyQdx+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDIJoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:44:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 05:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zx6C5JsUe6faTo75OXfPQ0cJ9akfAT5lqwFOCOcI+wE=; b=heyQdx+m0q9w5BcVNQYiGF8Bq
        MM1HPWbF55jwpQav54D5Iq9hp2gEV9yLkq0YJuatvCJDpmDJ+8jo5O8/nlsqys8cp5/0XWrv4Jyno
        8y6Yb0WoRA+wuBK2cU+DV3s0gYUSruPaE1WQvVpmBGR27W/lu4WsmxnBwDrNpf99S8NBCk798eGlK
        8u26+aCePJMhJl2xl+0fAPWiCMYpMNjjXl7+njxGw3qu8y+FUunUKMRfYps9yfP1Sk75xCOj0zGVc
        QomwpniASUMBYI+chAg51cipw+sW/Rx+GrLtpBY2j/5UscjTUnW4VusELJVwpTTRnV2P7g1sqYcwN
        b6sBUncQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDnIL-00068F-NJ; Tue, 09 Apr 2019 09:43:57 +0000
Date:   Tue, 9 Apr 2019 02:43:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] io_uring: introduce inline reqs for
 IORING_SETUP_IOPOLL
Message-ID: <20190409094357.GA23530@infradead.org>
References: <1554787314-27179-1-git-send-email-jianchao.w.wang@oracle.com>
 <20190409093717.GA15391@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409093717.GA15391@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 09, 2019 at 02:37:17AM -0700, Christoph Hellwig wrote:
> I really don't like the idea of exposing this to userspace.  Is
> there any good reason to not simply always allocate inline request
> up to a certain ring size?

Sorry - misread the patch.  The flag isn't actually user visible so
all is fine!
