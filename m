Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D33C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B6D611CA
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhHFGjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:39:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55232 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhHFGjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 02:39:44 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D7154220DC;
        Fri,  6 Aug 2021 06:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628231968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cV0RA/Arj9e5UZlBlatsxjaXnCgVHR/k0A0IbcKoE5s=;
        b=vQulwVbMfvbzZndkQLuSEyPzMd0nJJZxpwQsVnUE+RlZbTGhHPQZUu4RlSjtQfxIRTX87s
        QOJG1ZahM9FxFjE9bksgm5zeXG4yIiN99epOxMPVjXlobcJogh4bD9tFeKx1CPPZcUx5EW
        NAcSlzdC1LnkEtfaU6dj6Qi2AAGOXIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628231968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cV0RA/Arj9e5UZlBlatsxjaXnCgVHR/k0A0IbcKoE5s=;
        b=iqaMnbGiXV+xcE3ghgfFmGGZirrBiKqfN+VYhLeMN0spHkOQzmqSFyoZK+7JxqWx80CvfB
        Gaw3lLi1NleSWaDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8B8DA136D9;
        Fri,  6 Aug 2021 06:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UKj+ICDZDGHTBgAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 06 Aug 2021 06:39:28 +0000
Subject: Re: [PATCH v2 4/4] block: fix default IO priority handling
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
 <20210806051140.301127-5-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8304adbf-f7de-b8ae-3230-f19c8e51cace@suse.de>
Date:   Fri, 6 Aug 2021 08:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806051140.301127-5-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/21 7:11 AM, Damien Le Moal wrote:
> The default IO priority is the best effort (BE) class with the
> normal priority level IOPRIO_NORM (4). However, get_task_ioprio()
> returns IOPRIO_CLASS_NONE/IOPRIO_NORM as the default priority and
> get_current_ioprio() returns IOPRIO_CLASS_NONE/0. Let's be consistent
> with the defined default and have both of these functions return the
> default priority IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM) when
> the user did not define another default IO priority for the task.
> 
> In include/linux/ioprio.h, rename the IOPRIO_NORM macro to
> IOPRIO_BE_NORM to clarify that this default level applies to the BE
> priotity class. Also, define the macro IOPRIO_DEFAULT as
> IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM) and use this new
> macro when setting a priority to the default.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   block/bfq-iosched.c          | 2 +-
>   block/ioprio.c               | 6 +++---
>   drivers/nvme/host/lightnvm.c | 2 +-
>   include/linux/ioprio.h       | 7 ++++++-
>   include/uapi/linux/ioprio.h  | 4 ++--
>   5 files changed, 13 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
