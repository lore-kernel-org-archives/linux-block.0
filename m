Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8314FC4321E
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 14:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiK2OZX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiK2OZK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 09:25:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729BA2E2;
        Tue, 29 Nov 2022 06:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ylwb4KCyca+jQJTbdW1raeSgIDIZEx3eWo3k4sH/7JI=; b=3jmd+PnWA2cHklZWXfXzE0YLxH
        P3Qt4u6ALN3HizAKCzkKmK+ufSt2091ZZsysN0o2kJLAqo3XpNU2hwD7duqzqdxKIqAIzG9/RkBPD
        0Nnpmd+8H+4zmuJwASUo2kjImy4VUZWKOM/rm2L8qseuxQquU+nZO2UOK50cVrck1PB46bjUHh2QP
        N2HHuOoWwcjpyBlGF0e540qKOr2VCwI4ImwR7szrlu3r7zK/+Q2SeBiYZE6ElUKqlJW56amItAyTU
        0F+vRxS/uoyh8RxMT3RDNXS/iKOZehuAXnPGMGJPTXgFJNhtQD7GoUwfe1jUXkgw7GyqJlANg09FF
        yLvUY30Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p01Xl-009Dk7-Af; Tue, 29 Nov 2022 14:25:05 +0000
Date:   Tue, 29 Nov 2022 06:25:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Li Nan <linan122@huawei.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 8/8] block: fix null-pointer dereference in
 ioc_pd_init
Message-ID: <Y4YWQcb4PMmIdzIM@infradead.org>
References: <20221128154434.4177442-1-linan122@huawei.com>
 <20221128154434.4177442-9-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128154434.4177442-9-linan122@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 28, 2022 at 11:44:34PM +0800, Li Nan wrote:
> Fix problem by moving rq_qos_exit() to disk_release().

No, that now means it is removed to later.  You need to add proper
synchronization.
