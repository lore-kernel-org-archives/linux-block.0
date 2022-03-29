Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71DAC433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 06:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiC2G5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 02:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiC2G5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 02:57:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379D2DD46;
        Mon, 28 Mar 2022 23:55:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F365868AFE; Tue, 29 Mar 2022 08:55:35 +0200 (CEST)
Date:   Tue, 29 Mar 2022 08:55:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: restore the old set_task_ioprio() behaviour wrt
 PF_EXITING
Message-ID: <20220329065535.GA20158@lst.de>
References: <20220328085928.7899-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328085928.7899-1-jslaby@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  		task_lock(task);
>  		if (task->flags & PF_EXITING) {
> -			err = -ESRCH;
>  			kmem_cache_free(iocontext_cachep, ioc);
>  			goto out;

Please add a commnt here why we are not returning an error, otherwise
this is just getting "fixed" over and over again.
