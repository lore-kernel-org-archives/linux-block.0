Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A538CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 14:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiFWOCB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiFWOCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 10:02:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10BD3DA4C
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jaMgZLrXHCQOvkX+f5eMBbEeBitt3OOWO5fNZ3k8vK8=; b=brJBGSBbbivpLfNHJO2+/Es0s4
        IFZkghCtBcjVqjHCzMEXi2VXJ2PAM0xAKu90YrtGMKmb5rgWGK89n2XvhFJeHfAQKEUC/fBz2CE9a
        QG2OGWzIlnir9+k46RHi6+ckVQz4/qcP0cVaLev/JR1qMYz7I1BdpLldfVOBT9xBjpGUwJ+QbuCwN
        ohtEPhAMIloEKY3TBGWByhQOHGdU8VdTvjHqIqIU7ygS2U8gIF3ILWJyLUFep4PF88AVpKiJj6ZbL
        KX1kN+4cSC0yQcLboc+Cj3lwNYd1BAMiAfN4jakKhTEDaoWBp4t3ud9Y3pv5BdZPFdL4Y0T1X/4t9
        oxbXGrDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4NPA-00FSjk-RP; Thu, 23 Jun 2022 14:01:56 +0000
Date:   Thu, 23 Jun 2022 07:01:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 9/9] block: Always initialize bio IO priority on submit
Message-ID: <YrRyVJV3OR/qYHsD@infradead.org>
References: <20220623074450.30550-1-jack@suse.cz>
 <20220623074840.5960-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623074840.5960-9-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 09:48:34AM +0200, Jan Kara wrote:
> Currently, IO priority set in task's IO context is not reflected in the
> bio->bi_ioprio for most IO (only io_uring and direct IO set it). This
> results in odd results where process is submitting some bios with one
> priority and other bios with a different (unset) priority and due to
> differing priorities bios cannot be merged. Make sure bio->bi_ioprio is
> always set on bio submission.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
