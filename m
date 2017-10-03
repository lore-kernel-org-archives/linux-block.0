Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34290 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753561AbdJCMaa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 08:30:30 -0400
Received: by mail-oi0-f68.google.com with SMTP id q133so3084742oic.1
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 05:30:30 -0700 (PDT)
Received: from ashlar.local (72-184-120-81.res.bhn.net. [72.184.120.81])
        by smtp.gmail.com with ESMTPSA id t197sm6614190oih.16.2017.10.03.05.30.28
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2017 05:30:29 -0700 (PDT)
From: Lee Tibbert <lee.tibbert@gmail.com>
To: linux-block@vger.kernel.org
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/4] block, bfq: series of fixes of bugs
Date: Tue,  3 Oct 2017 08:30:21 -0400
Message-Id: <20171003123021.25626-1-lee49@ashlar.local>
In-Reply-To: <20170921090403.3217-1-paolo.valente@linaro.org>
References: <20170921090403.3217-1-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 21, 2017 at 5:03 AM, Paolo Valente <paolo.valente@linaro.org>
wrote:

> Hi,
> the first patch in this series fixes a bug that causes bfq to fail to
> guarantee a high responsiveness on some drives, if there is heavy
> random read+write I/O in the background. More precisely, such a
> failure allowed this bug to be found [1], but the bug may well cause
> other yet unreported anomalies.
>
> This fix uncovered other bugs that were concealed by the fixed bug,
> for rather subtle reasons. These further bugs caused similar
> responsiveness failures, but with sequential reaad+write workloads in
> the background. The remaining three patches fix these further bugs.
>
> The sum of these fixes makes responsiveness much stabler with BFQ. In
> the presence of write hogs, it is however still impossible for an I/O
> scheduler to guarantee perfect responsiveness in any circustance,
> because of throttling issues in the virtual-memory management
> subsystem, and in other higher-level components.
>
> Thanks,
> Paolo
>
> [1] Background I/O Type: Random - Background I/O mix: Reads and writes
> - Application to start: LibreOffice Writer in
> http://www.phoronix.com/scan.php?page=news_item&px=Linux-4.13-IO-Laptop
>
>
> Paolo Valente (4):
>   block, bfq: fix wrong init of saved start time for weight raising
>   block, bfq: check and switch back to interactive wr also on queue
>     split
>   block, bfq: let early-merged queues be weight-raised on split too
>   block, bfq: decrease burst size when queues in burst exit
>
>  block/bfq-iosched.c | 169 ++++++++++++++++++++++++++++++
> +---------------------
>  1 file changed, 102 insertions(+), 67 deletions(-)
>
> --
> 2.10.0
>

Paolo,

Please feel free to add:

  Tested-by: Lee Tibbert <lee.tibbert@gmail.com>

I thought that you and linux-block readers might be interested
in a data point. I have been running the algodev variant of these
patches for about two weeks. Now I am running these exact patches.

At one point, I had firefox running in my main windows, and, in other
windows, a full linux build, a full scala-native build, and a git gc. I
barely noticed the builds going on.  The variance of latency in
firefox was well within my normal network variance. Usually any
one of the build jobs would have made firefox useless.

Pretty amazing!  In fact, it was so amazing that I did not trust my
memory several days later, so I repeated the full test.
Same result:  great reduced latency.

There being no such thing as a free lunch, the build jobs did
take longer than if executed standalone. However, I did not mind
because I was able to continue getting work done on the tasks
I needed in interactive time.

I hope these patches are accepted into linux mainline & will
I will continue to exercise them.

Lee
