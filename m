Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2548FE7849A
	for <linux-block@archiver.kernel.org>; Mon,  2 Oct 2023 06:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjJBGIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Oct 2023 02:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJBGIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2023 02:08:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EE4AD
        for <linux-block@vger.kernel.org>; Sun,  1 Oct 2023 23:08:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2276421878;
        Mon,  2 Oct 2023 06:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696226929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3DqLfdkzLYgKWALoxaii2XOWJPsYglPfRPRxUDS5C8=;
        b=xBR4VcAcktNPWbLuy1yqZ7mcGUL+oj+yS18vnMpZLCJHbweh+6jOHzvfnMOpHtfYpan/bD
        dpn0gMj882jm4ra41Ewiq403ekbds6BcAIuop681oMXCQnFQOzDD8lPB3kiOQ+LhURigYP
        c6OAbKiiJj8MsoT+rEIhaVa9f+xC9AU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696226929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3DqLfdkzLYgKWALoxaii2XOWJPsYglPfRPRxUDS5C8=;
        b=1Rb+CUEtvoDyygzUTO1RRwfoI8bUTvGGgurt6kP/DzVDvguwr5ncMW4hBVx3rg6NfCHoj9
        9o1rSEWMCpdyM/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E036413ADD;
        Mon,  2 Oct 2023 06:08:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O9TGMnBeGmXuXwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 02 Oct 2023 06:08:48 +0000
Message-ID: <3fc0be94-8fdb-43c9-81f2-0ca053f6212c@suse.de>
Date:   Mon, 2 Oct 2023 08:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ublk: Limit dev_id/ub_number values
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk
References: <20231001185448.48893-1-michael.christie@oracle.com>
 <20231001185448.48893-2-michael.christie@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231001185448.48893-2-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/23 20:54, Mike Christie wrote:
> The dev_id/ub_number is used for the ublk dev's char device's minor
> number so it has to fit into MINORMASK. This patch adds checks to prevent
> userspace from passing a number that's too large and limits what can be
> allocated by the ublk_index_idr for the case where userspace has the
> kernel allocate the dev_id/ub_number.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/block/ublk_drv.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 630ddfe6657b..18e352f8cd6d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -470,6 +470,7 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
>    * It can be extended to one per-user limit in future or even controlled
>    * by cgroup.
>    */
> +#define UBLK_MAX_UBLKS (UBLK_MINORS - 1)
>   static unsigned int ublks_max = 64;
>   static unsigned int ublks_added;	/* protected by ublk_ctl_mutex */
>   
> @@ -2026,7 +2027,8 @@ static int ublk_alloc_dev_number(struct ublk_device *ub, int idx)
>   		if (err == -ENOSPC)
>   			err = -EEXIST;
>   	} else {
> -		err = idr_alloc(&ublk_index_idr, ub, 0, 0, GFP_NOWAIT);
> +		err = idr_alloc(&ublk_index_idr, ub, 0, UBLK_MAX_UBLKS,
> +				GFP_NOWAIT);
>   	}
>   	spin_unlock(&ublk_idr_lock);
>   
> @@ -2305,6 +2307,12 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>   		return -EINVAL;
>   	}
>   
> +	if (header->dev_id != U32_MAX && header->dev_id > UBLK_MAX_UBLKS) {
> +		pr_warn("%s: dev id is too large. Max supported is %d\n",
> +			__func__, UBLK_MAX_UBLKS);
> +		return -EINVAL;
> +	}
> +
>   	ublk_dump_dev_info(&info);
>   
>   	ret = mutex_lock_killable(&ublk_ctl_mutex);

Why don't you do away with ublks_max and switch to dynamic minors once 
UBLK_MAX_UBLKS is reached?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

