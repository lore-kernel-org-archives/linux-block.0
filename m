Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFC4C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71A020882
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HLgPOQcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeL0Nza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:55:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbeL0Nz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 08:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8GMxPliigNoZPGSlUZlbR1ZCzs2axxqFRNls3cVk/jI=; b=HLgPOQcVO7Ji1WY4NYWuG3hl2
        RjabcuTVVyhGV03FvbmUzPjYS9AWyamAkKL/dOTe6SELfX7zwZcB9CgyOTCrkMX9GKsKs5vhytVIH
        rqcRH1CMhukdTPTF3FsUHakGj3KU9L//3p9C8u8oCR/eGGqujXGD/jxIHaj8sX4Ir0qnmoQosDkRl
        K/P4NrpH0yV1jusMCBSn1oh6qUgatmyy8/7guNPlrrIIy+2JnG6D8eh8XlNbxU9uPdw6mlmQTkDEQ
        gCUmGNzYugwwHCGD84eiSMqQBzU5Xqp3EWSF9Mr/Dnoys1x8O3ur19U8MQADj7nIwguQS+Bv3kldL
        uXT4rOmDA==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcW8D-0006E0-AI; Thu, 27 Dec 2018 13:55:28 +0000
Date:   Thu, 27 Dec 2018 14:55:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 07/22] aio: add io_setup2() system call
Message-ID: <20181227135509.GA25525@infradead.org>
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221192236.12866-8-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 21, 2018 at 12:22:21PM -0700, Jens Axboe wrote:
> This is just like io_setup(), except add a flags argument to let the
> caller control/define some of the io_context behavior.
> 
> Outside of the flags, we add two user pointers for future use.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Hmm, I don't think think I was fine with the current version..

> +/* sys_io_setup2:
> + *	Like sys_io_setup(), except that it takes a set of flags
> + *	(IOCTX_FLAG_*), and some pointers to user structures:
> + *
> + *	*user1 - reserved for future use
> + *
> + *	*user2 - reserved for future use.
> + */
> +SYSCALL_DEFINE5(io_setup2, u32, nr_events, u32, flags, void __user *, user1,
> +		void __user *, user2, aio_context_t __user *, ctxp)

Most importantly I'm really worried about these new user1 and user2
fields, which aren't really used for aio poll.  They are used for
the I/O ring, which while I think is a really great concept, I am also
worried about overlaying into the aio interface just creating confusion..
