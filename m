Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E655ECAAD8
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 18:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiIMSHY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiIMSHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 14:07:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C0923D6
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 10:10:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E03335C401;
        Tue, 13 Sep 2022 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663089049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YX06CRXyGnFkUITDLDjzNugFnS+QbIo6HKoDLgmz8v4=;
        b=sUQ4NJL97FV4yI9H5/SinUoak5RcSG6E/EZuuCs0vZxjiS64lAG3fl7EwqgdjkYNjnasI0
        SWrGxXaE0OqyZhG2GnEStIVX+6ja7pfVazB2fYQFNpq296LcKxqwmlq/xShwz36cue3Qqe
        7Cb1yLxM7RcZkEuBodbruwj8dZQGeZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663089049;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YX06CRXyGnFkUITDLDjzNugFnS+QbIo6HKoDLgmz8v4=;
        b=MIquIPHVVgfDw+2HhmAovbDV/LZIFIoXcH09aLg+wAGw+sTlPiWeEY0FY04mHes3U32DZG
        OM7RdNgWik/qb5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2FD713AB5;
        Tue, 13 Sep 2022 17:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4U15M5m5IGPDewAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 13 Sep 2022 17:10:49 +0000
Date:   Tue, 13 Sep 2022 19:10:49 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Message-ID: <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913114210.gceoxlpffhaekpk7@carbon.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 13, 2022 at 01:42:11PM +0200, Daniel Wagner wrote:
> On Tue, Sep 13, 2022 at 10:57:44AM +0000, Shinichiro Kawasaki wrote:
> > FYI, each blktests test case can define DMESG_FILTER not to fail with specific
> > keywords in dmesg. Test cases meta/011 and block/028 are reference use
> > cases.
> 
> Ah okay, let me look into it.

So I made the state read function a bit more robust (test if state file
exists) and the it turns out this made rdma happy(??) but tcp is still
breaking.

nvmf_wait_for_state() {
        local subsys_name="$1"
        local state="$2"
        local timeout="${3:-$def_state_timeout}"

        local nvmedev=$(_find_nvme_dev "${subsys_name}")
        local state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"

        local start_time=$(date +%s)
        local end_time

        while [ -f "${state_file}" ]; do
                if grep -q "${state}" "${state_file}"; then
                        break;
                fi

                end_time=$(date +%s)
                if (( end_time - start_time > timeout )); then
                        echo "expected state \"${state}\" not " \
                             "reached within ${timeout} seconds"
                        break
                fi
                sleep 1
        done

        [ -f "${state_file}" ] || echo "failed to read ${state_file}"
}


c740:~/blktests # nvme_trtype=tcp ./check nvme/046
nvme/046 (Test queue count changes on reconnect)             [passed]
    runtime  32.154s  ...  32.189s
c740:~/blktests # nvme_trtype=rdma ./check nvme/046
nvme/046 (Test queue count changes on reconnect)             [passed]
    runtime  32.189s  ...  23.488s
c740:~/blktests # nvme_trtype=fc ./check nvme/046
nvme/046 (Test queue count changes on reconnect)             [failed]
    runtime  23.488s  ...  2.918s
    --- tests/nvme/046.out      2022-09-09 16:23:22.926123227 +0200
    +++ /root/blktests/results/nodev/nvme/046.out.bad   2022-09-13 19:07:43.661118528 +0200
    @@ -1,3 +1,7 @@
     Running nvme/046
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +failed to read /sys/class/nvme-fabrics/ctl/nvme0/state
    +failed to read /sys/class/nvme-fabrics/ctl//state
    +failed to read /sys/class/nvme-fabrics/ctl//state
    +failed to read /sys/class/nvme-fabrics/ctl//state
    +NQN:blktests-subsystem-1 disconnected 0 controller(s)
    ...

