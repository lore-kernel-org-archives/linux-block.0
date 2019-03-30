Return-Path: <SRS0=7fUu=SB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4D1C4360F
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 05:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5605E218AE
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 05:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553924596;
	bh=ebyU1xh/LAWXwMIwVYqVq1jdrJRLGm7c+F3dlI/CX8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UNy2kCKmhQLnU4RfuX2zgs2Y/8TN6wKRTc3SUMPV5lxmMLstAIkk5bP8fJfkQLQg0
	 5yf+7aHScgY6V9073kf2o6tGncIudjJxoNVi5i0ORZ3w7riq/9aOdq/BH5HKA/hAJM
	 bxXOQ2lWppq/IycqQJpwPtGY0uqXBYDofAONwPVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfC3FnP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfC3FnP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Mar 2019 01:43:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECAA2218AC;
        Sat, 30 Mar 2019 05:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553924594;
        bh=ebyU1xh/LAWXwMIwVYqVq1jdrJRLGm7c+F3dlI/CX8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7WYJONPEV/GhFY9G4mAt2pCMc9p24gDGy9uEJVLWFMiUp34PcVRPSo3bmqsmjncr
         gM2VcnDhO6ucND9ZhoiQ15p1cf/2p2JLJ5QxGB/4fKmQqK/R+Dq72G19wbq4wzQ/Dm
         FqylzNDd5aA/fNLEOLz/qVgHd+8+lTLto4/pHSN8=
Date:   Sat, 30 Mar 2019 06:43:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 33/57] blk-mq: protect
 debugfs_create_files() from failures
Message-ID: <20190330054311.GA23655@kroah.com>
References: <20190330012854.32212-1-sashal@kernel.org>
 <20190330012854.32212-33-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330012854.32212-33-sashal@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 29, 2019 at 09:28:26PM -0400, Sasha Levin wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [ Upstream commit 36991ca68db9dd43bac7f3519f080ee3939263ef ]
> 
> If debugfs were to return a non-NULL error for a debugfs call, using
> that pointer later in debugfs_create_files() would crash.
> 
> Fix that by properly checking the pointer before referencing it.
> 
> Reported-by: Michal Hocko <mhocko@kernel.org>
> Reported-and-tested-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  block/blk-mq-debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index cb1e6cf7ac48..9dc3a0896462 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -806,6 +806,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
>  static bool debugfs_create_files(struct dentry *parent, void *data,
>  				 const struct blk_mq_debugfs_attr *attr)
>  {
> +	if (IS_ERR_OR_NULL(parent))
> +		return false;
> +
>  	d_inode(parent)->i_private = data;
>  
>  	for (; attr->name; attr++) {
> -- 
> 2.19.1
> 

This was a 5.0-only thing, no need for it to be backported anywhere.
Please drop it from all of your trees.

thanks,

greg k-h
