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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01574C432BE
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 05:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D54617E3
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 05:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhHPFzX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 01:55:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhHPFzX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 01:55:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E7F31FE68;
        Mon, 16 Aug 2021 05:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629093291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p14GSSLNAiRfwnN7o5zkhNvswR7f9BwazO81d15BYos=;
        b=xkxZ1Fd74mU2RudLwFfTWEF82UGonU2bPhUWkaIQ3pFBdKdbrwNupGrZQJMhNpaREKP52Q
        bwi5xvjrkHb4cWuWKBvQ0CdmH6RQYPbXO+kRGZlqqsf5mrBUFBGhavFL/KNPicozvtp7K6
        vO88iFobZWpahTaZeXR/trPjtGt7HgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629093291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p14GSSLNAiRfwnN7o5zkhNvswR7f9BwazO81d15BYos=;
        b=HjXd8Jh8Tm/HRJq0ztHJuYdEdtdnCh2XUViQvKaPtgDc13zewCT5mepv9yuDK/DwxhoBT+
        ljTc+IaUjs5OxPCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 78B13136A6;
        Mon, 16 Aug 2021 05:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Tn+iG6v9GWEUUAAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 16 Aug 2021 05:54:51 +0000
Subject: Re: [PATCH v7 10/11] docs: sysfs-block-device: improve
 ncq_prio_enable documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
 <20210816014456.2191776-11-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d7fd2159-1034-9e64-8e14-d4edfbd94b7f@suse.de>
Date:   Mon, 16 Aug 2021 07:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816014456.2191776-11-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/21 3:44 AM, Damien Le Moal wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> NCQ priority is an optional feature of the NCQ feature set and should
> not be confused with the NCQ feature set itself. Clarify the
> description of the ncq_prio_enable attribute to avoid this confusion.
> 
> Also add the missing documentation for the equivalent
> sas_ncq_prio_enable attribute.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   Documentation/ABI/testing/sysfs-block-device | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
