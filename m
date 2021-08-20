Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F8CC4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 06:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD5E61053
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 06:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbhHTGKt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 02:10:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57870 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHTGKt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 02:10:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E637F1FD3C;
        Fri, 20 Aug 2021 06:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629439810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uE6bcxoGatn3Wl+0phE0tDUGlv6D4ziVYcesO4HBhro=;
        b=GDU4I9y2rokzc5SqKYzlkap1lWhMwUDovSAPd11audm22rq0owSIs446NU1GoboPOPJ83B
        qW+SspWyFeetKLYoXLXwxYNNXh+ue0rpNtmLken5epHJJY3J3Eciw6wZw8FGyRXbk6O9Zs
        gYjN0XzOydIuFMSeoWBxLdnkJkSMHwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629439810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uE6bcxoGatn3Wl+0phE0tDUGlv6D4ziVYcesO4HBhro=;
        b=/aVCDfKNWfbgFQDJWeE+ueGFtqEef0Wyg55Y9Qs8EqitvqUSzwaxI87pOBgddx+hu+44GE
        9ncmhIvOvV0oqDAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4402B13883;
        Fri, 20 Aug 2021 06:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id sW5xD0JHH2GBLgAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 20 Aug 2021 06:10:10 +0000
Subject: Re: [PATCH 07/11] block: return errors from blk_integrity_add
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-8-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e88fae8a-4173-3f56-2e79-f30e73bd2f6b@suse.de>
Date:   Fri, 20 Aug 2021 08:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818144542.19305-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/21 4:45 PM, Christoph Hellwig wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Prepare for proper error handling in add_disk.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> [hch: split from a larger patch]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-integrity.c | 12 +++++++-----
>   block/blk.h           |  5 +++--
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
