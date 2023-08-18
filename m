Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6CFC678DC
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 08:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351547AbjHRIxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Aug 2023 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358781AbjHRIxV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2023 04:53:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1C30E6
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2023 01:53:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F2AA21875;
        Fri, 18 Aug 2023 08:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692348793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzcdXcvVdIdhkTV0Shlwle4xaHsekb83/IOSjUzWN0s=;
        b=rSVQKs89JKN2+4Aqlr300idCqAjq8f0LRUAIkPIlQX26kh6SAPualI2223kORO34xnJXga
        /qC2Zh0uxAZOmNB3Hs26Inal2KrhT5ea1OYCSYi5reGUfaXp0wMj5XCO81RWTRBAMlp04w
        mmjwc7rRHKgSiVZXcQuGEYYAE3nyXyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692348793;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzcdXcvVdIdhkTV0Shlwle4xaHsekb83/IOSjUzWN0s=;
        b=YUr04K2o+UhlLhDTs+iSZ6r3N/wxfaqTtBnJ2tyaSf9iR2p88PXmb5IZwWieiz4k3j43N5
        c2GvAgq6AQJZetCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5626813441;
        Fri, 18 Aug 2023 08:53:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /sj+FHkx32StFgAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 18 Aug 2023 08:53:13 +0000
Date:   Fri, 18 Aug 2023 10:53:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 1/2] nvme/rc: fix nvme device readiness check
 after _nvme_connect_subsys
Message-ID: <mgfm3zji6qpuohc2hxfhttu3dmrj74ytmx5wfkloj23le6zcg7@gorhk6oekqln>
References: <20230818044057.3794564-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818044057.3794564-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 18, 2023 at 01:40:56PM +0900, Shin'ichiro Kawasaki wrote:
> The helper function _nvme_connect_subsys() creates a nvme device. It may
> take some time after the function call until the device gets ready for
> I/O. So it is expected that the test cases call _find_nvme_dev() after
> _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
> the created device, and it also waits for uuid and wwid sysfs attributes
> of the created device get ready. This wait works as the wait for the
> device I/O readiness.
> 
> However, this wait by _find_nvme_dev() has two problems. The first
> problem is missing call of _find_nvme_dev(). The test case nvme/047
> calls _nvme_connect_subsys() twice, but _find_nvme_dev() is called only
> for the first _nvme_connect_subsys() call. This causes too early I/O to
> the device with tcp transport [1]. Fix this by moving the wait for the
> device readiness from _find_nvme_dev() to _nvme_connect_subsys(). Also
> add --no-wait option to _nvme_connect_subsys(). It allows to skip the
> wait in _nvmet_passthru_target_connect() which has its own wait for
> device readiness.
> 
> The second problem is wrong paths for the sysfs attributes. The paths
> do not include namespace index, so the check for the attributes always
> fail. Still _find_nvme_dev() does 1 second wait and allows the device
> get ready for I/O in most cases, but this is not intended behavior.
> Fix this by checking sysfs paths with the namespace index. Get list of
> namespace indices for the sub-system and do the check for all indices.
> 
> On top of the checks for sysfs attributes, add 'udevadm settle' and a
> check for the created device file. These ensures that the create device
> is ready for I/O.
> 
> [1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/
> 
> Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

just a minor nitpick but feel free to add:

Reviewed-by: Daniel Wagner <dwagner@suse.de>

> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 0b964e9..92eac06 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -428,6 +428,8 @@ _nvme_connect_subsys() {
>  	local keep_alive_tmo=""
>  	local reconnect_delay=""
>  	local ctrl_loss_tmo=""
> +	local no_wait=""

I suggest to use the default 'no_wait=false' here

> +	local i
>  
>  	while [[ $# -gt 0 ]]; do
>  		case $1 in
> @@ -483,6 +485,10 @@ _nvme_connect_subsys() {
>  				ctrl_loss_tmo="$2"
>  				shift 2
>  				;;
> +			--no-wait)
> +				no_wait=true
> +				shift 1
> +				;;
>  			*)
>  				positional_args+=("$1")
>  				shift
> @@ -532,6 +538,33 @@ _nvme_connect_subsys() {
>  	fi
>  
>  	nvme connect "${ARGS[@]}" 2> /dev/null
> +
> +	# Wait until device file and uuid/wwid sysfs attributes get ready for
> +	# all namespaces.
> +	if [[ -z ${no_wait} ]]; then

and do a

	if [[ "${no_wait}" = true ]] ; then

instead using a testing for an empty string.
