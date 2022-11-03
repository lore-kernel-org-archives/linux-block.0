Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0610C433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 07:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKCHts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 03:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCHtr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 03:49:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A0633F;
        Thu,  3 Nov 2022 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pZ2ykf+ZWvXHPxLN8XkQPjK779MH/q2xfMK9Fc41Z7o=; b=WJR3+pl3wPMFj+uYLUC+AUU9cp
        I5Ehw7vKak4fmtb628r62ic4cceOmsMi8B0X0aGonesUiHyBzYqufib+m7d92hTc07UKpCnrmKRYV
        sxIhUEktkMHuvXEs60fVAl5Fv4IQn8YcmEGiJXg3ekrFe+DZJH02W0bdQjVgYhtrX5aS92hBRmO5r
        rtr71xlDOtoLVWtSM+EO0bWOUXEh8ixSNhgYWJ+lhGwyYktk14to9G327zqNsW7IakfGDZuIfmUNX
        Uk8ZtW5DyLtcNholQL7UROf1NBcs9SC5Bz6JL3gZwGJewl80vRdeZUnOWtHpOObR4RUoR6D7+hiDt
        zVuF98Vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqUyr-00GVS3-PN; Thu, 03 Nov 2022 07:49:41 +0000
Date:   Thu, 3 Nov 2022 00:49:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read
 operations
Message-ID: <Y2NylejsWVvOeZuL@infradead.org>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
 <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
 <Y2E2wFnbeUzAPjo0@infradead.org>
 <3af6895b-b776-cf0d-fe1e-866ce5e6b0b0@opensource.wdc.com>
 <Y2IXjzWL5eHA3Co9@infradead.org>
 <8125e422-7bc8-46a1-792a-f31cee7a91a3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8125e422-7bc8-46a1-792a-f31cee7a91a3@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 02, 2022 at 09:17:54AM -0600, Jens Axboe wrote:
> 
> This looks fine, but if we're never expecting this to happen, I do think
> it should just go into libata instead as that's the only user that
> cares about it. Yes, that'll lose the backtrace for who submitted it
> potentially, but you can debug it pretty easily at that point if you
> run into it.

FUA and PREFLUSH are bits only defined for writes.  libata might be the
first thing blowing up, but it really is a block layer constraint.
So validity checking what is being sent to the block layer at the
highest possible lyer is a good thing to ensure we don't get us in
trouble by someone accidentally sending one down or even expecting it
to work.  Especially as at least SCSI actually defines semantics for FUA
on reads, but they are completely bogus and useless.
