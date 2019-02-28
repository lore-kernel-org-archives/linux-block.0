Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F1BC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CC320C01
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367595;
	bh=1z6ttU73UyhDzsz6APPmurcdIWE5PZFUbHdA9IBqAoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gsQdR0esEV9ZTbqzMGzyQhMh08BpAkAcNGzXbV0DoxrjeEu52daS13ZkIKOObw/Cm
	 jpUrncvbE21QgDlzgcZwaZd4CRphN/z0ygebsq3jHpB+McgM9fvsSqVwIaoA6xyUPW
	 1RKtWTYi6+yz8sQJNV+IYWOI3jEt69fuo3bdQUsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfB1P0Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:26:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfB1P0K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 10:26:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C19E2171F;
        Thu, 28 Feb 2019 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551367569;
        bh=1z6ttU73UyhDzsz6APPmurcdIWE5PZFUbHdA9IBqAoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiTHMnJDFAfhIqTrbEjqZsDCVY0bwilJhRv2JD27f5UJIftTHY8hdLRgdNbn1WaAF
         LyjvYCXO73gdAOxmRI8xebHPIt4VQhJEbtj1BOPbwX32D00oGSGrqbkFGDmPzHRZbw
         Db9ANivmq4Uu12S+taoUGkl9fVL+zOKtruU3OhPE=
Date:   Thu, 28 Feb 2019 16:26:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 43/81] blk-mq: protect
 debugfs_create_files() from failures
Message-ID: <20190228152607.GE8481@kroah.com>
References: <20190228150813.10256-1-sashal@kernel.org>
 <20190228150813.10256-43-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228150813.10256-43-sashal@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 28, 2019 at 10:07:35AM -0500, Sasha Levin wrote:
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

As the commit this "fixes" should not be backported, no need for this
patch in any stable kernel either.  Please drop from all queues.

thanks,

greg k-h
