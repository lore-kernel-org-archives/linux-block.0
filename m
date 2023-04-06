Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B73C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 08:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjDFIhg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjDFIhf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 04:37:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89321A1
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 01:37:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47CAA1FD90;
        Thu,  6 Apr 2023 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680770253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsg1dyrlBthwxSnhm3PHglz+LBV9NS/qe4M2IkHmNKM=;
        b=QvU7FngFkubiq0bRvIVkXPAsFE0KY11jgV5uissOlfIJCcIRVmpGzZx5l24BCwuA1LQRjo
        Kz8Usj/T3Sr+3lvxeQS4uc6uSahzpq/alWDpcv/OAVn4jYQIBOZwlxlL0eF9cCbqtmHd3j
        6I8LgweANumU9bqOOKbeIji9MFebMAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680770253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsg1dyrlBthwxSnhm3PHglz+LBV9NS/qe4M2IkHmNKM=;
        b=c560stvTNE1FxQ1RVJaQHHTCj+BgcKpf9O0RxjRR3kFX9WGjjl+IcPXMv/czZAT7Eo7GaR
        FBH5zKzv8QOpNqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ABE0133E5;
        Thu,  6 Apr 2023 08:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sR1TDs2ELmTMaAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 08:37:33 +0000
Date:   Thu, 6 Apr 2023 10:37:32 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v6 2/2] nvme/048: test queue count changes on
 reconnect
Message-ID: <u34skcorm2t3mzwplerudnja6ruvpbooqufjmrsulvwqqirkwo@li3lv5gq5cej>
References: <20230406083050.19246-1-dwagner@suse.de>
 <20230406083050.19246-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406083050.19246-3-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 10:30:50AM +0200, Daniel Wagner wrote:
> +test() {
> +	local subsys_name="blktests-subsystem-1"
> +	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
> +	local file_path="${TMPDIR}/img"
> +	local skipped=false
> +	local hostnqn
> +	local hostid
> +	local port
> +
> +	echo "Running ${TEST_NAME}"

I think I missing a _nvmet_setup call here.
