Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C1DC7EE23
	for <linux-block@archiver.kernel.org>; Thu,  1 Jun 2023 09:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjFAJCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jun 2023 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjFAJCj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 05:02:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05610DA;
        Thu,  1 Jun 2023 02:02:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B912E211E1;
        Thu,  1 Jun 2023 09:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685610111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nfHFD1czxWDo3IknBcYnlZ2RKGFFHnaXgjk0J13dzyA=;
        b=ydMq/2EHcpu1aiu3QY5P2mv0IDlbFWGQ9FZV3c/uAY0yKMC7kaOQFwvkm+9AMUh3keexj7
        YR8aMO2V5LwKJIqC1Bz9A8s5HQrh6vT4+F5DimdRXbalo9rdapOMRGhqcYO2V8/KVu8WtA
        81FZkuPnMrmQQzXdYWgetVDQ6u19Opg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685610111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nfHFD1czxWDo3IknBcYnlZ2RKGFFHnaXgjk0J13dzyA=;
        b=q9J2uc9lj7ESETEzqmDvVmIApzLUqodnRp9iwoWHIgfx0MCzugX+Tjv498XGxNJQzetKN0
        eLiYXsVfKooyhuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A90EB13441;
        Thu,  1 Jun 2023 09:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6RE3KX9eeGQ5GAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 01 Jun 2023 09:01:51 +0000
Date:   Thu, 1 Jun 2023 11:01:51 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 0/2] nvme_trtype=fc fixes
Message-ID: <ydocewz6ls4bjow726voiqlk3hi3nziss7ppmao6a7c5v4yv6s@t24bkmsjcm6a>
References: <20230503083816.18792-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503083816.18792-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These patches are necessary to get to get the FC transport off the ground. At
least with those applied, blktests should be in shape and only the kernel part
needs to be addressed from then one.
