Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB76FC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 17:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKBRDs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKBRDr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 13:03:47 -0400
Received: from hermod.demsh.org (hermod.demsh.org [45.140.147.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C011806
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demsh.org; s=022020;
        t=1667408618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EV8wHc153Q1Z1Fn4uarOQ24/jG/hSAHDIP/cR4J/lPQ=;
        b=asbw6jFh1S/ffs4d2qQPQIgKxWI8xdzTEc7v53RYrK+YMt4fPEeO4IbZoMcpztrvafoix9
        XcsKYhALPoQfFdI3mDwQp22DwbyoXcEC2GfjXNWD3iexxHWta8SF3wyvMUijxeRASvQ6kj
        MCXt75z/2HbYeY+NVvoQmOqM4qpQYHS1WNbByPUq4OSU6it41IZwO6tqcTsxRB/IK5/inX
        0ZpX3g6sE0NV2mRparUazCseaS2hUud1HJK+6reVohi/Ck+/HgLXaBB7sn3zgFK/HSegHS
        3hvX+gF3PIenjs5nYjasWyD5kmPUNuKdl9f0V5JCUtUc4dpICnwudDBMKmuSpQ==
Received: from xps.demsh.org (algiz.demsh.org [94.103.82.47])
        by hermod.demsh.org (OpenSMTPD) with ESMTPSA id 35dc3627 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=me;
        Wed, 2 Nov 2022 17:03:38 +0000 (UTC)
Date:   Wed, 2 Nov 2022 20:03:45 +0300
From:   Dmitrii Tcvetkov <me@demsh.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Regression: wrong DIO alignment check with dm-crypt
Message-ID: <20221102200345.0800a8bf@xps.demsh.org>
In-Reply-To: <Y2KXfNZzwPZBJRTW@kbusch-mbp.dhcp.thefacebook.com>
References: <Y2Hf08vIKBkl5tu0@sol.localdomain>
        <Y2KEH6OZ0MDf5cSh@kbusch-mbp.dhcp.thefacebook.com>
        <Y2KXfNZzwPZBJRTW@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2 Nov 2022 10:14:52 -0600
Keith Busch <kbusch@kernel.org> wrote:
> This is what I'm coming up with. Only compile tested (still setting up
> an enviroment to actually run it).
> 
> ---
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 159c6806c19b..9334e58a4c9f 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -43,6 +43,7 @@
>  #include <linux/device-mapper.h>
>  
>  #include "dm-audit.h"
> +#include "dm-core.h"
>  
>  #define DM_MSG_PREFIX "crypt"
>  
> @@ -3615,7 +3616,9 @@ static int crypt_iterate_devices(struct
> dm_target *ti, 
>  static void crypt_io_hints(struct dm_target *ti, struct queue_limits
> *limits) {
> +	struct mapped_device *md = dm_table_get_md(ti->table);
>  	struct crypt_config *cc = ti->private;
> +	struct request_queue *q = md->queue;
>  
>  	/*
>  	 * Unfortunate constraint that is required to avoid the
> potential @@ -3630,6 +3633,8 @@ static void crypt_io_hints(struct
> dm_target *ti, struct queue_limits *limits)
> limits->physical_block_size = max_t(unsigned,
> limits->physical_block_size, cc->sector_size); limits->io_min =
> max_t(unsigned, limits->io_min, cc->sector_size); +
> +	blk_queue_dma_alignment(q, limits->logical_block_size - 1);
>  }
>  
>  static struct target_type crypt_target = {
> --

Applied on top 6.1-rc3, the issue still reproduces.
