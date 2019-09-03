Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6833C3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 09:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741652173E
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 09:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byg94gcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfICJGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:06:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfICJGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 05:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YPCDGE3Hww9flDWWiuiuokrBPc9+XsL9tDSdubFn6Dw=; b=byg94gcQ2JwZuBhpY7tQAWGVS
        LzNMXsV1T1amC28QVRwmeF2H8ZpUh18pgFuvSqaUdkhDUunI3uLrqfj4PUC9lDWuhY8Bv1SnkjUUz
        fXzt7DEYdiUCCMLI5FeYlpFRygN2i1qdBifY4PqxSssUast94cnG1pz1jPy+Bdu23RD4Z7srbaT4w
        480qAeZg7emRMbBV867F+0QFKv/MwWqS8h0zb8fNfu0DTcuB4loDVwmfOwL5v7GOji80yCMcp9zTi
        oUPGmC+E0f9LLpt4e4td7EXSCSf9GqvAEsIHZUBLotIyQe+4eIA09wkB8Vq++9pRj8IJWaiE6ODu3
        0HBiMCy+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i54lz-0002mr-GV; Tue, 03 Sep 2019 09:06:47 +0000
Date:   Tue, 3 Sep 2019 02:06:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 3/4] Documenation: switching-sched: Remove notes about
 elevator argument
Message-ID: <20190903090647.GC10407@infradead.org>
References: <20190828011930.29791-5-marcos.souza.org@gmail.com>
 <20190901232916.4692-1-marcos.souza.org@gmail.com>
 <20190901232916.4692-4-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901232916.4692-4-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 01, 2019 at 08:29:15PM -0300, Marcos Paulo de Souza wrote:
> This argument was ignored since blk-mq was set as default, so remove it
> from documentation.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
