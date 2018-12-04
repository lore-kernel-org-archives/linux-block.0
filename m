Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9659BC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B65E2081B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z3yMuV6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B65E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLDP1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:27:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDP1f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 10:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5O9Df77ebRM2C89HzkdGZHkFKfpCScfH+hDSV8FUFiU=; b=Z3yMuV6xj09Q/0pYqBmw3JqZ5
        QX+Jt49FlaDvqQQbz9nv64w+sRJ/UH446xhjVG6xzgOoDJ5U5hOThC02xoz73RQo5s0lmVyWwOerj
        J5tgYf4Dnt09mLtDa9OYwmOkCBazMJMtg5NhKpuLjpfW9f8j3TfEFVy8uSKKoHpj6qkDPA4VobARK
        Jq7OTy77qAZ3HXDkg2pV1voiXe9L29eQB0vpWGtLiouwDRBayNIJ0+tRdb0UL8vHWUSj0KQ/Uvh7c
        WAJsmn26VQgXY5aq3J0L1a61kXE+RC8IfJFKUmYaXIoFRIY2T/MdXcO7f/2vyM1/Gpoz+wm87arn/
        eVoqpxnpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUCbi-00083z-Uv; Tue, 04 Dec 2018 15:27:30 +0000
Date:   Tue, 4 Dec 2018 07:27:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        liuyun01 <liuyun01@kylinos.cn>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v6 0/2] arm64: provide a NEON-accelerated XOR algorithm
 extension
Message-ID: <20181204152730.GA30896@infradead.org>
References: <20181204014323.1438-1-liuyun01@kylinos.cn>
 <20181204150124.GA23762@infradead.org>
 <CAKv+Gu-9uWo3xnBdNjJ_FOyuy6ifqdABppRRdxiVm=-p9Bt=EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-9uWo3xnBdNjJ_FOyuy6ifqdABppRRdxiVm=-p9Bt=EQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 04:02:36PM +0100, Ard Biesheuvel wrote:
> On Tue, 4 Dec 2018 at 16:01, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Why does this go to linux-block?
> 
> Because xor_blocks() is part of the RAID driver?

The only caller of xor_blocks() seems btrfs.  And the RAID code has its
own list anyway..
