Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4124C07E95
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 05:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7583E613E9
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 05:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhGPF4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:56:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40554 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhGPF4L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jul 2021 01:56:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B733B1FE72;
        Fri, 16 Jul 2021 05:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626414796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1L17zMr3wcNoCrkI7xQiSL9TJhP/u3QrOzu6reOkYI=;
        b=IgQhLU4DcGIrIGK9fRLTm4ZrJxe7QVD77Q0sA7GJ6urwvybP5juQRgAQtNIvKO7roHGMOv
        1t98kao/T5Hjk0pJtnlGN/+XvS/5WlebaRbS4hJramgU9axgFbnChXUDTYEe5taclwj5nW
        x7Idu7Jeq0IjolxH3vIlTc+nRgVSPV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626414796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1L17zMr3wcNoCrkI7xQiSL9TJhP/u3QrOzu6reOkYI=;
        b=GhxXOHbmrdmzRs/DZqm1v/xTfHSI2dPxJ/QxAwKQCKm7s3tp+NMWii0ssGBuNHzcWfae3Q
        KKgNe0ora8AV4VDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 85A3F13357;
        Fri, 16 Jul 2021 05:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FCKqH8we8WBNOAAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 05:53:16 +0000
Subject: Re: [RFC 5/6] nvme: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-6-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e9212eb9-269c-47d1-60d8-f5282ad5c441@suse.de>
Date:   Fri, 16 Jul 2021 07:53:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715202341.2016612-6-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/21 10:23 PM, Luis Chamberlain wrote:
> The GENHD_FL_DISK_ADDED flag is what we really want, as the
> flag GENHD_FL_UP could be set on a semi-initialized device.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/nvme/host/core.c      | 4 ++--
>   drivers/nvme/host/multipath.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 11779be42186..3848353fba11 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1819,7 +1819,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   static inline bool nvme_first_scan(struct gendisk *disk)
>   {
>   	/* nvme_alloc_ns() scans the disk prior to adding it */
> -	return !(disk->flags & GENHD_FL_UP);
> +	return !(disk->flags & GENHD_FL_DISK_ADDED);
>   }
>   
>   static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
> @@ -3823,7 +3823,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	nvme_mpath_clear_current_path(ns);
>   	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
>   
> -	if (ns->disk->flags & GENHD_FL_UP) {
> +	if (ns->disk->flags & GENHD_FL_DISK_ADDED) {
>   		if (!nvme_ns_head_multipath(ns->head))
>   			nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>   		del_gendisk(ns->disk);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0ea5298469c3..8048678969ba 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -764,7 +764,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>   {
>   	if (!head->disk)
>   		return;
> -	if (head->disk->flags & GENHD_FL_UP) {
> +	if (head->disk->flags & GENHD_FL_DISK_ADDED) {
>   		nvme_cdev_del(&head->cdev, &head->cdev_device);
>   		del_gendisk(head->disk);
>   	}
> 
Same here: please use the wrapper.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
