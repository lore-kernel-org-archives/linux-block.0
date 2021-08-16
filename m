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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C95BC432BE
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 05:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A341617E3
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 05:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhHPFyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 01:54:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33136 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhHPFyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 01:54:05 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B26D21E35;
        Mon, 16 Aug 2021 05:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629093213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJD66JK/QbqMVGhZFAE1lmS4E54mftfsrYa+7+AS7hw=;
        b=pOpgohigd9Q3X7eSaeGihJDC2v3ZEerTEKJnTHNcBnoJuP2cKvLfa27ToDCzvoLPyjrqrJ
        TzrgLAA8lt+liJfk2aoVq8xdaPDt8WFLoHP0ye7yB1155bnUvM0Ii0IVu1vdB0gsTefMbX
        Mwb1nyUfWb5Mru0cRIj/7mZaCKjdbuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629093213;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJD66JK/QbqMVGhZFAE1lmS4E54mftfsrYa+7+AS7hw=;
        b=BSYP9A05Juebm+PPzPr56MFO/Es0+a935LwP616P9cHTaElROt/uU5kMP2XJo1Cr6QlC0q
        zbRUmqtToMWYNUBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 71A5C136A6;
        Mon, 16 Aug 2021 05:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id i4ACG139GWH1TwAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 16 Aug 2021 05:53:33 +0000
Subject: Re: [PATCH v7 01/11] libata: fix ata_host_alloc_pinfo()
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
 <20210816014456.2191776-2-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a849c068-5538-30bc-9f0d-8dd2985e1375@suse.de>
Date:   Mon, 16 Aug 2021 07:53:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816014456.2191776-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/21 3:44 AM, Damien Le Moal wrote:
> Avoid static checkers warnings about a potential NULL pointer
> dereference for the port info variable pi. To do so, test that at least
> one port info is available on entry to ata_host_alloc_pinfo() and start
> the ata port initialization for() loop with pi initialized to the first
> port info passed as argument (which is already checked to be non NULL).
> Within the for() loop, get the next port info, if it is not NULL,
> after initializing the ata port using the previous port info.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   drivers/ata/libata-core.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
