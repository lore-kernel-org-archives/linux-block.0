Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E87BC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E36420823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VjzH+7yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E36420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeKSSfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:35:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeKSSfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cgu4/+amYQH4rpR7l0zirML3dqNakw9beC1ZY1jL4T8=; b=VjzH+7yxdEa+RA+PkmWzDwRaF
        Sufem2ArKHX5yUrWP9kpeGBMyktZzfInrWn7s0PfouBpiWGJ/zcgry9mUkfVyq+FjcgcsvEntY2zu
        15vbZ3UDtxN1iplpHp8zlUlw216SP1syafFNlqLCibRXY1XxL7UnnpdkX+AER/dDKuTI+XcXHEB7f
        FE1F6Bk9TUqaRdU07wROeLaNppyAOdCY4kGj3QXjNz9b1+K1R6TfVUE8X6sfE6yYsH0BAj34e0eA/
        zzX62HBwovNsTZJvTyVtG++oCNNJ4d3DFnDKBjKqDDuufwP2BamtWyWIjoKH8NrDvxbWDhl7X8UL3
        PD4ghEDxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOefA-0000PA-25; Mon, 19 Nov 2018 08:12:08 +0000
Date:   Mon, 19 Nov 2018 00:12:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] aio: add support for file based polled IO
Message-ID: <20181119081207.GK9622@infradead.org>
References: <20181117235317.7366-1-axboe@kernel.dk>
 <20181117235317.7366-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117235317.7366-6-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 17, 2018 at 04:53:17PM -0700, Jens Axboe wrote:
> Needs further work, but this should work fine on normal setups
> with a file system on a pollable block device.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/aio.c       | 2 ++
>  fs/direct-io.c | 4 +++-
>  fs/iomap.c     | 7 +++++--
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 500da3ffc376..e02085fe10d7 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1310,6 +1310,8 @@ static struct block_device *aio_bdev_host(struct kiocb *req)
>  
>  	if (S_ISBLK(inode->i_mode))
>  		return I_BDEV(inode);
> +	else if (inode->i_sb && inode->i_sb->s_bdev)
> +		return inode->i_sb->s_bdev;

This is broken for multi-device filesystems, e.g. XFS with the RT
device, or btrfs.  See my patch in reply to your last one for an idea
how to solve this.
