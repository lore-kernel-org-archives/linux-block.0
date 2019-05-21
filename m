Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A89C04AB4
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077C0217D4
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t27nPxWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfEUM4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 08:56:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUM4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 08:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FWJgqycH+Z2b7iPrfuL3t5rHQ361i1X/w+1sDUjJE10=; b=t27nPxWP4xWZ2ufZwL0Ccc7P4
        brykEqYBGst6SZmss0/JlPyWBLVvE1pDfd5/aK4w6zgSL3lniwLTMl8Q7FAgKGGnyZwRnJ/b2+qId
        +xc0rkaougndR9X+nn9NOJOvH/jILN88VuPVf8+N22LUFffuDC9RIWs15A56JS/UsL/rqyydyQbUC
        /g1tPKNG6GTm0SqM7KgrbJ8wHabC2kHA7+YAY6Za+tVQceP5fGNC4GgQehq9/ASpLP+S54Mmxwte1
        e3DXsVuUFEYFzEDA40ydRr4e6Q3t6W0ElcT21VSC3RIxw/XRn3zbtsMozZzWYE4atpIXzmTaRBeI7
        L9fPlxDhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hT4Jm-0002Pl-Fi; Tue, 21 May 2019 12:56:34 +0000
Date:   Tue, 21 May 2019 05:56:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, axboe@kernel.dk, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        Ming Lei <ming.lei@redhat.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org
Subject: Re: [PATCH V2 2/2] md/raid0: Do not bypass blocking queue entered
 for raid0 bios
Message-ID: <20190521125634.GB16799@infradead.org>
References: <20190520220911.25192-1-gpiccoli@canonical.com>
 <20190520220911.25192-2-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520220911.25192-2-gpiccoli@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 20, 2019 at 07:09:11PM -0300, Guilherme G. Piccoli wrote:
> No changes from V1, only rebased to v5.2-rc1.
> Also, notice that if [1] gets merged before this patch, the
> BIO_QUEUE_ENTERED flag will change to BIO_SPLITTED, so the (easy) conflict
> will need to be worked.
> 
> [1] https://lore.kernel.org/linux-block/20190515030310.20393-4-ming.lei@redhat.com/

Actually - that series should also fix you problem and avoid the need
for both patches in this series.  Can you please test it?
