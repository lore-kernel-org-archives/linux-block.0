Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534F8C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1516E2075F
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XVfY8YtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgESPeP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgESPeO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:34:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5761BC08C5C0;
        Tue, 19 May 2020 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=XVfY8YtD2ktsUkrVWkukQD1w3A
        47hcD8dkci7bd9vAroOmWlfCI0c4ROAJ3AwCFwmV+MamQDRzN3EFC/bbsq3iOdm9eyubszA65BJz/
        1LskUjboJOudpQZnfZ2yhRM6RkdvvrYJca9z/6WUdRUu0vds6rrqIjvdfI9Y1wFpJiFnr43dkLWkG
        hnVjGS98BvEwiGztAA6kQuXBHv129KLS2Vp63BKNMbpx7N17m0SG7zBZPQC5ZNPoVUartanStdizf
        iFsaPDDsG9IG7D1aA1T+WrQ6wiHpjnzlW+I1v5avzWPK1lsVOw528s/nxeMHSBodDfrjp0DQ7obPo
        Tnnojgfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb4FO-0006OO-4p; Tue, 19 May 2020 15:33:38 +0000
Date:   Tue, 19 May 2020 08:33:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v5 4/7] block: move main block debugfs initialization to
 its own file
Message-ID: <20200519153338.GA21875@infradead.org>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516031956.2605-5-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
