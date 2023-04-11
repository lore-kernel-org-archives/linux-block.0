Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D552C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 12:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjDKMb0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 08:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKMbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 08:31:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD511FE2
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=V9pYK3QPOFXAyPcDimfyqm/Cr1
        PzuTlqboDHg4Ez1xY/T23P3vXNKIBMg3zjTNY5zz2JF5tS8CBW2TYJX9/LZPDwSQYRS5hMIZa3MMA
        1HQCLO44uZbhuWn3TDMobC3PXlgZLyaMTqtz51nUNxZO6dy9qFotfr3s9Mxgf8oiZ89DjolZTdjLc
        ipMum86LEGx12t1m8ser8Irl/SGVJYEHv61Uinb2WghLHqvrQ0d2rof0JP7iahL6GQ4nl5RIkrfVI
        qFbXoIiR6Isp1TD9t6JLZXR8HX4XDBLB+PDFGSTBiQvvMHHKLisrJkeTXEA7wyru5zBIrI9DDoAc2
        qZvBwBjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmD9f-00HYR8-2G;
        Tue, 11 Apr 2023 12:31:23 +0000
Date:   Tue, 11 Apr 2023 05:31:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, brauner@kernel.org,
        jonathan.derrick@linux.dev
Subject: Re: [PATCH v2 1/1] sed-opal: geometry feature reporting command
Message-ID: <ZDVTG361r+EkYjIf@infradead.org>
References: <20230406131934.340155-1-okozina@redhat.com>
 <20230411090931.9193-1-okozina@redhat.com>
 <20230411090931.9193-2-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411090931.9193-2-okozina@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
