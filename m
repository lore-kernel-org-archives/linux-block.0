Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041CAC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 13:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiBBNMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 08:12:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBBNMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 08:12:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D2F41210ED;
        Wed,  2 Feb 2022 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643807556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeKybl4dcmXME3Zk79py98Ve1WbwFCSLq0uKxUj4yLE=;
        b=EKvnmKmLfHGpFwrsaspwcMUAUd8ATxLs8hHqiH4lcaWjj9rAe2aan69VCpeRGIT8v2umS/
        vMacQJRfrQqMRbpFy17eHkkt1eGhS+KQTRufDnsYVvLHKpQhT6Ko+y1XlejCHQYx4iSzi1
        GXXuAQAjhhhkFyusLKPJsNnC1I4nr9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643807556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeKybl4dcmXME3Zk79py98Ve1WbwFCSLq0uKxUj4yLE=;
        b=1iUjeR3iak9bsrOSglM0uDXUZfKRaJSH/SYfUHTqZVcGJrUiWzbLj5Ph0T9+uWjGGWfNuV
        C94DPX2fZ/IdGlAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C533D13E48;
        Wed,  2 Feb 2022 13:12:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K9L1L0SD+mFhPwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:12:36 +0000
Message-ID: <88f55767-9157-17c9-29f1-e4615736da39@suse.de>
Date:   Wed, 2 Feb 2022 14:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 2/7] nvme: allow integrity on extended metadata formats
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-3-kbusch@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201190128.3075065-3-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/22 20:01, Keith Busch wrote:
> The block integrity subsystem knows how to construct protection
> information buffers with metadata beyond the protection information
> fields. Remove the driver restriction.
> 
> Note, this can only work if the PI field appears first in the metadata,
> as the integrity subsystem doesn't calculate guard tags on preceding
> metadata.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
