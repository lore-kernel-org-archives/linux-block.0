Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19678C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 11:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjERLxd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjERLxc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 07:53:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77B9EC
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 04:53:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 850B92246F;
        Thu, 18 May 2023 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684410805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UvUoZmXWOm01lb3OknH6FVaEQiNMr/3ebtGqSmceOsc=;
        b=xwusYAVtAtn33LD3ZklGIjgQjU5G9V9jGjyyJmhOaDwio4lAv0OQN3+NhXyZF6yZ31eem5
        FTrLxc5xCHUDkTDM2EY3txh30VYZPvijJI6q/eHetBqdivdzsQKueoTXx9c/nkUIxdvTwK
        9f/oPMN2FC+45PTSrb3F+I0oj5KGkqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684410805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UvUoZmXWOm01lb3OknH6FVaEQiNMr/3ebtGqSmceOsc=;
        b=fwesQHnaRKFMTkifRyaoG1z3D12aVpYsNG5Z1WJm0y64wqWWR2AodVQHzUWdBhFKrdJmug
        QXv7KIIez+OUFADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 745F7138F5;
        Thu, 18 May 2023 11:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zGUlHLURZmQiGAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 18 May 2023 11:53:25 +0000
Date:   Thu, 18 May 2023 13:53:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Message-ID: <5xaebvsrxe7gxh2y4425mme22kwpyu2ngnrjx2oqmvbegme6h2@nh5a3xxzcqn7>
References: <20230510070207.1501-1-yangx.jy@fujitsu.com>
 <9ac0b861-01a0-9dce-3d2c-5ff9e265c994@nvidia.com>
 <1f2061f8-de32-15cc-818b-56ca0024c5da@fujitsu.com>
 <14ca2b51-6ccf-d3f7-c61a-ad2e8c384448@nvidia.com>
 <cpnmpplrcos4mocwilkwqo4sxuoqw2mimb42p65b7pkn6e6yc6@wvxrnmd6b5cx>
 <ecrelgmx2fmya57dsc5i6jvwaybnjiw4olllfujkhhjz7wpnni@vtdrlloshkvi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecrelgmx2fmya57dsc5i6jvwaybnjiw4olllfujkhhjz7wpnni@vtdrlloshkvi>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18, 2023 at 04:13:51AM +0000, Shinichiro Kawasaki wrote:
> > I think a couple of those test might make sense to be migrated to the nvme
> > suite. I am thinking about the test with simulate_network_failure_loop.
> 
> It does not sound reasonable to keep dm-multipath tests in nvme group. I guess
> you mean to reuse the simulate_network_failure_loop not to test dm-multipath
> but to test nvme fabrics transports, right?

Correct. I think it would be good to carry over the network failure testing for
the fabrics transport test in the nvme group. I can look into this next week.
