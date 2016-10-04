Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35141 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbcJDTOa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 15:14:30 -0400
Date: Tue, 4 Oct 2016 15:14:27 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Shaohua Li <shli@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161004191427.GG4205@htj.duckdns.org>
References: <cover.1475529372.git.shli@fb.com>
 <20161004132805.GB28808@redhat.com>
 <20161004155616.GB4205@htj.duckdns.org>
 <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it>
 <20161004162759.GD4205@htj.duckdns.org>
 <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
 <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Paolo.

On Tue, Oct 04, 2016 at 09:02:47PM +0200, Paolo Valente wrote:
> That's exactly what BFQ has succeeded in doing in all the tests
> devised so far.  Can you give me a concrete example for which I can
> try with BFQ and with any other mechanism you deem better.  If
> you are right, numbers will just make your point.

Hmm... I think we already discussed this but here's a really simple
case.  There are three unknown workloads A, B and C and we want to
give A certain best-effort guarantees (let's say around 80% of the
underlying device) whether A is sharing the device with B or C.

I get that bfq can be a good compromise on most desktop workloads and
behave reasonably well for some server workloads with the slice
expiration mechanism but it really isn't an IO resource partitioning
mechanism.

Thanks.

-- 
tejun
