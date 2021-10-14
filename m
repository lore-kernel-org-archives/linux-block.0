Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F69C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68AF60ED4
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhJNHWj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:22:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42230 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNHWe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 03:22:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 665E021A74;
        Thu, 14 Oct 2021 07:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634196029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aPTi1jqJyanJr/yNq20ScgD69zcuM+p9ZxOZzkcy74A=;
        b=mk0T43qO+gs1pZQcg5yt0kA/uzk9/YwB09jawrZrsNAviPBypyhCXoOzqCQYFojVwSI+LL
        gro6hZXd5pbzgHaGRJFz2iXxZq5jiMIHAdbt8/y97cJej3QKh+uLJp20WGGvU8hjHaQCTc
        reG6LjMlw3h+/wYJX7cMcN+ZXbcCbiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634196029;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aPTi1jqJyanJr/yNq20ScgD69zcuM+p9ZxOZzkcy74A=;
        b=hLrXfej1L/ZECPSWBM2VaEQ39O70S6E51TUwwUoHcPbwES0vHNSyyd8OH+wKJCyTLA7W2w
        b1FdWO+RPRRIN7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C63A13D3F;
        Thu, 14 Oct 2021 07:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p8PqDD3aZ2EQGAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 14 Oct 2021 07:20:29 +0000
Subject: Re: [PATCH 4/9] sbitmap: test bit before calling test_and_set_bit()
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-5-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <409c693c-4570-b6f4-3839-501633856151@suse.de>
Date:   Thu, 14 Oct 2021 09:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211013165416.985696-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 6:54 PM, Jens Axboe wrote:
> If we come across bits that are already set, then it's quicker to test
> that first and gate the test_and_set_bit() operation on the result of
> the bit test.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   lib/sbitmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index c6e2f1f2c4d2..11b244a8d00f 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -166,7 +166,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>   			return -1;
>   		}
>   
> -		if (!test_and_set_bit_lock(nr, word))
> +		if (!test_bit(nr, word) && !test_and_set_bit_lock(nr, word))
>   			break;
>   
>   		hint = nr + 1;
> 
Hah. Finally something to latch on.

I've seen this coding pattern quite a lot in the block layer, and, of 
course, mostly in the hot path.
(Kinda the point, I guess :-)

However, my question is this:

While 'test_and_set_bit()' is atomic, the combination of
'test_bit && !test_and_set_bit()' is not.

IE this change moves an atomic operation into a non-atomic one.
So how can we be sure that this patch doesn't introduce a race condition?
And if it doesn't, should we add some comment above the code why this is 
safe to do here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
