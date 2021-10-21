Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279BAC433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA2260FC0
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhJUIcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhJUIcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 04:32:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D57C06161C
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=gJBBk8FeK8K5VPTKfrKMueRBgA
        5bry8936/4ifR7l36wPrLdQtjQ4PQoBXjkibwtgluHHbfQ04nMbohVcI9+hmSzR+XblkLI6U2EgBk
        SMSmnTrRC9WsvLQoOXkBre7aUlH7LLogNCevvjq7Qs1SgoyU0XRJZif+AIdO20W3lohoTMI4U9TYE
        +7t/jUyEtc60Y1K7Da8O0Z3H6W7QKhMv+K8g69D5rSNZsGY6x6azoqXuN4zj6A4/DxxMeXU6q29AG
        tRsZ07VQ1d0HnFcfuDTHN4xtZM9u36oWNmvJmnKwhgSItUhVOxAEc8kZvIrhx2HPMVdDwITJzwYhP
        Cg1GGgjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdTSy-006quA-Va; Thu, 21 Oct 2021 08:30:24 +0000
Date:   Thu, 21 Oct 2021 01:30:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] block: clean up blk_mq_submit_bio() merging
Message-ID: <YXElIFr6EE2Cy7zL@infradead.org>
References: <cover.1634755800.git.asml.silence@gmail.com>
 <daedc90d4029a5d1d73344771632b1faca3aaf81.1634755800.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daedc90d4029a5d1d73344771632b1faca3aaf81.1634755800.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
