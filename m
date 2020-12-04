Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FE0C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 20:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A2422C9C
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 20:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgLDUCP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLDUCP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 15:02:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A47CC061A4F;
        Fri,  4 Dec 2020 12:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mwhmqUBogTqkSec5CGMda2ZetJiviJl0UkOzggNOmq4=; b=jhlTOHehDyM+DJK3bkeynfOvq2
        fG7D6gZ9AMyclpP3iI4p1AzYDsgdIlWpHYMaIZzLqggf9n53QHtsyW1l6DYVrr9WgzSGSsZdBMDVY
        LEMeIULTd/zk5Gew2Zd6lVr+AGPY469TMd4AnclUUvKhWNWB6G9Ivc+zb5GjTBRhnUD4PcfksYrfk
        5/Ss+fsd7AdDyanUPI/HpYLXxI9X/beSompIR8J+RWGUTuNXt4qZgecURf8Xj+++TYXQMdKAwa46x
        9VwMJuQT2OgaOOCPnJpnAUQTtOQiw/ktmPcMf4uiQHJsODsSr5UehwZN0pzkBeatzDXrVhRar4pyj
        r7siEDBg==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klHGc-0004KV-W6; Fri, 04 Dec 2020 20:01:23 +0000
Subject: Re: [PATCH v2] iosched: Add i10 I/O Scheduler
To:     Rachit Agarwal <rach4x0r@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Rachit Agarwal <ragarwal@cornell.edu>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        David Ahern <dsahern@gmail.com>
References: <20201130201927.84846-1-rach4x0r@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <593f6a3b-6e78-e4b3-c808-b9e452e6d05b@infradead.org>
Date:   Fri, 4 Dec 2020 12:01:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130201927.84846-1-rach4x0r@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 12:19 PM, Rachit Agarwal wrote:
> From: Rachit Agarwal <ragarwal@cornell.edu>
> 

Hi,  {reusing bits}

> ---
>  Documentation/block/i10-iosched.rst |  79 ++++++
>  block/Kconfig.iosched               |   8 +
>  block/Makefile                      |   1 +
>  block/i10-iosched.c                 | 471 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 559 insertions(+)
>  create mode 100644 Documentation/block/i10-iosched.rst
>  create mode 100644 block/i10-iosched.c


> diff --git a/Documentation/block/i10-iosched.rst b/Documentation/block/i10-iosched.rst
> new file mode 100644
> index 0000000..661b5d5
> --- /dev/null
> +++ b/Documentation/block/i10-iosched.rst
> @@ -0,0 +1,79 @@
> +==========================
> +i10 I/O scheduler overview
> +==========================
> +
> +I/O batching is beneficial for optimizing IOPS and throughput for various
> +applications. For instance, several kernel block drivers would benefit from
> +batching, including mmc [1] and tcp-based storage drivers like nvme-tcp [2,3].

                       MMC         TCP-based

> +While we have support for batching dispatch [4], we need an I/O scheduler to
> +efficiently enable batching. Such a scheduler is particularly interesting for
> +disaggregated (remote) storage, where the access latency of disaggregated remote
> +storage may be higher than local storage access; thus, batching can significantly
> +help in amortizing the remote access latency while increasing the throughput.
> +
> +This patch introduces the i10 I/O scheduler, which performs batching per hctx in
> +terms of #requests, #bytes, and timeouts (at microseconds granularity). i10 starts
> +dispatching only when #requests or #bytes is larger than a threshold or when a timer
> +expires. After that, batching dispatch [3] would happen, allowing batching at device
> +drivers along with "bd->last" and ".commit_rqs".
> +
> +The i10 I/O scheduler builds upon recent work on [6]. We have tested the i10 I/O
> +scheduler with nvme-tcp optimizaitons [2,3] and batching dispatch [4], varying number

                           optimizations

> +of cores, varying read/write ratios, and varying request sizes, and with NVMe SSD and
> +RAM block device. For remote NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements
> +in terms of IOPS per core over "noop" I/O scheduler, while trading off latency at lower loads.
> +These results are available at [5], and many additional results are presented in [6].
> +
> +While other schedulers may also batch I/O (e.g., mq-deadline), the optimization target
> +in the i10 I/O scheduler is throughput maximization. Hence there is no latency target
> +nor a need for a global tracking context, so a new scheduler is needed rather than
> +to build this functionality to an existing scheduler.
> +
> +We have default values for batching thresholds (e.g., 16 for #requests, 64KB for #bytes,
> +and 50us for timeout). These default values are based on sensitivity tests in [6].
> +For many workloads, especially those with low loads, the default values of i10 scheduler
> +may not provide the optimal operating point on the latency-throughput curve. To that end,
> +the scheduler adaptively sets the batch size depending on number of outstanding requests
> +and the triggering of timeouts, as measured in the block layer. Much work needs to be done
> +to design better adaptation algorithms, especially when the loads are neither too high
> +nor too low. This constitutes interesting future work. In addition, for our future work, we
> +plan to extend the scheduler to support isolation in multi-tenant deployments
> +(to simultaneously achieve low tail latency for latency-sensitive applications and high
> +throughput for throughput-bound applications).
> +
> +References
> +[1] https://lore.kernel.org/linux-block/cover.1587888520.git.baolin.wang7@gmail.com/T/#mc48a8fb6069843827458f5fea722e1179d32af2a
> +[2] https://git.infradead.org/nvme.git/commit/122e5b9f3d370ae11e1502d14ff5c7ea9b144a76
> +[3] https://git.infradead.org/nvme.git/commit/86f0348ace1510d7ac25124b096fb88a6ab45270
> +[4] https://lore.kernel.org/linux-block/20200630102501.2238972-1-ming.lei@redhat.com/
> +[5] https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf
> +[6] https://www.usenix.org/conference/nsdi20/presentation/hwang
> +
> +==========================
> +i10 I/O scheduler tunables
> +==========================

[snip]


thanks.
-- 
~Randy

