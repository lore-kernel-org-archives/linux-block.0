Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB966C433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Apr 2022 05:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiDPGBV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Apr 2022 02:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPGBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Apr 2022 02:01:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65FA6213C
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 22:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gU0yYpKruvAcYODaycpgnNMrkQfFOoDNcDnBic7CSRQ=; b=l9oYKltFADqlqKwobKYqiDmGMf
        g+KhQc5Yebii4Djqsgkm5cTMbV+FLJjvd/wBMcGIxNuRUFckp1w7aDfn6bUdt7ZJcALPUWAOLL4zg
        kzBZdUC9tNN6hB99rBvGaZQAB/TQ5DVkD2yagRaunN1CzOQBT8smsVSUUJGmK8eV2pKwd8U2O10jw
        noItra32AkIi2UcOoS3UUGGDmZaNW5BfmJYHIIu5/7Hqp8GUxPQAnVbrhfVYdNEajLLlqKMc1osB4
        tWSPHQR1NLk4WkgmScnVRqnb99JKyoBl4jLw7B8eXCANclYGKzNoAg0F6R0k+ZvVusSsWqiWxXCBC
        kTQqRYUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfbSL-00CJdS-UQ; Sat, 16 Apr 2022 05:58:49 +0000
Date:   Fri, 15 Apr 2022 22:58:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/8] dm: io accounting & polling improvement
Message-ID: <YlpbGbtc5NwD64KH@infradead.org>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <YlWzoj+M1ykUubH+@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlWzoj+M1ykUubH+@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12, 2022 at 01:15:14PM -0400, Mike Snitzer wrote:
> I'll review this closely but, a couple weeks ago, I queued up quite a
> lot of conflicting changes for 5.19 here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19

Can you please end them out to the device mapper list for review?
