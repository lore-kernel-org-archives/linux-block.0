Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E262CA0EC8
	for <linux-block@archiver.kernel.org>; Mon, 11 Sep 2023 22:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350845AbjIKVls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbjIKMQN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Sep 2023 08:16:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5AE125
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 05:16:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A45941F8A6;
        Mon, 11 Sep 2023 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694434563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5rMGM6Sk7+ypNL4iTYsBOZWgsFDohdDhMTFVQxzcWo=;
        b=0u04b+E7qACQFXxagzsblEUC5xk9SywAyco4Ksj2NE/5Q0ldsd0PbsYIDc1sNb0VrcGVoU
        NIOj3ZP8hBWkuKMoP6kgby+x1cfZ/yBde1EOu4WAqROKlAFqqySG7l/rmpxEqQf8iDh7t2
        iYq2ZiRp7BtcAG628qSsHC2BnDVRcYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694434563;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5rMGM6Sk7+ypNL4iTYsBOZWgsFDohdDhMTFVQxzcWo=;
        b=BADAqw6WcfCczVQWIpygYROfPRjvG2dh0eMuRWGX8zFJDpalsIzlPy1bSwA8XGV5Jpp83N
        /a8jjsZopubXxmAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97606139CC;
        Mon, 11 Sep 2023 12:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rp/hJAMF/2SABAAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 11 Sep 2023 12:16:03 +0000
Date:   Mon, 11 Sep 2023 14:16:39 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] tests/nvme/031: fix connecting faiure
Message-ID: <ndeue7dj4w4w26tndeya2imsct3s4c2ay2a7zpylfvahizn44t@taagv26xb3ha>
References: <20230907034423.3928010-1-yi.zhang@redhat.com>
 <nrfuja62qetxqxzwxuxhjve2u4r4reofcpo43zmg6qbbhjjqkp@ratsu2kubymb>
 <kflpcc7u4wksuuo27gcrjxwsqr277b3phpnbbbjkdaniycmttn@f6t4dadmvqih>
 <swd5rjag3soiz5b6fkktk5vncfjtb4wemrbtl4fwkpcx6uodg7@5wnw5gf6luz6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <swd5rjag3soiz5b6fkktk5vncfjtb4wemrbtl4fwkpcx6uodg7@5wnw5gf6luz6>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 11, 2023 at 11:00:17AM +0000, Shinichiro Kawasaki wrote:
> > nvmf_wait_for_state "${def_subsysnqn}" "live"
> > nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> > 
> > We could make this a bit more generic and move it into the connect
> > helper. What do you think?
> 
> This nvme state file check looks a bit complicated, but looks more robust than
> "nvme connect" command exit status check. Do you think that "nvme connect" can
> fail even when "nvme connect" command returns good status? If so, your approach
> will be the way to choose.

Currently, 'nvme connect' is a synchronous call for tcp/rdma but not for
fc. 'nvme connect' for tcp/rdma will report an error if something is
wrong but not for fc, because it always return successfully.

The nvme/005 is exposing the behavior differences between the
transports. My long time goal is to address and make all transport
behave the same way (unification of the state machines). But as it
currently stands fc would need someting like this to make sure we are
not blindly reporting success just because the 'nvme connect' call is
successful.

This type of check would make the test suite more robust and better in
detecting errors.
