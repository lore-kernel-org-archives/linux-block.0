Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE658C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E86220989
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 14:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DtW8guzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA1OHZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:07:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1OHY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 09:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vDCCNOwUm0Qt8G/hWqB2tUkiWFHll9WCDvoKYxad5T0=; b=DtW8guzVcMSB+Tzs45kNOSA9o
        rU1K04LWeKGspwX45lfk2e6mYAZmjCXVXoRM8Tqu/jNsXXPg/cVU+6cpdKRCNqNFgtQHAxY5j4FZt
        X0r54KJxgt1kN+OyF/4Z1muFa9fH5MyEOwsFUEJbIP9DkkDTKMFoTGZpwPUUpmPaqHcvowZQdNXL2
        CsKiGEZY+83A4j6mxHIKKmUHBImhfppYt20uYMyfwL98RmZCsQKa4M2PXd5ieNz+O1szpQV/KEJc1
        +bYW56P93NF4wVULtdEdAKqrcX9C8hYYUceJtHaU1YXkt5IAryMu6OaKGGGWLaIcleaFqZEpNxnVs
        VSGmIIM6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go7ZE-0007An-Un; Mon, 28 Jan 2019 14:07:16 +0000
Date:   Mon, 28 Jan 2019 06:07:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linuxarm@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        axboe@kernel.dk,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: set rq->cmd_flags with bio->opf instead of
 data->cmd_flags when bio is not Null
Message-ID: <20190128140716.GA18162@infradead.org>
References: <1548337430-66690-1-git-send-email-chenxiang66@hisilicon.com>
 <1c34d6f9-8c3c-a7ff-a956-46e9dc3c2298@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c34d6f9-8c3c-a7ff-a956-46e9dc3c2298@hisilicon.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > for rq->cmd_flags. It will cause dix=0 in function
> > sd_setup_read_write_cmnd() when enabled DIX, which will cause IO
> > exception when enabled DIX.
> > 
> > For some IOs such as internal IO from SCSI layer, the parameter bio of
> > function blk_mq_get_request() is Null, so need to check bio to
> > decise rq->cmd_flags.

We have data->cmd_flags to deal with the NULL bio case.
blk_mq_make_request initializes data->cmd_flags from bio->bi_opf
just before calling blk_mq_get_request, so I'm really missing what you
are trying to fix here.
