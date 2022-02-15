Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37A6C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 07:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiBOHIc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:08:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiBOHIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 02:08:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE399A4F2
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 23:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4aeSjr+Hlvj3VZ4aj4dAC93MEskArD/7tIOS52Y5bTY=; b=z/+8E/jeHuv04yz0tWQRn82Dkd
        dIaYBDMOw6O3kI2kUeQzv/1yag1Ajt9R2mGeb0yhSvHjnd6lQmDS9LkRYY6kEAcIX9wy8OREkxYdG
        fD6RU4aOdeCYmYXparl1TOIeh5x6Gs7k0NzhYT95QU3YJaG57xDuuKI29no63Tc2TELJ59bQusOsj
        bkuqNRg/SP5op0P9WOOKjOvJe6x1fIqxNh4tEqsV7rqyQIl1SQ3Af8lnsQOowlGkBwzIk8Y4lUdfk
        ZPqI0Vcdr+E3JF1uyjMCIW0fe5gqRxd90IY8IV1nqYNhtv4VF7upZU3FP0qdDRZ8Bvgx7LfJGiCLj
        aFTiMeuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJrwU-0010hX-Eb; Tue, 15 Feb 2022 07:08:06 +0000
Date:   Mon, 14 Feb 2022 23:08:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V2 5/7] block: throttle split bio in case of iops limit
Message-ID: <YgtRVl7oLR4mqf3c@infradead.org>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
 <20220209091429.1929728-6-ming.lei@redhat.com>
 <Ygq6GanKSLlTixqe@slm.duckdns.org>
 <Ygr9evnWSjcCjYkd@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygr9evnWSjcCjYkd@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 09:10:18AM +0800, Ming Lei wrote:
> The big problem is that rq-qos is only hooked for request based queue,
> and we need to support cgroup/throttle for bio base queue.

Which bio based driver do we care about?
