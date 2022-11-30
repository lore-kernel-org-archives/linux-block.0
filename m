Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3DEC46467
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 15:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiK3P76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 10:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiK3P7z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 10:59:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E432D76C;
        Wed, 30 Nov 2022 07:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZBaZLAQcwXpgoc/wypFSnGvG1ormvMqRTKZGjeGBWso=; b=YftUeZ3edM8lh3hLMLYkvoIm89
        BxMFibmnOQOwhtduBbuDosrHkBE1rrJvFUHUECFI5o7XPdRF5WPEl7+mVzRrOal09xRXlmNITBVqw
        wDuXPsFsczEXCNNxYsTurNDni9una+CM6XGZ+3nX1BxOhaqajdhwzizSzo+zJjx2RzW6TqS/kW4M7
        k+y7qxo2sIKMwObnqvc1CqSN7I7dXBwWkH+2jwuxQv8T18OtJfYRAb9dAkZu6rfmnY6RFhMcUNcUV
        HGEBNnZG1PekSCXVo73TulcJwICZTck1WBGvPHO5HvYywy/1lalyQ+InzvyjuI4VoTrdtSl8aIm4+
        Q1m2xNMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0PUr-000E2B-I7; Wed, 30 Nov 2022 15:59:41 +0000
Date:   Wed, 30 Nov 2022 07:59:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Li Nan <linan122@huawei.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next 8/8] block: fix null-pointer dereference in
 ioc_pd_init
Message-ID: <Y4d97Ui+3ORzRhxF@infradead.org>
References: <20221128154434.4177442-1-linan122@huawei.com>
 <20221128154434.4177442-9-linan122@huawei.com>
 <Y4YWQcb4PMmIdzIM@infradead.org>
 <e46fdde5-f320-9276-72ec-0f5fb5b48ffd@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e46fdde5-f320-9276-72ec-0f5fb5b48ffd@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 30, 2022 at 09:32:58AM +0800, Yu Kuai wrote:
> > No, that now means it is removed to later.  You need to add proper
> > synchronization.
> > .
> > 
> 
> Can you explain a bit more? Maybe I'm being noob, here disk is about to
> be freed, and I can think of any contention.

Right now we need synchronization with e.g. open_mutex and a check
for a dead disk, which I suggst to add insted of creating a lifetime
imbalance.
