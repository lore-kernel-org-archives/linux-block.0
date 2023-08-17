Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D47C2FC14
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 05:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbjHQFqD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 01:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348140AbjHQFpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 01:45:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBC31990;
        Wed, 16 Aug 2023 22:45:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A82B41F895;
        Thu, 17 Aug 2023 05:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692251149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybx2UjRN5K63ZivO4yR3n43B2OIui/ORZp64WM14s8g=;
        b=KNjaMq+ivyYiOLMTJOvgr1iLLadHsr7ix9dMlAJvM9xIz/1slfT0QDt7KnrdalK5Mll9fv
        n9hV8HaMblCsCLoAzqJdpaGyf8YXn/5pbgRKxgvF1B3VDON39Q3ngnjp2d6BH8pZfF/0Ky
        UBdWwF9NyXKQHl31+elpY4BnICKFhS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692251149;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybx2UjRN5K63ZivO4yR3n43B2OIui/ORZp64WM14s8g=;
        b=jRsC/3SYkZpHkFP7oTxiHs5YMeUoBVDmXUDmzUj/7UUN2hGbYyZf6qQhQ24qfnjO1BAZw/
        PL950fWyYk6bpaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6387513909;
        Thu, 17 Aug 2023 05:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ou3HEw203WRcCQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 17 Aug 2023 05:45:49 +0000
Message-ID: <14376b9c-2536-4826-0ecb-f926ab36d5f0@suse.de>
Date:   Thu, 17 Aug 2023 07:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 3/3 RESEND] powerpc/pseries: PLPKS SED Opal keystore
 support
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        keyrings@vger.kernel.org, okozina@redhat.com, dkeefe@redhat.com
References: <20230721211949.3437598-1-gjoyce@linux.vnet.ibm.com>
 <20230721211949.3437598-4-gjoyce@linux.vnet.ibm.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230721211949.3437598-4-gjoyce@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/23 23:19, gjoyce@linux.vnet.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> 
> Define operations for SED Opal to read/write keys
> from POWER LPAR Platform KeyStore(PLPKS). This allows
> non-volatile storage of SED Opal keys.
> 
> Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> ---
>   arch/powerpc/platforms/pseries/Kconfig        |   6 +
>   arch/powerpc/platforms/pseries/Makefile       |   1 +
>   .../powerpc/platforms/pseries/plpks_sed_ops.c | 114 ++++++++++++++++++
>   block/Kconfig                                 |   1 +
>   4 files changed, 122 insertions(+)
>   create mode 100644 arch/powerpc/platforms/pseries/plpks_sed_ops.c
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

