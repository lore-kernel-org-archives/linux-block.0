Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085F3C43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 09:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B960921D1B
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600163092;
	bh=RbizKIqrqO/ALU1xFvlAwmrRVGMO098Fa7HI04zSuug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RS2Z3IQWFJiFW8gvtS26Qm5ZBToLuyrYKDCfjPGsvMqTIBZmlktcM77qryjK18Ufh
	 ZQWH8qSiIN5FKYY9dkYNG/xaCCEwtRU/4pnqBXlXL7Lb+EgwR3bqst5fWO80/ygKsu
	 JsSEhZiLolZjWw8wJAvNDPTKkDhTsvcSu+ip+Xjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIOJoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 05:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbgIOJoq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 05:44:46 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB86B2080C;
        Tue, 15 Sep 2020 09:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600163084;
        bh=RbizKIqrqO/ALU1xFvlAwmrRVGMO098Fa7HI04zSuug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TX502w4Lb3TBtT1biEarYXDs0RMgK5Jwd+WRXfhY3G9vRen8GIGD+aVy4BjsJoaQc
         SJS07r9bjKKWfIYsPnQqCZewD7OaIh31CiI98dqNpkM50CxVRE2rapna7Fw7rIwycM
         RMP24jX60/bY130cRTLOGKecvQYoYJTzCiUQsiec=
Date:   Tue, 15 Sep 2020 11:44:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] io_uring: Fix async workqueue is not canceled on
 some corner case
Message-ID: <20200915094441.GA264332@kroah.com>
References: <20200915081551.12140-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915081551.12140-1-songmuchun@bytedance.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15, 2020 at 04:15:48PM +0800, Muchun Song wrote:
> We should make sure that async workqueue is canceled on exit, but on
> some corner case, we found that the async workqueue is not canceled
> on exit in the linux-5.4. So we started an in-depth investigation.
> Fortunately, we finally found the problem. The commit:
> 
>   1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
> 
> did not completely solve this problem. This patch series to solve this
> problem completely. And there's no upstream variant of this commit, so
> this patch series is just fix the linux-5.4.y stable branch.
> 
> Muchun Song (2):
>   io_uring: Fix missing smp_mb() in io_cancel_async_work()
>   io_uring: Fix remove irrelevant req from the task_list
> 
> Yinyin Zhu (1):
>   io_uring: Fix resource leaking when kill the process
> 
>  fs/io_uring.c | 45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> -- 
> 2.11.0
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
