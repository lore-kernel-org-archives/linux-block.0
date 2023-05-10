Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D8CC7EE22
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjEJQfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbjEJQfk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 12:35:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76278A7D
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 09:35:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D66721880;
        Wed, 10 May 2023 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683736528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DhBu6g76QnmGqBUmh2ZHMKFNbeqyPQPo2InP7zXoVuM=;
        b=LOsOAP7vn9S8nVqdNyABY3ZP8MGfpbLAxeLfMjqUeIrh9IZk50VHd/YFnoMJ497AIWJcua
        F1oXjWnz0ws6gHh98DXUSrZjVf2Y0B6xUGLvA2bZnBTerH8Bs4wBUNtfIiEUDgpdLB64HS
        pCGI+qh9ujCJvTUueL9c8TcXIO4QCh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683736528;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DhBu6g76QnmGqBUmh2ZHMKFNbeqyPQPo2InP7zXoVuM=;
        b=YceLkpaqlujt+A8eHfEX0XywwaapyNkm2XsmukydcwZGNiRQ2imumcrZwuf9P5FBVWFBb5
        sIGDP7AgBTE5yLBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FDB1138E5;
        Wed, 10 May 2023 16:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OkWrGs/HW2RjdAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 10 May 2023 16:35:27 +0000
Date:   Wed, 10 May 2023 18:35:25 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Message-ID: <cpnmpplrcos4mocwilkwqo4sxuoqw2mimb42p65b7pkn6e6yc6@wvxrnmd6b5cx>
References: <20230510070207.1501-1-yangx.jy@fujitsu.com>
 <9ac0b861-01a0-9dce-3d2c-5ff9e265c994@nvidia.com>
 <1f2061f8-de32-15cc-818b-56ca0024c5da@fujitsu.com>
 <14ca2b51-6ccf-d3f7-c61a-ad2e8c384448@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ca2b51-6ccf-d3f7-c61a-ad2e8c384448@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 10, 2023 at 08:00:12AM +0000, Chaitanya Kulkarni wrote:
> On 5/10/23 00:55, Xiao Yang (Fujitsu) wrote:
> > On 2023/5/10 15:35, Chaitanya Kulkarni wrote:
> >> we might remove nvmeof-mp, so not sure if that part is
> >> needed, let's wait for others to reply ..
> > Hi CK,
> >
> > Thanks for your feedback.
> > Could you tell me why nvmeof-mp will be removed? Is there any URL about
> > the decision?
> >
> > Best Regards,
> > Xiao Yang
> 
> We talked about this in the LSFMM, I hope to see lwn article covering
> blktests session ..

I think a couple of those test might make sense to be migrated to the nvme
suite. I am thinking about the test with simulate_network_failure_loop.
