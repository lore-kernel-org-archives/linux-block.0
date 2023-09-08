Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E94EE7FE3
	for <linux-block@archiver.kernel.org>; Fri,  8 Sep 2023 13:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjIHNJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Sep 2023 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIHNJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2023 09:09:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDFA19B5
        for <linux-block@vger.kernel.org>; Fri,  8 Sep 2023 06:09:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22C031FE73;
        Fri,  8 Sep 2023 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694178548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9BLOYjsYJqUx9nrHtpBBQiYT70sZn4WcNJoSM/TJQ0=;
        b=cl/5RV47qHJqhgURPl+ftiyDw7IMTs87evo9niO+P8C14tz9886pVLBkRbWU038c5FCCQf
        fNQDGFzqOuziq5zlj6NGW3Az2n11km6b+fMKS0jrhvGio/ShU8TxaZDrsLZBUoIxOgr1g4
        SRvwPyptwnZsZzGiptNyby1E+FMAwIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694178548;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9BLOYjsYJqUx9nrHtpBBQiYT70sZn4WcNJoSM/TJQ0=;
        b=AGLKHdVbc7sj874pc3T6ifMbk0caAkY7fgWSqae8RZouxPMLgb+IiNBX3w9GuXIR7YRRDk
        ZvFJem3IFIxUh/Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 158F3131FD;
        Fri,  8 Sep 2023 13:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gw02BfQc+2S2TwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 08 Sep 2023 13:09:08 +0000
Date:   Fri, 8 Sep 2023 15:09:39 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] tests/nvme/031: fix connecting faiure
Message-ID: <kflpcc7u4wksuuo27gcrjxwsqr277b3phpnbbbjkdaniycmttn@f6t4dadmvqih>
References: <20230907034423.3928010-1-yi.zhang@redhat.com>
 <nrfuja62qetxqxzwxuxhjve2u4r4reofcpo43zmg6qbbhjjqkp@ratsu2kubymb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nrfuja62qetxqxzwxuxhjve2u4r4reofcpo43zmg6qbbhjjqkp@ratsu2kubymb>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 08, 2023 at 11:26:31AM +0000, Shinichiro Kawasaki wrote:
> On Sep 07, 2023 / 11:44, Yi Zhang wrote:
> > allow_any_host was disabled during _create_nvmet_subsystem, call
> > _create_nvmet_host before connecting to allow the host to connect.
> >
> > [76096.420586] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
> > [76096.440595] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > [76096.491344] nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 for subsystem blktests-subsystem-0 not allowed
> > [76096.505049] nvme nvme2: Connect for subsystem blktests-subsystem-0 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > [76096.519609] nvme nvme2: failed to connect queue: 0 ret=16772
> >
> > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

> Thanks for the catching this. I looked back the past changes and found that the
> commit c32b233b7dd6 ("nvme/rc: Add helper for adding/removing to allow list")
> triggered the connection failure. So, I think a Fixes tag with this commit is
> required (I can add when this patch is applied).
>
> Even after the commit, the test case still passes. That's why I did not notice
> the connection failure. I think _nvme_connect_subsys() should check exit status
> of "nvme connect" command and print an error message on failure. This will help
> to catch similar connection failures in future.

I was running into a similiar problem for (not yet existing) nvme/050
test case [1]:

nvmf_wait_for_state() {
       local def_state_timeout=5
       local subsys_name="$1"
       local state="$2"
       local timeout="${3:-$def_state_timeout}"
       local nvmedev
       local state_file
       local start_time
       local end_time

       nvmedev=$(_find_nvme_dev "${subsys_name}")
       state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"

       start_time=$(date +%s)
       while ! grep -q "${state}" "${state_file}"; do
               sleep 1
               end_time=$(date +%s)
               if (( end_time - start_time > timeout )); then
                       echo "expected state \"${state}\" not " \
                               "reached within ${timeout} seconds"
                       return 1
               fi
       done

       return 0
}

_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
                            --hostnqn "${def_hostnqn}" \
                            --reconnect-delay 1 \
                            --ctrl-loss-tmo 10

nvmf_wait_for_state "${def_subsysnqn}" "live"
nvmedev=$(_find_nvme_dev "${def_subsysnqn}")

We could make this a bit more generic and move it into the connect
helper. What do you think?

[1] https://lore.kernel.org/linux-nvme/20230621155825.20146-2-dwagner@suse.de/
