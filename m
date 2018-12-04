Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56AAC07E85
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8898D2082D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YTTPLL+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8898D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeLDPB1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:01:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDPB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 10:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5nQcOv4YG5pbaMS1mQKMIJVQZs7BM8D/88sbx+ral2s=; b=YTTPLL+NQVle5NKGfsQEIe0zs
        W4AdYCtrdW5C449l0ZPAJwZ5koPU2p4ZQz/zTx8mD//z2NnZDtuLmAx+iGmrz6Rk6ncP8OV17tmEP
        1CtXeNDEZqpUGZmynAULjgcll4U4yVIqEFtnQ6YdT5+c/5bubmsm+mtczvZh3X2EYIqn+zAoaLpOF
        WnZ8wDkJqVxZ9fQ82gJBBW6n2JYe7XGd1hGL1XTGQfxGfWivMLfvemPeLtbFwWX0pwoFmo+z95J9W
        a3X8IDkaGgVzZBgSrRQdGTJu2JaUsV9/7//U0O3JIonlju1ZaMPKY6ADQmB2Pv5D5hXbyhJjM/iH9
        pNwOYp6mA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUCCS-0001B6-Bk; Tue, 04 Dec 2018 15:01:24 +0000
Date:   Tue, 4 Dec 2018 07:01:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     will.deacon@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v6 0/2] arm64: provide a NEON-accelerated XOR algorithm
 extension
Message-ID: <20181204150124.GA23762@infradead.org>
References: <20181204014323.1438-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204014323.1438-1-liuyun01@kylinos.cn>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Why does this go to linux-block?
