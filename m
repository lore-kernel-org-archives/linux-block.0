Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD2C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746B92148E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B2KFs0uY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfA1P6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:58:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfA1P6B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 10:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nKhBdv+Igs+P4UaZkx5EvY+zcrwZHuUbBgT3qdyrWfs=; b=B2KFs0uYk6Z2cMJtTiOz0FZvk
        y+i/NS8nc82gKsCjTl8y2jVXutywB+HEslfb1G6HO1yCP81BNZpGdCO5gm/jOTrDnM32YoPXgRFoC
        uyNFejzTKEx8nTPiOtWZBvuM94KiKeGUHDRpfJ57XVf9SudaYQJPdgDDIla1QbyisC6+Fu1H6IuCN
        PYgG32Z57QUW3OPvwShHmgHnQ6rnnN7wPv6uKlhjT7rt0X94KBjWcLRB8e0lwiohVakxGoXka+vQ2
        RkV/nxS3Pfq/lE6Cpf8JzdVS5jYXuuO8hwY37wZiU0ssyqT8MjPjs655sm0WHHM/MTizTm8ne7G3D
        ctHVUmkLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go9IG-0007oc-T1; Mon, 28 Jan 2019 15:57:52 +0000
Date:   Mon, 28 Jan 2019 07:57:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linuxarm@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: set rq->cmd_flags with bio->opf instead of
 data->cmd_flags when bio is not Null
Message-ID: <20190128155752.GA29076@infradead.org>
References: <1548337430-66690-1-git-send-email-chenxiang66@hisilicon.com>
 <1c34d6f9-8c3c-a7ff-a956-46e9dc3c2298@hisilicon.com>
 <20190128140716.GA18162@infradead.org>
 <55972c1a-051a-1396-6796-84f349830a35@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55972c1a-051a-1396-6796-84f349830a35@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 03:36:58PM +0000, John Garry wrote:
> As I understood, the problem is the scenario of calling
> blk_mq_make_request()->bio_integrity_prep() where we then allocate a bio
> integrity payload in calling bio_integrity_alloc().
> 
> In this case, bio_integrity_alloc() sets bio->bi_opf |= REQ_INTEGRITY, which
> is no longer consistent with data.cmd_flags.

I don't see how that could happen:

static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
{
	...

	if (!bio_integrity_prep(bio))
		return BLK_QC_T_NONE;

	...

	data.cmd_flags = bio->bi_opf;
        rq = blk_mq_get_request(q, bio, &data);

