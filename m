Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66185C4320A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 05:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B101617E3
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 05:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhHPFyu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 01:54:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58796 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhHPFyt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 01:54:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 069881FE68;
        Mon, 16 Aug 2021 05:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629093258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzA1ReIqnrXwBZbmqYUaT6Z5TBHPWAZsWC2ezyz0xmE=;
        b=X2iMdkDS4fgV5pJtrq+aJKoZkO2HOYr7Y6qM2ZYZ7TB+Fvm90r4Neh/achmcgCdcXiPXis
        /xmlT8KYMxmpJv/MKp7SN0vJbEcNkvC4k+BuHDWjjvfE6rAVRla/Yx8t4tg5XgsLCOnu6R
        wzfMFJ4OeCI7Rgm0vciluaUNU+XNo18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629093258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzA1ReIqnrXwBZbmqYUaT6Z5TBHPWAZsWC2ezyz0xmE=;
        b=RCoAJ8TqJp4hTKxVKJGBOwpVKhjjwfUVnt2dKJr0wvcuPv5wz6/IzGQ5e4wkz7oVZK/bLp
        lcz82JuvwOVvQhBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D949A136A6;
        Mon, 16 Aug 2021 05:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 6N5JNIn9GWEHUAAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 16 Aug 2021 05:54:17 +0000
Subject: Re: [PATCH v7 09/11] libata: Introduce ncq_prio_supported sysfs
 sttribute
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
 <20210816014456.2191776-10-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <45f8523c-2342-7748-0190-44a4d9276a7c@suse.de>
Date:   Mon, 16 Aug 2021 07:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816014456.2191776-10-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/21 3:44 AM, Damien Le Moal wrote:
> Currently, the only way a user can determine if a SATA device supports
> NCQ priority is to try to enable the use of this feature using the
> ncq_prio_enable sysfs device attribute. If enabling the feature fails,
> it is because the device does not support NCQ priority. Otherwise, the
> feature is enabled and success indicates that the device supports NCQ
> priority.
> 
> Improve this odd interface by introducing the read-only
> ncq_prio_supported sysfs device attribute to indicate if a SATA device
> supports NCQ priority. The value of this attribute reflects the status
> of device flag ATA_DFLAG_NCQ_PRIO, which is set only for devices
> supporting NCQ priority.
> 
> Add this new sysfs attribute to the device attributes group of libahci
> and libata-sata.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   drivers/ata/libahci.c     |  1 +
>   drivers/ata/libata-sata.c | 25 +++++++++++++++++++++++++
>   include/linux/libata.h    |  1 +
>   3 files changed, 27 insertions(+)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
