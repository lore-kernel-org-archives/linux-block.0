Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33695 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbcJDSyP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 14:54:15 -0400
Date: Tue, 4 Oct 2016 14:54:13 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Shaohua Li <shli@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161004185413.GF4205@htj.duckdns.org>
References: <cover.1475529372.git.shli@fb.com>
 <20161004132805.GB28808@redhat.com>
 <20161004155616.GB4205@htj.duckdns.org>
 <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it>
 <20161004162759.GD4205@htj.duckdns.org>
 <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Paolo.

On Tue, Oct 04, 2016 at 07:43:48PM +0200, Paolo Valente wrote:
> > I don't think IO bandwidth does not matter. The problem is bandwidth can't
> > measure IO cost. For example, you can't say 8k IO costs 2x IO resource than 4k
> > IO.
> 
> For what goal do you need to be able to say this, once you succeeded
> in guaranteeing bandwidth and low latency to each
> process/client/group/node/user?

For resource partitioning mostly.  It's not a single user or purpose
use case.  The same device gets shared across unrelated workloads and
we need to guarantee differing levels of quality of service to each
regardless of the specifics of workload.  We actually need to be able
to control IO resources.

Thanks.

-- 
tejun
