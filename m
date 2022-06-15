Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2E1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 16:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiFOQ4b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbiFOQ4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 12:56:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA10E4EA3E
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 09:56:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9BD841F967;
        Wed, 15 Jun 2022 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655312181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQbhT2k92/E7pNF5NGUzO0piFKL9BMGkKUkdICGYIg8=;
        b=Onhi+GiZp2ClSwqyvvkdoSNs1r/dGA+loKRjqtrccDOP/lhBNjCaYVM8yNNz/yZmMIXzmQ
        1XwflpJDPE08+8GSwjO+oa8CNPnOeJ1XCgTAeQcsFcKOv+XdfrUzq/UqLVM9qN7LckLgmj
        59sGC3mEytgBvk6b8z2npSAb6jsgbqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655312181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQbhT2k92/E7pNF5NGUzO0piFKL9BMGkKUkdICGYIg8=;
        b=jDs0gxs3iujy+Cix9wg2jXHkgti+ziEfxnaQqGMrkQMUurDV4zmZRdUoHBALUX6+86xUcx
        MH8vUDBxlyFMg2Dw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2B4E72C141;
        Wed, 15 Jun 2022 16:56:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C5718A062E; Wed, 15 Jun 2022 18:56:20 +0200 (CEST)
Date:   Wed, 15 Jun 2022 18:56:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jan Kara <jack@suse.cz>, "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: Ignore errors from wait(1)
Message-ID: <20220615165620.fs4yilch7nlcjmrl@quack3.lan>
References: <20220613151721.18664-1-jack@suse.cz>
 <20220614070454.5tcyunt53nqf3y7q@shindev>
 <20220614131803.hwoykpwzfh6pxmda@quack3.lan>
 <20220615115014.nm3utxgvq2hkhuzo@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615115014.nm3utxgvq2hkhuzo@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 15-06-22 11:50:14, Shinichiro Kawasaki wrote:
> On Jun 14, 2022 / 15:18, Jan Kara wrote:
> > On Tue 14-06-22 07:04:54, Shinichiro Kawasaki wrote:
> 
> [...]
> 
> > Yes, I suspect it depends on the shell as well (because otherwise I expect
> > people would hit this much earlier than me :). The bash I have is
> > "4.4.23(1)-release" - the one in openSUSE 15.3 and it shows the error
> > pretty reliably...
> 
> I guess the problematic wait command output is job exit status report. To
> confirm my guess, could your share example of the wait command output?
> 
> Based on my guess, I checked difference between bash 4.4 and my bash 5.1, but I
> did not find notable bash code change about job exit status report. Hmm.
> 
> Your patch covers several waits in the block group. I suspect other waits in
> other groups may have same risk. Instead of your patch, could you try the patch
> below on your system? If it works, all waits in all groups can be addressed.

Ah, indeed. This patch fixes the problem for me as well. Thanks for looking
into this!

								Honza

> 
> diff --git a/check b/check
> index 7037d88..ac24afa 100755
> --- a/check
> +++ b/check
> @@ -440,6 +440,10 @@ _run_test() {
>  	RUN_FOR_ZONED=0
>  	FALLBACK_DEVICE=0
>  
> +	# Ensure job control monitor mode is off in this sub-shell to suppress
> +	# job status output.
> +	set +m
> +
>  	# shellcheck disable=SC1090
>  	. "tests/${TEST_NAME}"
>  
> 
> 
> -- 
> Shin'ichiro Kawasaki
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
