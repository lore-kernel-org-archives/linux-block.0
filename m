Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47732C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 04:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAA32231B
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574136014;
	bh=XOQs9ta5TxZwJ5dIi/FfReFIvk/BCYdbBHqI+NdCsy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t13zqBFtKEJPh/2eb/y768XoVPHc1OkfbYRH6n7Eo0hvPV94Qgcu0yTZBGJ4c7tBy
	 AokwRndL5b/gUm+3XmhqMtEcAtlQWmzDWZroMoRDVZEh+RAkiptrrDkJ4t+5Fv2n7f
	 6ALyppUvCjbNwLPHNS6E3kvWUH9srWdWQkENS1Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKSEAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfKSEAJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 23:00:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5597C222DD;
        Tue, 19 Nov 2019 04:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574136007;
        bh=XOQs9ta5TxZwJ5dIi/FfReFIvk/BCYdbBHqI+NdCsy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w1iC/DrKlMF9uRE+pAYttXB9ALq77DUfKp9NxLKMxVE8TbzPELoZLZgvR6SZBfIb3
         +0BdEotMfOGZB0X7rCpZdR9/JNNr+ojIhYWKA+r7+77fo0rJ6klHhWNzaLUXx7uxru
         Ne7TL2w0vxd99mxvaR9xG3NPTCH3ftiLdszasurY=
Date:   Tue, 19 Nov 2019 05:00:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Norrie <andrew.norrie@cgg.com>
Cc:     jaegeuk@kernel.org, axboe@kernel.dk, bvanassche@acm.org,
        linux-block@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: loop: avoid EAGAIN, if offset or block_size are changed
Message-ID: <20191119040004.GA1445767@kroah.com>
References: <20190617210848.GB57907@jaegeuk-macbookpro.roam.corp.google.com>
 <1574102176-23804-1-git-send-email-andrew.norrie@cgg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574102176-23804-1-git-send-email-andrew.norrie@cgg.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 18, 2019 at 11:36:16AM -0700, Andrew Norrie wrote:
> This email and any accompanying attachments are confidential. If you received this email by mistake, please delete
> it from your system. Any review, disclosure, copying, distribution, or use of the email by others is strictly prohibited.

Now deleted.  This is not compatible with Linux mailing lists, sorry.
