Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A89C4338F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4718960F43
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 16:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhG2QfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229581AbhG2QfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 12:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627576498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b2IWwV+PjfZiDcM190e0ccbCR/0z9UClDJHKuhIKns0=;
        b=R9LAY3KdPo5N8YM7OzLanAnzAci5R3NO6B3NXKgPZGLvsmHNHFIBYvP7RrkKm8ndi8Cbk9
        QJHXOgiLbx9R2VGc2qN9L01xy2SNHMlxaPxz9JIb62VPJjpCH1eu668Jty954qYlErlJHe
        b8udgjJZk/dXBuYgFFEjNFN6wrPtoQo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-DXdUuRjyNByd9DR4bwtvew-1; Thu, 29 Jul 2021 12:34:57 -0400
X-MC-Unique: DXdUuRjyNByd9DR4bwtvew-1
Received: by mail-qk1-f199.google.com with SMTP id y3-20020ae9f4030000b02903b916ae903fso2296343qkl.6
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 09:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b2IWwV+PjfZiDcM190e0ccbCR/0z9UClDJHKuhIKns0=;
        b=DsIZG1eVkjrJ4cDo8TneetrfYx6lg+ruTEgYpSfL0WfVnFBxRby+KLQGNscuR663yS
         bnULhfjaUq+ceWZ+luWOxXG1adIbj7G5pU8MshOW13QzBYtrOeph4d2+g69whbLohMoQ
         j6flcWcdfHszqpL0szKzuFF07UlqEBbEa52YKBSNWUKaYPdQh03gOX7/KTs+UUqCi/yj
         Sbtn7/lKX+BeFcr71JfMGqFuLHbvkr6hOmfFi3EH0IxNdNHSRv4a16DcJB6TjN1jnzaE
         KimrquPF+YBqM94AQbgkgWQrhrg0qbk5OAwcYL0Whip4yVEdxlwsnBQQ1iM6vKya0mu2
         bztA==
X-Gm-Message-State: AOAM530if6rC/MQDTZyIq/PzUQlhXIY0vlh0QGA00N/Ut3Rl4ZpE/0se
        LP1bv5gKaNHsKMkMV/yQD7g2JhCmrB1qwVjWlJFFFyugisrjLNGswTG/oKRgh/cf3XhYkzDY+Aq
        8Sb1zYlAAYBhDlOYMKq9jAw==
X-Received: by 2002:ac8:7761:: with SMTP id h1mr4912065qtu.159.1627576496376;
        Thu, 29 Jul 2021 09:34:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHxljridQsjw0BYRtgO1Mx01oOVyqUfXt1fBaQTGhmMkYIV2eOi47yUtKaP8H2Wj1Qtgd3kg==
X-Received: by 2002:ac8:7761:: with SMTP id h1mr4912050qtu.159.1627576496126;
        Thu, 29 Jul 2021 09:34:56 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id f12sm1966118qke.37.2021.07.29.09.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:34:55 -0700 (PDT)
Date:   Thu, 29 Jul 2021 12:34:54 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 6/8] dm: move setting md->type into dm_setup_md_queue
Message-ID: <YQLYrqxKf3cLBhit@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <20210725055458.29008-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725055458.29008-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 25 2021 at  1:54P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Move setting md->type from both callers into dm_setup_md_queue.
> This ensures that md->type is only set to a valid value after the queue
> has been fully setup, something we'll rely on future changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

> ---
>  drivers/md/dm-ioctl.c | 4 ----
>  drivers/md/dm.c       | 5 +++--
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 2209cbcd84db..2575074a2204 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1436,9 +1436,6 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
>  	}
>  
>  	if (dm_get_md_type(md) == DM_TYPE_NONE) {
> -		/* Initial table load: acquire type of table. */
> -		dm_set_md_type(md, dm_table_get_type(t));
> -
>  		/* setup md->queue to reflect md's type (may block) */
>  		r = dm_setup_md_queue(md, t);
>  		if (r) {
> @@ -2187,7 +2184,6 @@ int __init dm_early_create(struct dm_ioctl *dmi,
>  	if (r)
>  		goto err_destroy_table;
>  
> -	md->type = dm_table_get_type(t);
>  	/* setup md->queue to reflect md's type (may block) */
>  	r = dm_setup_md_queue(md, t);
>  	if (r) {
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 7971ec8ce677..f003bd5b93ce 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2052,9 +2052,9 @@ EXPORT_SYMBOL_GPL(dm_get_queue_limits);
>   */
>  int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>  {
> -	int r;
> +	enum dm_queue_mode type = dm_table_get_type(t);
>  	struct queue_limits limits;
> -	enum dm_queue_mode type = dm_get_md_type(md);
> +	int r;
>  
>  	switch (type) {
>  	case DM_TYPE_REQUEST_BASED:
> @@ -2081,6 +2081,7 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>  	r = dm_table_set_restrictions(t, md->queue, &limits);
>  	if (r)
>  		return r;
> +	md->type = type;
>  
>  	blk_register_queue(md->disk);
>  
> -- 
> 2.30.2
> 

