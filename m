Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE05C0015E
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 06:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjHKGhw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 02:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHKGhv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 02:37:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A33B1FED
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 23:37:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B199721869;
        Fri, 11 Aug 2023 06:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691735869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0A8UAjA7z0859o8kT7A+xiG+ORtaoIVwpOUwy/0oJE=;
        b=uWz5ujjRQGfG3Fw1Qya1VpG9iKvDUNpNZNzbP4lhsVhOZkYUDvykpZAdOWvn0BBahFIjTf
        KStz1yzd9bv5u7gj/MDNm607EGuIIYhfFpv3Y/K7RlUIL4Q2MZP+ZCYO5kq6edYmueRloa
        BEYF+foM8d+yj0oEXSuDvsquhQAROVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691735869;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0A8UAjA7z0859o8kT7A+xiG+ORtaoIVwpOUwy/0oJE=;
        b=YoP7F0V7G1QIu/2cDmXC58voz7PLCflVEtnw/kg+dzAk0Ay/SE0Oc0Ek/ONZ2N07rNNSEA
        oZ98WE7jsMe7/OBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E4EC13592;
        Fri, 11 Aug 2023 06:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AElEJT3X1WRcUgAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 06:37:49 +0000
Date:   Fri, 11 Aug 2023 08:37:52 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Message-ID: <6x55ggt7k2kjgd6lr6ykubwmo2qfilz3k32ywfuun2zhat2p5v@7aohs7kgb23x>
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 11, 2023 at 10:23:34AM +0900, Shin'ichiro Kawasaki wrote:
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -425,6 +425,7 @@ _nvme_connect_subsys() {
>  	local keep_alive_tmo=""
>  	local reconnect_delay=""
>  	local ctrl_loss_tmo=""
> +	local dev i
>  
>  	while [[ $# -gt 0 ]]; do
>  		case $1 in
> @@ -529,6 +530,16 @@ _nvme_connect_subsys() {
>  	fi
>  
>  	nvme connect "${ARGS[@]}" 2> /dev/null
> +
> +	dev=$(_find_nvme_dev "$subsysnqn")
> +	for ((i = 0; i < 10; i++)); do
> +		if [[ -b /dev/${dev}n1 &&
> +			      -e /sys/block/${dev}n1/uuid &&
> +			      -e /sys/block/${dev}n1/wwid ]]; then
> +			return
> +		fi
> +		sleep .1
> +	done
>  }

Not sure if this going to work for the passthru case as intended. If you
look at the _find_nvme_passthru_loop_dev() function, there is a logic to
figure out which namespace to use. _nvmet_passthru_target_connect()
is also using _nvme_connect_subsys() so it is possible that the
test device for the passthru case uses not namespace 1.

If namespace 1 doesn't exist we just loop for 1 second. So in this
particular case nothing changes. Still not nice.

Thinking about it, shouldn't we log that we couldn't find the
device/uuid/wwid at the end of the loop?
