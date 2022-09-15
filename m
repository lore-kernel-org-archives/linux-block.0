Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29F6ECAAD3
	for <linux-block@archiver.kernel.org>; Thu, 15 Sep 2022 11:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIOLdS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Sep 2022 07:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIOLdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2022 07:33:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9253AB02
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2022 04:33:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E689033835;
        Thu, 15 Sep 2022 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663241593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Doj1K3/bZA2+DWtI/Gb+Jvq6i/4kBiqqVu5pjUqLMQ=;
        b=lHKOLnwnAvk916/SBwJF1UEOmu3DsP51fxXPWzGabQak/VeYa6VW17OUj31wotS6CEMGve
        SF7U1OoQx4XhybbTsJtiUIOofqQvKuqfSlnuyebDQztSwY8aU8lPmHjqCWbe2AqyNTM61r
        FzZCRcfKJ7jr/hyAkmjDvtZBzNxgVgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663241593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Doj1K3/bZA2+DWtI/Gb+Jvq6i/4kBiqqVu5pjUqLMQ=;
        b=I6CI5RcnR75LMmwekc3gdxBPN+ER3Sxw1buYM4pd8GZKvni0iUOTpcMQKbyX1/wDrXzOls
        5wShaKSZdAi7XgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8C7313A49;
        Thu, 15 Sep 2022 11:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0KjSNHkNI2NNKwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 15 Sep 2022 11:33:13 +0000
Date:   Thu, 15 Sep 2022 13:33:13 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Message-ID: <20220915113313.26mpn3ytnhv4oout@carbon.lan>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
 <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
 <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
 <3b58b91d-e217-86a2-b2e4-3b0656bbe0e9@grimberg.me>
 <20220914110717.pvzm2666mklkg73a@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914110717.pvzm2666mklkg73a@carbon.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 14, 2022 at 01:07:18PM +0200, Daniel Wagner wrote:
> > > [399664.863585] nvmet: connect request for invalid subsystem blktests-subsystem-1!
> > > [399664.863704] nvme nvme0: Connect Invalid Data Parameter, subsysnqn "blktests-subsystem-1"
> > > [399664.863758] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16770)
> > > [399664.863784] nvme nvme0: NVME-FC{0}: reconnect failure
> > > [399664.863837] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> > > 
> > > When the host tries to reconnect to a non existing controller (the test
> > > called _remove_nvmet_subsystem_from_port()) the target returns 0x4182
> > > (NVME_SC_DNR|NVME_SC_READ_ONLY(?)).
> > 
> > That is not something that the target is supposed to be doing, I have no
> > idea why this is sent. Perhaps this is something specific to the fc
> > implementation?
> 
> Okay, I'll look into this.

I didn't realize that the 0x182 can be overloaded. In the case of fabric
commands it stands for NVME_SC_CONNECT_INVALID_PARAM. So all good here.
