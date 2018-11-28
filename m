Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A1BC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1899020645
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1899020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeK1MGD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:06:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbeK1MGD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 07:06:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEDD9307D855;
        Wed, 28 Nov 2018 01:06:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABC3C5DEFC;
        Wed, 28 Nov 2018 01:06:13 +0000 (UTC)
Date:   Wed, 28 Nov 2018 09:06:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: Report EOPNOTSUPP properly
Message-ID: <20181128010606.GA11128@ming.t460p>
References: <20181030230624.61834-1-evgreen@chromium.org>
 <20181030230624.61834-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030230624.61834-2-evgreen@chromium.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 28 Nov 2018 01:06:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 30, 2018 at 04:06:23PM -0700, Evan Green wrote:
> Properly plumb out EOPNOTSUPP from loop driver operations, which may
> get returned when for instance a discard operation is attempted but not
> supported by the underlying block device. Before this change, everything
> was reported in the log as an I/O error, which is scary and not
> helpful in debugging.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
>  drivers/block/loop.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index abad6d15f9563..28990fc94841a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -458,8 +458,13 @@ static void lo_complete_rq(struct request *rq)
>  
>  	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
>  	    req_op(rq) != REQ_OP_READ) {
> -		if (cmd->ret < 0)
> -			ret = BLK_STS_IOERR;
> +		if (cmd->ret < 0) {
> +			if (cmd->ret == -EOPNOTSUPP)
> +				ret = BLK_STS_NOTSUPP;
> +			else
> +				ret = BLK_STS_IOERR;
> +		}
> +
>  		goto end_io;
>  	}
>  
> @@ -1788,7 +1793,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>   failed:
>  	/* complete non-aio request */
>  	if (!cmd->use_aio || ret) {
> -		cmd->ret = ret ? -EIO : 0;
> +		if (ret == -EOPNOTSUPP)
> +			cmd->ret = ret;
> +		else
> +			cmd->ret = ret ? -EIO : 0;
>  		blk_mq_complete_request(rq);
>  	}
>  }
> -- 
> 2.16.4
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
