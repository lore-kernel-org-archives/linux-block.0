Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD2BC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 04:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349402AbiDOEcz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 00:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiDOEcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 00:32:54 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7B237CC
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 21:30:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5AF1D6A06BC;
        Fri, 15 Apr 2022 04:30:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DAB806A0626;
        Fri, 15 Apr 2022 04:30:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649997026; a=rsa-sha256;
        cv=none;
        b=bu2BFpwlmv4483oKJzFrVtdwj1ElZojCc8LLTejGt8BY4rl5SQ9P1L8f2OgIFanCWhzYYJ
        TPARXX3U4E+BrTjv/qg/bwGPCtxZ4zQTaZBAc0VcXIfijS5azpiuYj6W4hzBPq4ANOhlE3
        tvCo60NWJZkmyXDlT7huWDaHkST5gZkDANLW00RkE47TksKBPmSpABiTesK5ALsMBi6Mhd
        oPZtjSF0c2Vg19vGjoS1ncFhQZEFovywsXAhYmNlYDuLBpq5X74+O03dUi7aaIZ+1SZ8Xl
        A6FAkmE/KUpX+MXUHWvvAtwvDlvZ/dPgfJqWeGVEKCKlZJcrmOHkHI/jNyXexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649997026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=H/3ogpQJEmL6nGX+Y2Uha1okjLsH4lTeTzB2lJp1v3k=;
        b=8Uqzfo3UfVwgs/xl+BXxsU+6CzK5N4gVNPPeRl/N4PI7TMti+9H9IH3qBaal+pjSXAvLuF
        15CdEcsJrOkzeVB054GbRmGL9NcC0C4/TA8Dn4OovExbK0+KJQIon+m1BbSmhC7L6M9oSJ
        ZarETKQk0q6HxoWqOUXdYN6zGZe4ueLEQ4UB3Trnweasr9pLitCshpI3A5/9YZy7ZUyQ5A
        jU4et795hUP7yffyrbGfU/3c6BQjzPt8Q/5rjHd4/rZ2g4qNiS1BG3DAZBhVE3oIPU1FK0
        dnFCDGzOSRs9FiNoDwTTPXweS1oRmKLRMKeFOXi98aDOHCC01Q/ik14vXg8pKQ==
ARC-Authentication-Results: i=1;
        rspamd-b69d6888c-sv7cv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.95.106 (trex/6.7.1);
        Fri, 15 Apr 2022 04:30:26 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Lyrical: 32a9c37d4c86b89e_1649997026193_3891736887
X-MC-Loop-Signature: 1649997026193:2711541799
X-MC-Ingress-Time: 1649997026193
Received: from offworld (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4Kfk010vh0z1Pt;
        Thu, 14 Apr 2022 21:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649997025;
        bh=H/3ogpQJEmL6nGX+Y2Uha1okjLsH4lTeTzB2lJp1v3k=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=YrHnN6P+0KEK0KNSZkJohQJSXtk/kp/P1EjGzumWOgp9A8DXacHM3paO0zYFZ1/ry
         UrOhi61g7MIr30AcIlLWRe9gREDvHtkEqra6GDcW9Ea+aJMoVDQkf2uBYukd64WzKi
         PguoiaBwe9evG5pcl8yRCBTV48StgO5Qh7Tz4sfTHzae9hl+sL+baEgYopHtqxjrdw
         R03OAvXcT6NZ03fL/xYs3dnBEONwHC4C8OQqKqfIib2nwLG/lnvmNdF8BkoVMRi6yI
         Fq6lKRlcDiTBWrk+pkcfnjcSs0LSK5ynaBlitfZPBEbrQLtddht8L9ggX9Rb0z0TmR
         vrrKB+P/OSSxQ==
Date:   Thu, 14 Apr 2022 21:30:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, shinichiro.kawasaki@wdc.com,
        Klaus Jensen <its@irrelevant.dk>, linux-block@vger.kernel.org,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <20220415043021.awhfncjjt22vyajg@offworld>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220415010945.wvyztmss7rfqnlog@offworld>
 <20220415035438.GE4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220415035438.GE4285@paulmck-ThinkPad-P17-Gen-1>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Apr 2022, Paul E. McKenney wrote:

>On Thu, Apr 14, 2022 at 06:09:45PM -0700, Davidlohr Bueso wrote:
>> No idea, however, why this would happen when using qemu as opposed to
>> nbd.
>
>This one is a bit strange, no two ways about it.
>
>In theory, vCPU preemption is a possibility.  In practice, if the
>RCU grace-period kthread's vCPU was preempted for so long, I would
>have expected the RCU CPU stall warning to complain about starvation.
>But it still might be worth tracing context switches on the underlying
>hypervisor.

Right, but both cases are VMs which is what throws me off, regardless
of the zns drive. Or is this not the case, Luis?

Thanks,
Davidlohr
