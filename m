Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 11:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359822AbiFPLa6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 07:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiFPLa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 07:30:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C695E149
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 04:30:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7921F21AF0;
        Thu, 16 Jun 2022 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655379055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Srjmf9mFlFt9/e79iui0C3RK9U+vibMrAOQTL31NZns=;
        b=SNZzPBcoAg84zKXwOt16UXYI91SkxGKxCrRBaQpRM7UKtGVMdSVhAAF8KJH6vYInzj2vUY
        jPcVx9Vj3bwUvl6wf9WF/pko298lvbsct3u2LkVGKrG3Kz4PdXU6DdmVmBngsrPN8tsaVb
        LNfMP9w09YQUisCFSiYhJa8H/RPkHsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655379055;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Srjmf9mFlFt9/e79iui0C3RK9U+vibMrAOQTL31NZns=;
        b=1K/Yn8BD2+3L3UcWEPRZBYsmLd5Z+KnuHiHYMja10S24zsv0dWfZ6Tx9SwNYwOx2jIQhvn
        zpSHcRdfmhV3J/BA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 420DA2C141;
        Thu, 16 Jun 2022 11:30:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EFCE1A062E; Thu, 16 Jun 2022 13:30:54 +0200 (CEST)
Date:   Thu, 16 Jun 2022 13:30:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH blktests] check: ensure to suppress job status output
Message-ID: <20220616113054.krlxoz3v5fgobe35@quack3.lan>
References: <20220616041214.612087-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616041214.612087-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-06-22 13:12:14, Shin'ichiro Kawasaki wrote:
> Unexpected job status output by wait commands was observed on openSUSE
> 15.3 and it made some test cases fail. To avoid the job status output
> during test case runs, ensure to turn off job control monitor in sub-
> shell for test case runs.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/linux-block/20220613151721.18664-1-jack@suse.cz/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks! Feel free to add:

Tested-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  check | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/check b/check
> index 7037d88..a0c27d9 100755
> --- a/check
> +++ b/check
> @@ -440,6 +440,10 @@ _run_test() {
>  	RUN_FOR_ZONED=0
>  	FALLBACK_DEVICE=0
>  
> +	# Ensure job control monitor mode is off in the sub-shell for test case
> +	# runs to suppress job status output.
> +	set +m
> +
>  	# shellcheck disable=SC1090
>  	. "tests/${TEST_NAME}"
>  
> -- 
> 2.36.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
