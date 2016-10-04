Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36243 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754038AbcJDQ2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 12:28:02 -0400
Date: Tue, 4 Oct 2016 12:27:59 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Vivek Goyal <vgoyal@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161004162759.GD4205@htj.duckdns.org>
References: <cover.1475529372.git.shli@fb.com>
 <20161004132805.GB28808@redhat.com>
 <20161004155616.GB4205@htj.duckdns.org>
 <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Tue, Oct 04, 2016 at 06:22:28PM +0200, Paolo Valente wrote:
> Could you please elaborate more on this point?  BFQ uses sectors
> served to measure service, and, on the all the fast devices on which
> we have tested it, it accurately distributes
> bandwidth as desired, redistributes excess bandwidth with any issue,
> and guarantees high responsiveness and low latency at application and
> system level (e.g., ~0 drop rate in video playback, with any background
> workload tested).

The same argument as before.  Bandwidth is a very bad measure of IO
resources spent.  For specific use cases (like desktop or whatever),
this can work but not generally.

> Could you please suggest me some test to show how sector-based
> guarantees fails?

Well, mix 4k random and sequential workloads and try to distribute the
acteual IO resources.

Thanks.

-- 
tejun
