Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE551C4360F
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 18:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9A721841
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 18:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E4Zgc0H9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfCTSx4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:53:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfCTSx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 14:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=19J+W7mnzMxofEiVeKGPeMBVF0b3b1HaVTXfNyGBA6g=; b=E4Zgc0H9T3r8B3MviIDF03WoP
        /HtoUhhrOcbhOuSMgLsAiKywl8ntQbDZot9vppf3j1ZhHpVBs8dBIQ+oWlbfzGvq5ObJh4Zm9ITRK
        vBPhCnuJwODhSL3923phSEgySz2SifsDpBDvrPjW7w+MfMhUJaeEZRRYe8BlvgkZSoP2j+rNaios8
        3nZY5KR49A3NzOIBdLirAG6u0jdT3wQ7vhHSsb0x3QE2zJrLQ4MHfWLLdwqszN8zzsZKoufs611n+
        KwwrABaK4gxbwmNaB1W67rg3wMhahYvPxzOj4YmP7rhOMbilxpFfL5OSCcgC31pQSYkueD/rH6MIa
        meexl8+1A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6gLT-0000z4-IC; Wed, 20 Mar 2019 18:53:47 +0000
Date:   Wed, 20 Mar 2019 11:53:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [RFC 0/2] guarantee natural alignment for kmalloc()
Message-ID: <20190320185347.GZ19508@bombadil.infradead.org>
References: <20190319211108.15495-1-vbabka@suse.cz>
 <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
 <5d7fee9c-1a80-6ac9-ac1d-b1ce05ed27a8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d7fee9c-1a80-6ac9-ac1d-b1ce05ed27a8@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 20, 2019 at 09:48:47AM +0100, Vlastimil Babka wrote:
> Natural alignment to size is rather well defined, no? Would anyone ever
> assume a larger one, for what reason?
> It's now where some make assumptions (even unknowingly) for natural
> There are two 'odd' sizes 96 and 192, which will keep cacheline size
> alignment, would anyone really expect more than 64 bytes?

Presumably 96 will keep being aligned to 32 bytes, as aligning 96 to 64
just results in 128-byte allocations.
