Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143CC4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 06:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C08B6108E
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 06:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhHTGNA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 02:13:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49854 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhHTGM6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 02:12:58 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3024220F1;
        Fri, 20 Aug 2021 06:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629439940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OX9Ht1HRpV82F4MFKdGymJRaDa3QPrFV/O+yr9dQsdA=;
        b=j2mH8h0Vf2B2MIP8q4IUNx3H6fRFr4GL3IxFDztYROcb65sUOJr04ETGLDPOk2FF9gsJsp
        eLh6lamFfUo33sPteoKia/za6Zrb97u0Nyr3WsHxELUx5JBFyWtvY/smYeRgguK8uDlAbu
        gY3rFF1IVf52l0Ez/iwTgOkQXSmoXtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629439940;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OX9Ht1HRpV82F4MFKdGymJRaDa3QPrFV/O+yr9dQsdA=;
        b=NhZDeQg0z1s3Y2RrtxjEymO/XdlNPqt8JIYBgaztYMt+Sn9iQYHmIpINbzLWqunUtY5PPu
        DJZepdu0sbxlCfAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8E12C13883;
        Fri, 20 Aug 2021 06:12:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id tlz7IMRHH2FfLwAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 20 Aug 2021 06:12:20 +0000
Subject: Re: [PATCH 09/11] block: add error handling for device_add_disk /
 add_disk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-10-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <916b2a20-7410-cf4f-1cae-c88aadcbcd3d@suse.de>
Date:   Fri, 20 Aug 2021 08:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818144542.19305-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/21 4:45 PM, Christoph Hellwig wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Properly unwind on errors in device_add_disk.  This is the initial work
> as drivers are not converted yet, which will follow in separate patches.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> [hch: major rebase.  All bugs are probably mine]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c         | 92 +++++++++++++++++++++++++++----------------
>   include/linux/genhd.h |  8 ++--
>   2 files changed, 62 insertions(+), 38 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
