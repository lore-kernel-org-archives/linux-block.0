Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0306BC4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 06:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJLGiu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 02:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJLGis (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 02:38:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C99B03DA
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 23:38:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6FF221C60;
        Wed, 12 Oct 2022 06:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665556725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y12OjQNa1F10+3FBfPhH23EF80puxxXBESkfYrPIs64=;
        b=ymkolCKQaG6NsTNorJeKqysmVDPbO1g7J/sC+rLHjpbPD8nR37HjkiFwwpmMIB+bYhbKqN
        vNp+kJ+pDXyeGdQZ9P3Tk5NW4M4aX5Lfvrk9G+JWnFqbaNPR0iIis3vyVWNQv9GaQBXQ4Z
        PEUTwMUbYP+JY3KWgOqxgFBHubALDW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665556725;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y12OjQNa1F10+3FBfPhH23EF80puxxXBESkfYrPIs64=;
        b=jJhUdnxneFgWVvHJajp9bwOuxgJQRZTnhceEzrjoExMR4KwszCZU5Q2v9ZHR0dh6PpGRoJ
        AiiC68VRAue59wDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EBD113ACD;
        Wed, 12 Oct 2022 06:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id afIzFPVgRmPvKQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 12 Oct 2022 06:38:45 +0000
Message-ID: <4096861e-7010-97f3-0d6c-a488cf9bea9e@suse.de>
Date:   Wed, 12 Oct 2022 08:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH blktests] tests/nvme: set hostnqn after hostid uuidgen
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, shinichiro.kawasaki@wdc.com
Cc:     linux-block@vger.kernel.org
References: <20221011174325.311286-1-yi.zhang@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221011174325.311286-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/11/22 19:43, Yi Zhang wrote:
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>   tests/nvme/041 | 3 ++-
>   tests/nvme/042 | 3 ++-
>   tests/nvme/043 | 3 ++-
>   tests/nvme/044 | 3 ++-
>   tests/nvme/045 | 3 ++-
>   5 files changed, 10 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

