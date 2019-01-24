Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00848C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 15:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C804521872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 15:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfAXPJ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:09:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbfAXPJ2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 10:09:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C28AC0495AE;
        Thu, 24 Jan 2019 15:09:28 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 849B568D48;
        Thu, 24 Jan 2019 15:09:27 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix the cmd_flag_name array
References: <1548325735-1760-1-git-send-email-jianchao.w.wang@oracle.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 24 Jan 2019 10:09:26 -0500
In-Reply-To: <1548325735-1760-1-git-send-email-jianchao.w.wang@oracle.com>
        (Jianchao Wang's message of "Thu, 24 Jan 2019 18:28:55 +0800")
Message-ID: <x49h8dygkih.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 24 Jan 2019 15:09:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jianchao Wang <jianchao.w.wang@oracle.com> writes:

> Swap REQ_NOWAIT and REQ_NOUNMAP and add REQ_HIPRI.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq-debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 90d6876..f812083 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -308,8 +308,9 @@ static const char *const cmd_flag_name[] = {
>  	CMD_FLAG_NAME(PREFLUSH),
>  	CMD_FLAG_NAME(RAHEAD),
>  	CMD_FLAG_NAME(BACKGROUND),
> -	CMD_FLAG_NAME(NOUNMAP),
>  	CMD_FLAG_NAME(NOWAIT),
> +	CMD_FLAG_NAME(NOUNMAP),
> +	CMD_FLAG_NAME(HIPRI),
>  };
>  #undef CMD_FLAG_NAME

Acked-by: Jeff Moyer <jmoyer@redhat.com>

You might consider also adding a comment above the req_flag_bits enum
noting that modifications also need to be propagated to cmd_flag_name.
