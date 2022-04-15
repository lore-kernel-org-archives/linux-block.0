Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8E7C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 05:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244019AbiDOFXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbiDOFWx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 01:22:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E694D5DA6E
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 22:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kyZluFDispHzU6EtFYly7NcsJxqecPrODfCIycc76so=; b=lxajSl0VIW6HxzwSuVTbCjpJUN
        TUlsFO3T5I1WnseNk+H0Sjaubf5jvVsGqKSzOhUrQqXbdmbpjRplZMc+Lu+4v4IXHIGGR7X02l81i
        MHJThegKRqq7i06Am2DjG25anX1Ww7DhWy1EC8Cz5rN8qGzilTUBRyIeY0dB5LfiaaIo8mkmfsmaA
        qtxk8Pq5I2bb19Xv/cyg4mszsq9aMKCTifMClXtLka7KsKpImMVFW3FuMNhK8tRXvzaKQv13uf6ZA
        njdhG6U71VeldAfRuKqUysrTPfSPdHgTzmyOD+3ZbTos26bwAyxucq0w/gyZH/eFIA0L3H0hk7ldh
        z2v7zHcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfENY-008ePJ-H3; Fri, 15 Apr 2022 05:20:20 +0000
Date:   Thu, 14 Apr 2022 22:20:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>, yi.zhang@redhat.com,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlkAlHe6LloUAzzN@infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 03:46:16PM -0700, Bart Van Assche wrote:
> I'm not sure whether the nvme-mp tests test any code that is not yet tested by
> any nvme or srp test. How about removing these tests since these tests make
> it harder than necessary to run blktests?

I haven't looked at the details recently, but if these tests still are
basically a copy and paste of the srp mpath tests I'm all for removing
them!
