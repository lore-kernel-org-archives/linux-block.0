Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B136C433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 15:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhKYPKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 10:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhKYPIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 10:08:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD88C06175B
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 07:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jIAlKzMQZkwpTN8x4c88BHiMy1DP29F0XFcamdIm0po=; b=frfBl46sQpm5NgrO3/CMRxRyuD
        6u1kLsJNb3vzDJM64R6Yfl15q5/Mh1QFY8DWdhvrjMfewDYRvVXwlcq2n6SysUWqmtnkZaxoXfK6y
        DNgPBxt01XZLy2B6tQUHif4y5rVhkJfknqax80SvyEPHdhc98YimjI68xsH5LkEq2uNctKrTwwocd
        bWVjdRxk3rmwJyamu0hsy0MNeKfDuuDJWDdMub8XMYctBbnynN63A2++CvXKpnm6jlEaXwkw2byjA
        gXfw2UC7sXX4gBqY415Ugqu9ryM7HdSV9zfQVmcd3EFWKaznrXs8hAow1qIXMvyYNzKbZDw8Z50i9
        oyqEJSkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqGJ9-007w7c-2T; Thu, 25 Nov 2021 15:05:07 +0000
Date:   Thu, 25 Nov 2021 07:05:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for Linux 5.16
Message-ID: <YZ+mI9a1Jd2/zNkh@infradead.org>
References: <YZ+X/qGC6/w3bp2c@infradead.org>
 <c55bc6b0-b98e-07f5-b808-83814ad8981a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c55bc6b0-b98e-07f5-b808-83814ad8981a@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 25, 2021 at 07:55:38AM -0700, Jens Axboe wrote:
> On 11/25/21 7:04 AM, Christoph Hellwig wrote:
> >  drivers/nvme/host/core.c          | 29 +++++++++++++++++--
> >  drivers/nvme/host/fabrics.c       |  3 ++
> >  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++--------------------
> >  drivers/nvme/target/io-cmd-file.c |  2 ++
> >  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++--------
> >  5 files changed, 93 insertions(+), 46 deletions(-)
> 
> This doesn't match what I get:
> 
>  drivers/nvme/host/core.c          | 29 +++++++++++++++++++---
>  drivers/nvme/host/fabrics.c       |  3 +++
>  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++++++-----------------------
>  drivers/nvme/target/io-cmd-file.c |  4 ++-
>  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++++++---------
>  5 files changed, 94 insertions(+), 47 deletions(-)
> 
> Hmm?

Looks like the diffstt doesn't include the the requested reformatting
in io-cmd-file.c.  But I have no idea why.
