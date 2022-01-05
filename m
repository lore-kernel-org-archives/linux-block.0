Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBE8C433EF
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 17:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbiAER0c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:26:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57740 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiAER0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 12:26:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63FE1B81158
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 17:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412CCC36AE0;
        Wed,  5 Jan 2022 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641403588;
        bh=Ai4ap2rjhXc3aSeFFnC+xdaqAJOln+8Hj+m+Ez8mvY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTpfpFmiZ6Czfq7bJ8BGZWk/n4qb6lV3wjyn9GVIRtvYt3HDdgB3a4A3nKP1jxBQv
         pTUFG6RkONLcdhQ9VIzncMQcP5TE/C4Y41Px0U3wMt8Sukgb3iIQ6bdF5h4X07klca
         vft+NKXAQhmv91QDGhEcdGC7mZtQXa+lSzdQ/URb0AGD+sZjqQzlyVcBS1nyzduqZx
         gm/KaIdWb5hDXh0VPGfulM86oFA8cuijKVn1ivg6Ml+K+QpPkjRS0/Hnwh1SCPAxsu
         f7fCtAQudtjvYYPSxcMKg9BuZM3UmR3uo3wMkBuu45pZBT6HocopZByMxPbh2AHj8g
         8IEPyvuu+XBHA==
Date:   Wed, 5 Jan 2022 09:26:25 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Message-ID: <20220105172625.GA3181467@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
 <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
 <99b389d6-b18b-7c3b-decb-66c4563dd37b@nvidia.com>
 <20211230153018.GD2493133@dhcp-10-100-145-180.wdc.com>
 <2ed68ef8-5393-80ae-1caa-c00d108aec8c@nvidia.com>
 <20220103181552.GA2498980@dhcp-10-100-145-180.wdc.com>
 <ac74ac4c-15f3-997e-ecd2-5e704a5b4573@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac74ac4c-15f3-997e-ecd2-5e704a5b4573@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 04, 2022 at 02:15:58PM +0200, Max Gurtovoy wrote:
> 
> This patch worked for me with 2 namespaces for NVMe PCI.
> 
> I'll check it later on with my RDMA queue_rqs patches as well. There we have
> also a tagset sharing with the connect_q (and not only with multiple
> namespaces).
> 
> But the connect_q is using a reserved tags only (for the connect commands).
> 
> I saw some strange things that I couldn't understand:
> 
> 1. running randread fio with libaio ioengine didn't call nvme_queue_rqs -
> expected
> 
> *2. running randwrite fio with libaio ioengine did call nvme_queue_rqs - Not
> expected !!*
> 
> *3. running randread fio with io_uring ioengine (and --iodepth_batch=32)
> didn't call nvme_queue_rqs - Not expected !!*
> 
> 4. running randwrite fio with io_uring ioengine (and --iodepth_batch=32) did
> call nvme_queue_rqs - expected
> 
> 5. *running randread fio with io_uring ioengine (and --iodepth_batch=32
> --runtime=30) didn't finish after 30 seconds and stuck for 300 seconds (fio
> jobs required "kill -9 fio" to remove refcounts from nvme_core)   - Not
> expected !!*
> 
> *debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300
> seconds, it appears to be stuck. Doing forceful exit of this job.
> *
> 
> *6. ***running randwrite fio with io_uring ioengine (and  --iodepth_batch=32
> --runtime=30) didn't finish after 30 seconds and stuck for 300 seconds (fio
> jobs required "kill -9 fio" to remove refcounts from nvme_core)   - Not
> expected !!**
> 
> ***debug pring: fio: job 'task_nvme0n1' (state=5) hasn't exited in 300
> seconds, it appears to be stuck. Doing forceful exit of this job.***
> 
> 
> any idea what could cause these unexpected scenarios ? at least unexpected
> for me :)

Not sure about all the scenarios. I believe it should call queue_rqs
anytime we finish a plugged list of requests as long as the requests
come from the same request_queue, and it's not being flushed from
io_schedule().

The stuck fio job might be a lost request, which is what this series
should address. It would be unusual to see such an error happen in
normal operation, though. I had to synthesize errors to verify the bug
and fix.

In any case, I'll run more multi-namespace tests to see if I can find
any other issues with shared tags.
