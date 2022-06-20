Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBD7CCA479
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 08:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbiFTIir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbiFTIio (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 04:38:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCBA6142
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 01:38:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7EC941F896;
        Mon, 20 Jun 2022 08:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655714322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACKir5zP+eG4UUMlQzkgpWtHlczfQX0g4+bVV6ZGsLc=;
        b=Urxu+fqLY4DjCqZd1sZZbvhOdjoQ6OWQzPWJUu9WccbGQv6s3md5v9cjGdNi2OwYkbXdaV
        C19J2vW4H2ufz+9NMm6kCiu3D6+XznLia9tWz6PiGMl+SNhXX8ymdNHAI4QKO1UFS0bMQg
        O/DPaQOSld+IuuBGLOtN/rtHwb3qst8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655714322;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACKir5zP+eG4UUMlQzkgpWtHlczfQX0g4+bVV6ZGsLc=;
        b=31QDkIfWsx3sOOuhzH3Djhz/GCwL4TFTfBXE5NTya/hkOIS1BgzJiq11d+GEcFT+hsExAH
        zKz1SakmheUMazDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7362313638;
        Mon, 20 Jun 2022 08:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q/MDHBIysGLaKQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 08:38:42 +0000
Message-ID: <3660e181-e42f-4519-d921-49dee66c416f@suse.de>
Date:   Mon, 20 Jun 2022 10:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/6] mtip32xx: fix device removal
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <20220619060552.1850436-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220619060552.1850436-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/22 08:05, Christoph Hellwig wrote:
> Use the proper helper to mark a surpise removal, remove the gendisk as
> soon as possible when removing the device and implement the ->free_disk
> callback to ensure the private data is alive as long as the gendisk has
> references.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/mtip32xx/mtip32xx.c | 157 +++++++++---------------------
>   drivers/block/mtip32xx/mtip32xx.h |   1 -
>   2 files changed, 44 insertions(+), 114 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
