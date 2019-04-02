Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C51C43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 03:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D672087C
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 03:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfDBDiy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:38:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfDBDiy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 23:38:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25DDF30842A8;
        Tue,  2 Apr 2019 03:38:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B22E1001DDC;
        Tue,  2 Apr 2019 03:38:48 +0000 (UTC)
Date:   Tue, 2 Apr 2019 11:38:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH V2 0/2] blk-mq/nvme: cancel request synchronously
Message-ID: <20190402033842.GA26224@ming.t460p>
References: <20190327085114.12111-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327085114.12111-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 02 Apr 2019 03:38:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 04:51:12PM +0800, Ming Lei wrote:
> Hi,
> 
> This patchset introduces blk_mq_complete_request_sync() for canceling
> request synchronously in error handler context, then one race between
> completing request remotely and destroying contoller/queues can be fixed.
> 
> V2:
> 	- export via EXPORT_SYMBOL_GPL
> 	- minor commit log change
> 
> 
> Ming Lei (2):
>   blk-mq: introduce blk_mq_complete_request_sync()
>   nvme: cancel request synchronously
> 
>  block/blk-mq.c           | 20 ++++++++++++++++----
>  drivers/nvme/host/core.c |  2 +-
>  include/linux/blk-mq.h   |  1 +
>  3 files changed, 18 insertions(+), 5 deletions(-)

Hi Jens,

Gentle ping on this fix...

Thanks,
Ming
