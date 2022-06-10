Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAFFCCA47E
	for <linux-block@archiver.kernel.org>; Fri, 10 Jun 2022 08:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348147AbiFJIqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jun 2022 04:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348229AbiFJIqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jun 2022 04:46:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC667205E3;
        Fri, 10 Jun 2022 01:46:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2351621FD4;
        Fri, 10 Jun 2022 08:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654850761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ggKEnI6cVqPW68aMINv0KESIBxxtyHQnG9dFax/521w=;
        b=q6nQ9Cb8BFbi50uUd2y+55kL5K66OPSrgWczmbg5kszbZJF6ZLL8h5UDPy9yEPGxUy2KPg
        e01hyomD/hFh8kOuwQmIAUle28Q3WluqYbG7IAT5nK3mZ04ixQJxp+e3B3QzVe9Gi7Ad2W
        Dk5e2aiOaQJ6RPSUNM/MssdU120znmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654850761;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ggKEnI6cVqPW68aMINv0KESIBxxtyHQnG9dFax/521w=;
        b=MAbi+7nKDKt3zgUoi2CKfv1T/a/MeCpuYw39jK9kxM7wzTOdSgZ61MwRUeHSg0C8N9BRDS
        gPW0ahFmAiUh6sBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2EF7139ED;
        Fri, 10 Jun 2022 08:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id byiiJMgEo2JfUAAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 10 Jun 2022 08:46:00 +0000
Date:   Fri, 10 Jun 2022 10:45:58 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-iocost: remove the second superfluous
 current_hweight
Message-ID: <YqMExo7u9N4sVnyM@suselix>
References: <20220609073450.98975-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220609073450.98975-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 09, 2022 at 03:34:49PM +0800, Chengming Zhou wrote:
> The commit ac33e91e2dac ("blk-iocost: implement vtime loss compensation")
> add the second current_hweight() in the loop of active iocgs list to
> get old_hwi to calculate the vtime loss of the iocg.
> 
> Since the hwi can't change and the first current_hweight already get
> hwa and hwi, so this second superfluous current_hweight() can be
> removed. There should be no functional changes.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

FWIW. Looks ok.
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
