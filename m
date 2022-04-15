Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9120DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 01:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiDOBMT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 21:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348362AbiDOBMR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 21:12:17 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2747D3B550
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 18:09:50 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3F01A6C1504;
        Fri, 15 Apr 2022 01:09:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8EFCE6C0C02;
        Fri, 15 Apr 2022 01:09:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649984989; a=rsa-sha256;
        cv=none;
        b=luGsKPMKMzwoZaCehgAtQDKXHtLwI/Bb+IQrwoEOtbCCWFGlsSC384//89DMk1Di1w/ktl
        6pnoE9ni4QJ64CYEUY7LU1ceAbnw/awe9dQksZuFBENWPbIRjl/gIuNKuA0dv8qf4awMvE
        phXc2+tVdtKhMFyXyR/Zj13rPRrCKMoazfYEc0oPJgsWPT1rAlsBUK24xBKtX3ecUpOmT3
        BImaupRDqDL1CriNK3SNhF5jcF7CrL+Y9p7hrhrK+LsM7RvnHPDyStnDoUk0cwN06JBFLc
        6aJ306dq0SGD/f7L4qW79KVY3gtob3b5Mw5vLB5GIsnHMyA68PjXAa2kYp4MjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649984989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=1qz53KrRMkB/ZM+kzLvy6ZodR3AQ4fKs9G5gZAUuH0A=;
        b=idifjoJJrkNK8WVHYyeM9AEMuH9nMPtNjaZmYUzyeeorrBqzc28QuXoJLvjhd2ILJNkG9C
        mg6MHl6kSm2Gn3f8s5BqXG66C1+st9OqCwRYvT+1ipgUkRo/YbbGS+PG2y3V2qmkySyv6F
        zv/iL5kMZ6zq5QBDt/fCSdh6KIQ1D9tJtSh9iHDCHGegKitiiIDcGkSNS+079bxi6X4yoI
        ANPlY3HPuEsEMwINshXtKo+PEI0WpGImy4kVuNCft/gb0q0TMmZpZlXcv47uRibJYA/a+v
        n25faLsXTxbNbBkGG/WjZPDTIUgYcSULsls16vYyllrMcbcdVnIb21Oo4C0VdA==
ARC-Authentication-Results: i=1;
        rspamd-5f678fb567-kjczk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.130 (trex/6.7.1);
        Fri, 15 Apr 2022 01:09:50 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Share: 01e8484824ac3d66_1649984989900_3690627288
X-MC-Loop-Signature: 1649984989900:2156853323
X-MC-Ingress-Time: 1649984989899
Received: from offworld (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KfdXX5lD1z1Mx;
        Thu, 14 Apr 2022 18:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649984989;
        bh=1qz53KrRMkB/ZM+kzLvy6ZodR3AQ4fKs9G5gZAUuH0A=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=O0+czJqmRR1GmwHVbk8DOZuXFi/0/9x4iIDnaiGBcrCRK3+rC3Z7EnknuZhHhnzxH
         8crK0Mn/X6XbbA7wlTnHy2XF0HZtKDBQboX8epE2Stqh74LtHpsp0wZjzifSwp5eGT
         stXF8eYZDzirf8+URNQwsprcw35oXm8rYXdhojQugAF5NaoZrVl3D5PmajL0Cs73uc
         NGMqSlZ4HH/JVPF+TkGCGyFLsF8l9FJ3Rb7Gf8SEmzLFafY6jAYEIcXAF57F4IDI0E
         LjuIemgJ50C7mKzwhTPah/RrpdPLe+iz8JxpkoJz9TMgdUzEBfm929NKJro0XEqLL2
         xGBFocPyId6kg==
Date:   Thu, 14 Apr 2022 18:09:45 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     shinichiro.kawasaki@wdc.com, Klaus Jensen <its@irrelevant.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <20220415010945.wvyztmss7rfqnlog@offworld>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Apr 2022, Luis Chamberlain wrote:

>Hey folks,
>
>While enhancing kdevops [0] to embrace automation of testing with
>blktests for ZNS I ended up spotting a possible false positive RCU stall
>when running zbd/006 after zbd/005. The curious thing though is that
>this possible RCU stall is only possible when using the qemu
>ZNS drive, not when using nbd. In so far as kdevops is concerned
>it creates ZNS drives for you when you enable the config option
>CONFIG_QEMU_ENABLE_NVME_ZNS=y. So picking any of the ZNS drives
>suffices. When configuring blktests you can just enable the zbd
>guest, so only a pair of guests are reated the zbd guest and the
>respective development guest, zbd-dev guest. When using
>CONFIG_KDEVOPS_HOSTS_PREFIX="linux517" this means you end up with
>just two guests:
>
>  * linux517-blktests-zbd
>  * linux517-blktests-zbd-dev
>
>The RCU stall can be triggered easily as follows:
>
>make menuconfig # make sure to enable CONFIG_QEMU_ENABLE_NVME_ZNS=y and blktests
>make
>make bringup # bring up guests
>make linux # build and boot into v5.17-rc7
>make blktests # build and install blktests
>
>Now let's ssh to the guest while leaving a console attached
>with `sudo virsh vagrant_linux517-blktests-zbd` in a window:
>
>ssh linux517-blktests-zbd
>sudo su -
>cd /usr/local/blktests
>export TEST_DEVS=/dev/nvme9n1
>i=0; while true; do ./check zbd/005 zbd/006; if [[ $? -ne 0 ]]; then echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=$i+1; done;
>
>The above should never fail, but you should eventually see an RCU
>stall candidate on the console. The full details can be observed on the
>gist [1] but for completeness I list some of it below. It may be a false
>positive at this point, not sure.
>
>[493272.711271] run blktests zbd/005 at 2022-04-14 20:03:22
>[493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
>[493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
>[493336.981666] nvme nvme9: Abort status: 0x0
>[493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controller
>[493388.819341] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>[493425.817272] rcu:    4-....: (0 ticks this GP) idle=c48/0/0x0 softirq=11316030/11316030 fqs=939  (false positive?)
>[493425.819275]         (detected by 7, t=14522 jiffies, g=31237493, q=6271)

Ok so CPU-7 detected stalls on CPU-4, which is in dyntick-idle mode,
which is an extended quiescent state (EQS) to overcome the limitations of
not having a tick (NO_HZ). So the false positive looks correct here in
that idle threads in this state are not in fact blocking the grace period
kthread.

No idea, however, why this would happen when using qemu as opposed to
nbd.

Thanks,
Davidlohr
