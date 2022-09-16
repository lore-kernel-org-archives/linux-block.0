Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B16ECAAD8
	for <linux-block@archiver.kernel.org>; Fri, 16 Sep 2022 06:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiIPGaK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Sep 2022 02:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIPGaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2022 02:30:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D3133A31
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2022 23:30:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 652E1338C3;
        Fri, 16 Sep 2022 06:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663309804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2fX3PuJ3mKrpXZ1Ba+gT20JOe7i9oPxZrSejyfo0MI=;
        b=kWhaTzmDjV5JdP+jqzspfFE6YX72/LoNC6m08iHubqF0HkZO7Gr9gp15qh/ebgYk/Jj0sR
        cXegi0ucgbSpYPyS+DfkHNUTwOEtTWmEqXc5K5vun//z8yw9f2Ejo9p+xt+SiCwUJe643j
        2aXGbchI+GOC9AhjI5p7H5LrQAGGvnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663309804;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2fX3PuJ3mKrpXZ1Ba+gT20JOe7i9oPxZrSejyfo0MI=;
        b=OkDm4lgfEEl9V23C/BI1Iu7fOcOX1xS8TCBF8brIv/7bh+iGT9hxbE+wFGNq7HLxLK8BFv
        yGHVUohSlHzu8rAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5719D1346B;
        Fri, 16 Sep 2022 06:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KIY6FewXJGMhFQAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 16 Sep 2022 06:30:04 +0000
Date:   Fri, 16 Sep 2022 08:30:03 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Message-ID: <20220916062027.umsj6rqp6flgic3k@carbon.lan>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
 <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
 <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
 <3b58b91d-e217-86a2-b2e4-3b0656bbe0e9@grimberg.me>
 <20220914110717.pvzm2666mklkg73a@carbon.lan>
 <20220915125037.fqhcokdn4scnklyq@carbon.lan>
 <381b003e-3510-8cbf-031d-b5314b17560d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381b003e-3510-8cbf-031d-b5314b17560d@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 15, 2022 at 05:41:46PM +0200, Hannes Reinecke wrote:
> > It looks like the reasoning here didn't take into consideration the
> > scenario we have here. I'd say we should not do it and handle it similar
> > as with have with tcp/rdma.
> > 
> But that is wrong.
> When we are evaluating the NVMe status we _need_ to check the DNR bit;
> that's precisely what it's for.

I asked what the desired behavior is and Sagi pointed out:

> DNR means do not retry the command, it says nothing about do not attempt
> a future reconnect...

I really don't care too much, it just that fc and tcp/rdma do not behave
the same in this regard which makes this test trip over. As long you two
can agree on a the 'correct' behavior, I can do the work.

> The real reason here is a queue inversion with fcloop; we've had them for
> ages, and I'm not surprised that it pops off now.

Could you elaborate?

> In fact, I was quite surprised that I didn't hit it when updating blktests;
> in previous versions I had to insert an explicit 'sleep 2' before disconnect
> to make it work.
> 
> I'd rather fix that than reverting FC to the (wrong) behaviour.

Sure, no problem with this approach.
