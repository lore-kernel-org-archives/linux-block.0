Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFDCD98F8
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 07:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJKH50 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 03:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJKH5Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 03:57:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E95A91
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 00:57:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 183BE1FDC4;
        Wed, 11 Oct 2023 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697011042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xLRDx1tjTgIwojkOuLXJUqIianl+gu9PD/FZZwRNTKI=;
        b=ehp8ghc9uFz8za3vOU1k4hj1h/GGowcvQn+jZOd577tAzef2Fw1wjsAJMfOd4/vDh9B/LJ
        Ti69CUIJ583gW5kVbTMQb+t02czUEGguHfyeWjc3gerjiYl/QNAnm7RBzXvgEOg1XZhp57
        MT/EziiB+lImhfo+8WMPoN3n5j+elAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697011042;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xLRDx1tjTgIwojkOuLXJUqIianl+gu9PD/FZZwRNTKI=;
        b=TGGd0lBQJDdSSTXn0R8WUwIOSxUaJtx5OCk+CYo5ItwUP3/ocyKWpipY+tmv6rGfmNX8fD
        aS7xrjMS18QstsDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B92A138EF;
        Wed, 11 Oct 2023 07:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Df/JAmJVJmWRDwAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 11 Oct 2023 07:57:22 +0000
Date:   Wed, 11 Oct 2023 09:58:33 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests V2] check: define TMPDIR earlier in _run_group
Message-ID: <32utqb6baqrfphxoqczb66htxatocmq36yuwmkzib43g7jvjol@3uo7bvraemyl>
References: <20231011072530.1659810-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011072530.1659810-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 11, 2023 at 03:25:30PM +0800, Yi Zhang wrote:
 @@ -559,6 +556,10 @@ _run_group() {
>  	local tests=("$@")
>  	local group="${tests["0"]%/*}"
>  
> +	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
> +		return
> +	fi
> +
>  	# shellcheck disable=SC1090
>  	. "tests/${group}/rc"

Sorry, I didn't catch this earlier. TMPDIR is newly created for every
single test run and gets removed afterwards, see the _cleanup function.

I think we should keep this behavior. So the question is if we could
make the $def_file_path evaluation just lazy. So something like:

modified   tests/nvme/rc
@@ -18,12 +18,15 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-export def_file_path="${TMPDIR}/img"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}

 _nvme_requires() {
+	# lazy evaluation because TMPDIR is per test run and not
+	# per test group
+	def_file_path="${TMPDIR}/img"
+
 	_have_program nvme
 	_require_nvme_test_img_size 4m
 	case ${nvme_trtype} in
