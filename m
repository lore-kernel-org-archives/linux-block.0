Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBAAC001B0
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 10:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjGMKav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 06:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjGMKau (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 06:30:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798AB2690;
        Thu, 13 Jul 2023 03:30:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 068F5221A1;
        Thu, 13 Jul 2023 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689244245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCNOq+j0xtZP84aUwE8KPQYvyz9rFaVzhnvfV5TLeaA=;
        b=HgYB5rCn+YeML2m46NPdO8yxP1U9ZIDQ4RkRlVb0+d/ZmT/Aus7qq6gjzZZziO5vbIn+Uc
        vQziGY14c3b9ymKmumlN4xDc5ogCnnF0Dyini+JqbLIK0XFCsJeJTHLHJJnunYaWgM5DyH
        yA8XtiRHUBcVCcIL7EpTO6qYN3QCgWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689244245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCNOq+j0xtZP84aUwE8KPQYvyz9rFaVzhnvfV5TLeaA=;
        b=Zz8NDhbPPYSsg9eQS4S1kg/xGLTRIz1YaYuri8h1eWslxe5FMVJgNppF1XWh7kX+vpFSrl
        YyHs+IGLezxUyODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC473133D6;
        Thu, 13 Jul 2023 10:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jv2dOVTSr2T0bAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 13 Jul 2023 10:30:44 +0000
Date:   Thu, 13 Jul 2023 12:30:44 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <mf3lgyy6qivmeb5ut7jk3qllyzz7hdrmqstz5phxseygj3oc34@sdf3ilsivmbb>
References: <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
 <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
 <972a06e0-6841-043e-fc00-db7596f664c4@nvidia.com>
 <cskolyrp3s47gnn4nwtqpfxtafzhpirn3hv7ovhnnzpbb3ll2z@oum3v3n7go6l>
 <6dced1ba-c468-c88e-f861-9c202e803894@nvidia.com>
 <eadl5bkyysdcymgy7ra4hm6cqn6ngcxbyvz2qzg3fdffsssnpo@d3rzegyurzn5>
 <6fa5ec73-e6c6-cf8e-b11f-1a57f0fc34b4@nvidia.com>
 <95210a8a-c70e-c312-2c47-4f5ee9329586@suse.de>
 <bd7c91c4-9528-aaeb-9789-03191dc7761b@nvidia.com>
 <875b1903-bca8-8c6e-79d7-506313bbd56d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875b1903-bca8-8c6e-79d7-506313bbd56d@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 13, 2023 at 12:14:14PM +0200, Hannes Reinecke wrote:
> > Exposing the subsystem is from the target configuration side.
> > Additionally, the --context (which is in the initiator/host side),
> > according to Daniel, is there to distinguish between different
> > invocations. I proposed that blktests subsystem will not be part of
> > discoverable fabric or protected somehow by access list. Therefore, no
> > additional invocation will happen.

I am confused. This is exactly what the whole --context thing is.

> Hmm. Maybe we can tweak blktest to use it's own HostNQN, and always pass
> that for any nvme-cli call.

This is what the current code already does.
