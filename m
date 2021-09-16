Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7BC433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB286120C
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhIPIBo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234904AbhIPIBn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 04:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631779223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltWApKc0XWyxwWW4FSF9b1OI2qV7gCHnVIU8GT27nWA=;
        b=DKNjX23Pa9YRMYLKuwx0/VWcOWIiezGJfPq2z60p9fwDYA0Kl5WdxcjgsElmiQu4ft4+NS
        ksApzoHG7s7cSxV2ZoluGA1d2LSoXxc76+2zuRoywUhP8eIJ+vfARfpltqabdv5P09DcMg
        TrhiS4ii9l3/KOxRo4LISYVsnlLdP70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-HV3MMAAFMo6Z0FlUJAt_MQ-1; Thu, 16 Sep 2021 04:00:20 -0400
X-MC-Unique: HV3MMAAFMo6Z0FlUJAt_MQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB1FE9126D;
        Thu, 16 Sep 2021 08:00:18 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13C90100164C;
        Thu, 16 Sep 2021 08:00:10 +0000 (UTC)
Date:   Thu, 16 Sep 2021 16:00:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v7 5/6] nbd: partition nbd_read_stat() into
 nbd_read_reply() and nbd_handle_reply()
Message-ID: <YUL5lm2h+f9lG8LD@T590>
References: <20210915092010.2087371-1-yukuai3@huawei.com>
 <20210915092010.2087371-6-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915092010.2087371-6-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 05:20:09PM +0800, Yu Kuai wrote:
> Prepare to fix uaf in nbd_read_stat(), no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 76 +++++++++++++++++++++++++++------------------
>  1 file changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 22c91d8901f6..9a7bbf8ebe74 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -694,38 +694,45 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
>  	return 0;
>  }
>  
> -/* NULL returned = something went wrong, inform userspace */
> -static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
> +static int nbd_read_reply(struct nbd_device *nbd, int index,
> +			  struct nbd_reply *reply)
>  {
> -	struct nbd_config *config = nbd->config;
> -	int result;
> -	struct nbd_reply reply;
> -	struct nbd_cmd *cmd;
> -	struct request *req = NULL;
> -	u64 handle;
> -	u16 hwq;
> -	u32 tag;
> -	struct kvec iov = {.iov_base = &reply, .iov_len = sizeof(reply)};
> +	struct kvec iov = {.iov_base = reply, .iov_len = sizeof(*reply)};
>  	struct iov_iter to;
> -	int ret = 0;
> +	int result;
>  
> -	reply.magic = 0;
> -	iov_iter_kvec(&to, READ, &iov, 1, sizeof(reply));
> +	reply->magic = 0;
> +	iov_iter_kvec(&to, READ, &iov, 1, sizeof(*reply));
>  	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
> -	if (result <= 0) {
> -		if (!nbd_disconnected(config))
> +	if (result < 0) {
> +		if (!nbd_disconnected(nbd->config))

The above is actually sort of functional change, I'd suggest to do it in one
single patch because sock_xmit() won't return zero.

-- 
Ming

