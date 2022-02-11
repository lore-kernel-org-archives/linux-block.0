Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC56DC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 06:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiBKGaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 01:30:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiBKGaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:30:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E22E2BF;
        Thu, 10 Feb 2022 22:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=AnKnKE0NJUwU4fWLsFwK5P4vKv
        Nlnff4sgxHX4kIet7nohl+ovUiBsRaxuklG3qM8nFuIOSe2F7/CKPBYOv/uf7QI5xdtYk+wld+Nqt
        4Rdp5nhiJAf+iAm0+3V9xvrwNTCTYkWET5ToSjZ7irdMc3V/fGhqRZI/CkHy8Uwxc1AURkpns3P/C
        D6ZqNIwlF5cQfYW0E/kwj1iWhKJ+lMY5+br/nch+ozqvbziT8ycMp6b7O7EZEeWa1eYKVSp42U57Y
        fowlDQ+r6xw8NWCx0h+cW+gnRpDLjZCiHDvP+7yXgBpxnLFpyqap+R8pjoaqtNhg0CFWp9XM4VUsg
        6cCcyABg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPRe-005zUu-JS; Fri, 11 Feb 2022 06:30:14 +0000
Date:   Thu, 10 Feb 2022 22:30:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     axboe@kernel.dk, hch@infradead.org, rostedt@goodmis.org,
        kch@nvidia.com, xiyou.wangcong@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v8 PATCH] block: introduce block_rq_error tracepoint
Message-ID: <YgYCdhgQ+PoudJvv@infradead.org>
References: <20220210225222.260069-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210225222.260069-1-shy828301@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
