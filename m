Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C4C001DE
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 09:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjHJJUh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjHJJUZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 05:20:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC955AF
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 02:18:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F1EF1F749;
        Thu, 10 Aug 2023 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691659088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dj/3hiHNvgy84wGzyP6ros8JwJPIhLDARNnNreLN2PM=;
        b=QPw6JNrH/pKSGpx3LnXjM0mQesM+zq9YEFJs/YQwXLfW8w6okEW3jQX9O9aXVbJpRvd0TU
        pc3sCdRGsgfvR8r5pBnt1dOZdxms04k1kTx/3qyjEcSeUIjlY1O0U1R8BGM8WxXWI4y6QU
        ynkvBZEhHCldoIAFrrNVk0CXi5jauyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691659088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dj/3hiHNvgy84wGzyP6ros8JwJPIhLDARNnNreLN2PM=;
        b=foBJ2yxslq2CWH0awapgv4EzeEgtLFLUwyGnyBvDtcwZAKCfecHARxRReh6Xo6fJ/fL1XC
        zhejFe+BeD6ZekCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ECD5138E0;
        Thu, 10 Aug 2023 09:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GiORA1Cr1GSgewAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 09:18:08 +0000
Date:   Thu, 10 Aug 2023 11:18:10 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Message-ID: <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
 <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
 <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 12:19:39AM +0000, Shinichiro Kawasaki wrote:
> Yi, could you try and see if it avoids the failure?
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 4f3a994..005db80 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -740,7 +740,7 @@ _find_nvme_dev() {
>  		if [[ "$subsysnqn" == "$subsys" ]]; then
>  			echo "$dev"
>  			for ((i = 0; i < 10; i++)); do
> -				if [[ -e /sys/block/$dev/uuid &&
> +				if [[ -e /dev/$dev && -e /sys/block/$dev/uuid &&
>  					-e /sys/block/$dev/wwid ]]; then
>  					return
>  				fi

The path for uuid is not correct. It's needs to be something like

	if [[ -e /dev/$dev && -e /sys/block/"${dev}n1"/uuid &&
		-e /sys/block/"${dev}n1"/wwid ]]; then
			return
	fi
