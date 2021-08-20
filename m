Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0323BC4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 06:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD88F61075
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 06:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhHTGNe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 02:13:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57946 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbhHTGNd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 02:13:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD7611FD3C;
        Fri, 20 Aug 2021 06:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629439975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbXmhgauM9AJdqva4LmiuxyMhXAyUjAl689AFUY/B5Y=;
        b=y2/q7viYdIG5zYS7ib90gaJzhMpFqx3Ikj6v/v/07hh8g1FxkRac5Gzvx629AH11MzM5ai
        nXYFbdkVfPodlIfxq8kzpjT0sZUvpOeKb0kOf/mvgmj/MLg+WtRPCIm2abzItrG9NncvPA
        6i4bls5nrYpbSemVLPw5asLI3/mSZWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629439975;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbXmhgauM9AJdqva4LmiuxyMhXAyUjAl689AFUY/B5Y=;
        b=ggd2OXBlY7Kai4bpknY0K9G59CklRmod1bsGvRaO8aUKASV/SYg/Wo8Vx3wjC+lplVP4QH
        61szptFzhujcmhAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9E36B13883;
        Fri, 20 Aug 2021 06:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id aVa0JedHH2FzLwAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 20 Aug 2021 06:12:55 +0000
Subject: Re: [PATCH 10/11] virtio_blk: add error handling support for
 add_disk()
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-11-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9a8c7cae-bb7f-ea11-b9e5-a307218cb8d4@suse.de>
Date:   Fri, 20 Aug 2021 08:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818144542.19305-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/21 4:45 PM, Christoph Hellwig wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/block/virtio_blk.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
