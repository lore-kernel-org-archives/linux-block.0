Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E82C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 11:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5208B60EB2
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 11:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhHKLqe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbhHKLqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 07:46:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95B2C061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RDUf5yG/NXG5w620XtxrB+I5QSjMPfnNF1EktmZTTFw=; b=TaggWTOrLSCRtlmtnFXjzqmfl5
        HHRr6xAqs+WpQ9qykgehMYt8hLE457Rhi2IviX84yvnNaQNZHt9gUUbwpEFbbt2mbhb98XF+1WvKO
        SxA0gTLCtYFw8sCMZiWy5cThueLlTFezFXQNGRe/E8EFtxzYBZXJfn+SazVxO8BR6baOD6T3z0fAk
        1jbJMxdm7FwrNCkdtYjzSctpnxdu2z7O/z9aeWH8CEYFlAxbCW3Sfls1KXipG3an2mcbolESuR3Iq
        QQ7T/VU3NbzVX4G8JGOjP8n6sIKbtePfhg06EZayaVpNVsU75XzoZXvKAQJXRehDPpptW/NBFVMG5
        G0aBt+xg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDmfS-00DKZE-7K; Wed, 11 Aug 2021 11:45:25 +0000
Date:   Wed, 11 Aug 2021 12:45:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     CKI Project <cki-project@redhat.com>
Cc:     skt-results-master@redhat.com, linux-block@vger.kernel.org,
        axboe@kernel.dk, Memory Management <mm-qe@redhat.com>,
        Jan Stancek <jstancek@redhat.com>, Li Wang <liwang@redhat.com>,
        Zorro Lang <zlang@redhat.com>, Xiong Zhou <xzhou@redhat.com>,
        Yi Zhang <yizhan@redhat.com>
Subject: Re: ???? PANICKED: Test report for kernel 5.14.0-rc5 (block,
 4e9e1af5)
Message-ID: <YRO4QsuvB5jgNddW@infradead.org>
References: <cki.D0FC7AC895.R5GM6IYQCK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cki.D0FC7AC895.R5GM6IYQCK@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm really not sure what this mail is trying to say. If you have a
PANICKED subject please at least include the actual kernel message
leading to it in the mail, as well as other useful information.  Take
a look at the build-bot mails for useful examples.
