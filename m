Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F45EC77B78
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 13:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjECNz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjECNz4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 09:55:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2759F7
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 06:55:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49F8C2288A;
        Wed,  3 May 2023 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683122151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOkGMScXr2xzxYGwl2ZKfzUeL4mY6lt5XJozlj4l+6U=;
        b=RPY7b2OI8mjErUTc/mf87ltSwMViQzLcbweR99mxJoFI3WsAwdJpxs6HfCaplV/jrOEWGP
        fzoGq0Fl7riZyBoYk3wolFzo8duuBddHOwCDD6vc6vEvrIx5aaTjsP8S/R5CNYwX+HZiVP
        pSpaB7R3KS5OJH5O9vZcTFKgj3q31gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683122151;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOkGMScXr2xzxYGwl2ZKfzUeL4mY6lt5XJozlj4l+6U=;
        b=bOrJMHG+Ja2eoo1NcgvLDDo/IcPUgKwhZQPjqwS05gdwCAJsCZ7j1blVogUKEOBcCuhVC/
        5zmWwzvXTqyIZtBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C0B613584;
        Wed,  3 May 2023 13:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bkuVDudnUmQHMQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 13:55:51 +0000
Date:   Wed, 3 May 2023 15:55:50 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] nvme state machine refactoring
Message-ID: <m7icoy7ggamihsjscurhwcqc6skjhrlrdggx3lm2frxue6obnv@zeitny5i752u>
References: <dkxas4hwmnzknde7csbnuxwtk6odsaptj34hj7ukz4kh54h45n@6aiz7ghuf7ej>
 <9adc17de-5159-94bd-abd5-e52a09e9e3d3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9adc17de-5159-94bd-abd5-e52a09e9e3d3@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 27, 2023 at 08:42:34AM +0000, Chaitanya Kulkarni wrote:
> good idea, in order to make the discussion more interesting and productive.
> Could you please share the latest code LSFMM so that everyone can go through
> it?

Sure, I'll update the series
