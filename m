Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7593EC678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 06:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCGGzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 01:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCGGzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 01:55:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E16BDDA
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 22:55:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E2BA21994;
        Tue,  7 Mar 2023 06:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678172133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVb6klzYuaFbA5khqo3WM+12byli8+bYBDK5hv1Njyc=;
        b=Qj9a9untYiH+4XeauNy+NmjWOhpaXUdP8Zr/f1kbuWQYAvmiIYYdul9fp0L6RulDI5Aq96
        tfNx14gQU+l27/QUL9LzPTnVeAKW8JGuHQnMbMvvqfERorMPHsyzdg4vaUZk3xYp//AMss
        Csv4uJlx0HlHXcPwEUbFFXNa56HnTsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678172133;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVb6klzYuaFbA5khqo3WM+12byli8+bYBDK5hv1Njyc=;
        b=neWoLNb6JTpFO61pWktEV5q/NYIaFQ5gw6yeDjYnEudHGHVU8j5ZG63/ovjsyqgyjOldex
        kBgqfZpgCw4eXuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32CF813440;
        Tue,  7 Mar 2023 06:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ihp5C+XfBmTjYwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 07 Mar 2023 06:55:33 +0000
Message-ID: <76613838-fa4c-7f3e-3417-7a803fafc6c2@suse.de>
Date:   Tue, 7 Mar 2023 07:55:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/5] brd: convert to folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-2-hare@suse.de> <ZAYk5wOUaXAIouQ5@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAYk5wOUaXAIouQ5@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/6/23 18:37, Matthew Wilcox wrote:
> On Mon, Mar 06, 2023 at 01:01:23PM +0100, Hannes Reinecke wrote:
>> -	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
>> -	if (!page)
>> +	folio = folio_alloc(gfp | __GFP_ZERO, 0);
>> +	if (!folio)
> 
> Did you drop HIGHMEM support on purpose?

No; I thought that folios would be doing that implicitely.
Will be re-adding.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

