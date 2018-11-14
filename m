Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794C9C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EDC208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YUAI8JmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EDC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbeKOBZM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:25:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732367AbeKOBZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S5YsRjrMHSzTIBgDL4qdxjnXB/9TrC9VroP0XZjrq4w=; b=YUAI8JmELp01kGfM8IUEONXPN
        dyJ+ej1vlGV87ket41/Sy6mx3M3oU79LZGtHWsA3h5qLP6wwsRGnWQ2klZ/KWJ6VQvJlIr6O9zv27
        IZVSI7EkwkVrm/sp5toOsnCYAS8AGpUnWlbntCnbXxMkn5AaNKWeO/xrMXtiMf7JCAemC37T7T+/S
        MkjhjZc7s6/1uMVRx/pIgE8308TT1sBelOA+owP6WVdMFeEp6qD6qsJzgH+C7nNoff/R96SfUpex5
        Z17oA/l4777DA8xOCtiawRy4Da7PdXZip1AUROWhL9xp/mIZulaG9HpFFnQiFzDWzhgIMut//B6id
        cIEIl21Kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMwyy-00075T-7C; Wed, 14 Nov 2018 15:21:32 +0000
Date:   Wed, 14 Nov 2018 07:21:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 5/6] blk-rq-qos: inline check for q->rq_qos functions
Message-ID: <20181114152132.GB22186@infradead.org>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110151317.3813-6-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 10, 2018 at 08:13:16AM -0700, Jens Axboe wrote:
> Put the short code in the fast path, where we don't have any
> functions attached to the queue. This minimizes the impact on
> the hot path in the core code.
> 
> Cleanup duplicated code by having a macro setup both the inline
> check and the actual functions.

The inlining sounds fine, but please do it without the obsfucating
macros.
