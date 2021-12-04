Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E761C433F5
	for <linux-block@archiver.kernel.org>; Sat,  4 Dec 2021 10:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhLDKtC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:49:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57600 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384634AbhLDKtC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Dec 2021 05:49:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDB8E218A8;
        Sat,  4 Dec 2021 10:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638614735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMnoxpj71x9JHRoSc3fgTerD1+UNPIurvEtthRFPiJ0=;
        b=fPwLQaANb34jGVNx3sDnN1OIQYjfsAO0kQGP3vz+tSxLv32Ox9uH1J5oG10gbLfawmoJm5
        r830HQCi2YqXO20O7mIiaYgYw5gIn3hK+FxsanweI1DnLB9dgEUTPJ13AyWs392a8GsopR
        6Kv9KJrnvdHBu/1OcbJTlwyQFdjaC9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638614735;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WMnoxpj71x9JHRoSc3fgTerD1+UNPIurvEtthRFPiJ0=;
        b=Wt98VwuwI2rNl+/bQJ/sdrTdWXMWskFKujZd1mjakYWc3fQInkqz6vK+qRaREyAwtbUFVs
        2l+7zW65LIWm62CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD81D13BF8;
        Sat,  4 Dec 2021 10:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0LdkNc9Gq2FHawAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 04 Dec 2021 10:45:35 +0000
Subject: Re: [PATCH 3/4] nvme: separate command prep and issue
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-4-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8facb330-ba89-614c-79e0-a12b1b4e13cc@suse.de>
Date:   Sat, 4 Dec 2021 11:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211203214544.343460-4-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 10:45 PM, Jens Axboe wrote:
> Add a nvme_prep_rq() helper to setup a command, and nvme_queue_rq() is
> adapted to use this helper.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 57 ++++++++++++++++++++++++-----------------
>   1 file changed, 33 insertions(+), 24 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
