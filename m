Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AB2C433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 13:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiC2Nen (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiC2Nen (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 09:34:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774EC2BB15;
        Tue, 29 Mar 2022 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KDGR7H/Te+ml+DuvgOjbyqZM3qdwD5k+W+1vZVIRNlU=; b=gwenPt5C4ZIYSOhDF7skHJvtO6
        PIzvR1SDQhP1Pc8wuX7xsdT5AshSXzpYVzlRfyozWM4+niz55O7MQ5M3sdvqj14CBMxRlsK7jQz3r
        4yn9v0lJFMb8fkQY90qYY36CFHpB0dauwuTg3PHAtG0jfyq42/b6ZaGbOkYcL2nudaPk88OZcoMj4
        gfojLKoLVQIQ1ez2hoS8hVd/zO6+WAtS/vz0aC3ERt+mwU4had1/J507HCwpUptboiVE0Lg1AvDbw
        cZOjv8Sc16VSlXnPPCEtVCayFjhffQB0njOt7LjDdzHey//tpU2fM5Afn7WiHdcwIXfk2DgtiyuNp
        YPRbd41Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZBxs-00CN9t-0M; Tue, 29 Mar 2022 13:32:52 +0000
Date:   Tue, 29 Mar 2022 06:32:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next RFC 2/6] block: refactor to split bio thoroughly
Message-ID: <YkMKgwsZ3K8dRVbX@infradead.org>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329094048.2107094-3-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 29, 2022 at 05:40:44PM +0800, Yu Kuai wrote:
> Currently, the splited bio is handled first, and then continue to split
> the original bio. This patch tries to split the original bio thoroughly,
> so that it can be known in advance how many tags will be needed.

How do you avoid the deadlock risk with all the split bios being
submitted together?

But more importantly why does your use case even have splits that get
submitted together?  Is this a case of Linus' stupidly low default
max_sectors when the hardware supports more, or is the hardware limited
to a low number of sectors per request?  Or do we hit another reason
for the split?

