Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E1BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 14:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiESOzo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 10:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiESOzm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 10:55:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556889AE7F
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 07:55:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7BA521B7D;
        Thu, 19 May 2022 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652972139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kFkmgK6ei5LPD4nlg59oJ0Qf2HOjYZdQfOqbDYtyKg=;
        b=ehFEzvxHG5cTlyJBoA1N1pGBeyAQln3q2OuXO5Z3MGQ5MhLyu1gD4epg83DxBfgaCi6ANQ
        6wetoBxqTiS/ewR3CJnkBBQ+tQqgAxDHCBOe5claA/stlJxnrbwrAxEsw4sFfS9OrYBr8b
        LlnO/bz1nQ76by8h0W0MpKNfH+vtFGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652972139;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kFkmgK6ei5LPD4nlg59oJ0Qf2HOjYZdQfOqbDYtyKg=;
        b=BcbgP3Oz5LpP8R6nxF4W50lXDbrS+nhRR14G89RyaD0JLH4+nB+NRkIxoboESH3odf+8aM
        DVR3r8d0XQ4j7pDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A950D13456;
        Thu, 19 May 2022 14:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q8qmJ2tahmIfUwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 19 May 2022 14:55:39 +0000
Message-ID: <0b33e180-9e23-f737-3c93-5b5b13a7ded2@suse.de>
Date:   Thu, 19 May 2022 16:55:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if
 BLK_CGROUP_FC_APPID is not set
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Muneendra <muneendra.kumar@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
References: <20220519144555.22197-1-hare@suse.de>
 <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 07:50, Jens Axboe wrote:
> On 5/19/22 8:45 AM, Hannes Reinecke wrote:
>> If BLK_CGROUP_FC_APPID is not configured the symbol blkcg_get_fc_appid()
>> is undefined, so it needs to be masked out.
>>
>> This patch is just a diff to the v2 patchset, as the original version has
>> already been merged.
>>
>> Fixes: 980a0e068d14 ("scsi: nvme-fc: Add new routine nvme_fc_io_getuuid()")
> 
> Either this sha is wrong too, or it's not in my tree yet the breakage is.
> 
Picked up from linux-next.
Which tree should I look at?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
