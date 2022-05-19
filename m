Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BA4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 09:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiESJ7C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 05:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiESJ7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 05:59:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0509BAC6;
        Thu, 19 May 2022 02:59:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8FE8F1F86A;
        Thu, 19 May 2022 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652954339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTfOEdTrcSkHCDKW1HmDDhAr0GIpenrsTa4Zvo2nZXs=;
        b=Uge4kVfE8iAskH/Kgfm2XliUWZI+z+sI8QNcO3VqjfBIDPPPNJecp1RBb0z51bf5tQdJOj
        cB5OjDtenTeVB0k65w8BU1MfFd4YKSyPSnTRI+e/QlYPm8nB6IOJ1oQC60ygwIXuZCVWFC
        a/7QdRwGQwht8HNG4U3RJ0l9wQda4R4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 557B613456;
        Thu, 19 May 2022 09:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vowHFOMUhmKIPAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 19 May 2022 09:58:59 +0000
Date:   Thu, 19 May 2022 11:58:58 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, ming.lei@redhat.com,
        geert@linux-m68k.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 2/2] blk-throttle: fix io hung due to
 configuration updates
Message-ID: <20220519095857.GE16096@blackbody.suse.cz>
References: <20220519085811.879097-1-yukuai3@huawei.com>
 <20220519085811.879097-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519085811.879097-3-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Kuayi.

On Thu, May 19, 2022 at 04:58:11PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
> If new configuration is submitted while a bio is throttled, then new
> waiting time is recaculated regardless that the bio might aready wait
> for some time:
> 
> tg_conf_updated
>  throtl_start_new_slice
>   tg_update_disptime
>   throtl_schedule_next_dispatch
> 
> Then io hung can be triggered by always submmiting new configuration
> before the throttled bio is dispatched.

O.K.

> -	/*
> -	 * We're already holding queue_lock and know @tg is valid.  Let's
> -	 * apply the new config directly.
> -	 *
> -	 * Restart the slices for both READ and WRITES. It might happen
> -	 * that a group's limit are dropped suddenly and we don't want to
> -	 * account recently dispatched IO with new low rate.
> -	 */
> -	throtl_start_new_slice(tg, READ);
> -	throtl_start_new_slice(tg, WRITE);
> +	throtl_update_slice(tg, old_limits);

throtl_start_new_slice zeroes *_disp fields.
If for instance, new config allowed only 0.5 throughput, the *_disp
fields would be scaled to 0.5.
How that change helps (better) the previously throttled bio to be dispatched?

(Is it because you omit update of slice_{start,end}?)

Thanks,
Michal

