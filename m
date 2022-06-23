Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 14:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiFWOBe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiFWOBe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 10:01:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E393D1FC
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OjKnbmXOWjgqaEhv+2cwNJ8yf5+2olps/qsz5I9y7y0=; b=A+cSVUyXz7ArbgKo/jU4nmJ55X
        ekqDK+vRoQ6Fe6uY0LxO1xPGyGqr8fxFXYhPsivDnYKiPOF0TperRndqA3l8tKh/4WsptaixKxl/C
        E5tF8oqtsy8OGJVt5bCsqhC0vBqbQc9j8xiM/RVRYXD64GKVMb765cuAgF8DmY4005zWTsDL85BYf
        krT2jbB+gxKj8flrtjDvt35XoK4lRKitQWv2pcaV0/9eOHB06Y0SV7wGpo/L/GYJiBa+ScBIWdpWN
        QopCv7jdYfJ15kc4QW7g7YABk4pB5q4qdcSpoiTRMTaT8EiGzyPGt8n+wzOik3UyD4fdXxd/1n+0W
        WjQskjEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4NOm-00FSbv-GQ; Thu, 23 Jun 2022 14:01:32 +0000
Date:   Thu, 23 Jun 2022 07:01:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 8/9] block: Initialize bio priority earlier
Message-ID: <YrRyPJp7rLECm1S5@infradead.org>
References: <20220623074450.30550-1-jack@suse.cz>
 <20220623074840.5960-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623074840.5960-8-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 09:48:33AM +0200, Jan Kara wrote:
> Bio's IO priority needs to be initialized before we try to merge the bio
> with other bios. Otherwise we could merge bios which would otherwise
> receive different IO priorities leading to possible QoS issues.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
