Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD4C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 07:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4F0218AC
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 07:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548918060;
	bh=GfoEyZ4E5ex/cQ0+BHut2xqU/ncfufpcq1DaClRefcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NGsUNvNWPJy0RrwxTTOEh7HDxoavnlm4si4E6mBlDU9YWOojD11mad5FChoAr86Al
	 /MGdC332OmDjYNZMGJnxH2iRZsRPUiVJVONb9nGYzx+mgsxdrZD4H8CjYS2dXa1FSA
	 6F2EZlwePwSZa39Kndy05KQDJtBaJ14BANds9izQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfAaHA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfAaHA7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 02:00:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A076620870;
        Thu, 31 Jan 2019 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548918059;
        bh=GfoEyZ4E5ex/cQ0+BHut2xqU/ncfufpcq1DaClRefcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=os1QNGniLrHWSt+WmIm5AWzo9Zzh3YKQfV5gxwrMVwES4/nRPgGeaQQaoM7eZn92G
         x/7odgoP12DqjOBuKZvJaVmD1mivZ12fr5EBvuaxIRup3klaSU/rBHiBL4N8PVhCox
         SXDnzIZkJeN/NQ+lyx0OGxmqldlXhdpzVh4jn8H8=
Date:   Thu, 31 Jan 2019 08:00:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+a9d09761be47db706560@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in debugfs_create_files
Message-ID: <20190131070056.GA2158@kroah.com>
References: <000000000000784c000580b16bdd@google.com>
 <1956aaad-701d-2c5f-180c-0eaeb01daf21@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1956aaad-701d-2c5f-180c-0eaeb01daf21@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 02:34:56PM +0900, Tetsuo Handa wrote:
> Hello, again.
> 
> syzbot is hitting a similar crash due to debugfs_create_dir() returning -EEXIST.
> Should debugfs_create_dir() return NULL as well? Or should the caller use IS_ERR_OR_NULL() ?
> 
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -861,6 +861,8 @@ int blk_mq_debugfs_register(struct request_queue *q)
>                                             blk_debugfs_root);
>         if (!q->debugfs_dir)
>                 return -ENOMEM;
> +       if (IS_ERR(q->debugfs_dir))
> +               printk("debugfs_create_dir=%ld\n", PTR_ERR(q->debugfs_dir));
> 
>         if (!debugfs_create_files(q->debugfs_dir, q,
>                                   blk_mq_debugfs_queue_attrs))
> 

I already posted this patch last Wednesday:
	https://lore.kernel.org/lkml/20190123134854.GA25906@kroah.com/
to solve this problem.

I guess I should queue it up in my tree as well, to handle this issue.
I'll go do that now.

thanks,

greg k-h
