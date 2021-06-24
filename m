Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED360C48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5285613E3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhFXH4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 03:56:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57868 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhFXH4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 03:56:00 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90BC021963;
        Thu, 24 Jun 2021 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624521221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IY5ffLnavbB7mwIKZt2ULpzd/HcDJcP309zINASeBF4=;
        b=wXN9jQyt7TSRPkdeKFKnB4lPc/DJ6hiDa9dtQx1iwvpCdJM5ZGKk5I8uHeO/KE4SYK2TgB
        ahmNl/UjL/2783yPCN9+jXt97s7DjbKlzN5BOIIr4WrobxwuUWcuU89+/LWJVvqn7xGzdg
        rg3OAT5OVngM9oDk98Rje4huB7bM4SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624521221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IY5ffLnavbB7mwIKZt2ULpzd/HcDJcP309zINASeBF4=;
        b=TtFOznAthvlg6acOSqJMdCFuOXwY7nW5o6nTe8M5wA+K0ei6n9UphGujZmEKDk5zf8hJdV
        J2WLkZ1sGvAEkICg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7D23611A97;
        Thu, 24 Jun 2021 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624521221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IY5ffLnavbB7mwIKZt2ULpzd/HcDJcP309zINASeBF4=;
        b=wXN9jQyt7TSRPkdeKFKnB4lPc/DJ6hiDa9dtQx1iwvpCdJM5ZGKk5I8uHeO/KE4SYK2TgB
        ahmNl/UjL/2783yPCN9+jXt97s7DjbKlzN5BOIIr4WrobxwuUWcuU89+/LWJVvqn7xGzdg
        rg3OAT5OVngM9oDk98Rje4huB7bM4SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624521221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IY5ffLnavbB7mwIKZt2ULpzd/HcDJcP309zINASeBF4=;
        b=TtFOznAthvlg6acOSqJMdCFuOXwY7nW5o6nTe8M5wA+K0ei6n9UphGujZmEKDk5zf8hJdV
        J2WLkZ1sGvAEkICg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id iOJtHgU61GCbDQAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 24 Jun 2021 07:53:41 +0000
Subject: Re: [PATCH 2/2] block: add the events* attributes to disk_attrs
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
References: <20210624073843.251178-1-hch@lst.de>
 <20210624073843.251178-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ab1e51b5-6f74-b6a3-7e97-bb37c1121165@suse.de>
Date:   Thu, 24 Jun 2021 09:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210624073843.251178-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/21 9:38 AM, Christoph Hellwig wrote:
> Add the events attributes to the disk_attrs array, which ensures they are
> added by the driver core when the device is created rather than adding
> them after the device has been added, which is racy versus uevents and
> requires more boilerplate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk.h         |  3 +++
>  block/disk-events.c | 23 ++++-------------------
>  block/genhd.c       |  3 +++
>  3 files changed, 10 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
