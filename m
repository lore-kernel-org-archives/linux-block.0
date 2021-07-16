Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A8C07E95
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 05:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A367E613C0
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 05:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhGPFxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:53:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40450 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhGPFxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jul 2021 01:53:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C07A01FE77;
        Fri, 16 Jul 2021 05:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626414612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2l/S+SQ8m0ePnjAwLmk4gIz/3QzyUJAOggIwEnz7yQ=;
        b=GWPE4wOoBfpOjsqmMmerc4nUJXLJV7q16dps+IH1h3SSYspYq9cvJ1CT8lmf+0OgrvSP4/
        GcutSggZiyasRy+AgUZHNy92v1qg18PZ4yTQ/BNrH2nEkJGbeqcmNKLe1XSqj3Tutcsimz
        seHwOtmd0X/rvZ18MLUVqslHzczYRFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626414612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2l/S+SQ8m0ePnjAwLmk4gIz/3QzyUJAOggIwEnz7yQ=;
        b=b55yLdP6Zz64n9tm7TxWWuKGahxHrXMsko3N2NlYJHpDoVpiadPaFGe1EK0iWY+nJul7/Q
        +Cv1k/X20pWeSoAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 804B813357;
        Fri, 16 Jul 2021 05:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id zZhjHhQe8WChNwAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 05:50:12 +0000
Subject: Re: [RFC 1/6] genhd: update docs for GENHD_FL_UP
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-2-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4741ef3a-71e3-7118-55e1-c3545a88f967@suse.de>
Date:   Fri, 16 Jul 2021 07:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715202341.2016612-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/21 10:23 PM, Luis Chamberlain wrote:
> The GENHD_FL_UP is used internally so we can know when we can add and
> remove partitions, so just clarify that. Right now it has this 1980's
> description comparing it to network drivers "ifconfig up" idea, and
> that can easily lead to invalid uses.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   include/linux/genhd.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 51f27b9b38b5..dc07a957c9e1 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -61,7 +61,7 @@ struct partition_meta_info {
>    * Affects responses to the ``CDROM_GET_CAPABILITY`` ioctl.
>    *
>    * ``GENHD_FL_UP`` (0x0010): indicates that the block device is "up",
> - * with a similar meaning to network interfaces.
> + * and we can add / remove partitions.
>    *
>    * ``GENHD_FL_SUPPRESS_PARTITION_INFO`` (0x0020): don't include
>    * partition information in ``/proc/partitions`` or in the output of
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
