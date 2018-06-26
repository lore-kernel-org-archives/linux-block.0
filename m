Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45779 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeFZVCt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 17:02:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id a22-v6so8632139pfo.12
        for <linux-block@vger.kernel.org>; Tue, 26 Jun 2018 14:02:49 -0700 (PDT)
Date: Tue, 26 Jun 2018 14:02:47 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests 00/15] Add SRP initiator driver tests
Message-ID: <20180626210247.GG1218@vader>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 22, 2018 at 03:19:31PM -0700, Bart Van Assche wrote:
> Hello Omar,
> 
> As promised during LSF/MM, I have converted the srp-tests software to the
> blktests framework. This patch series included all blktests patches I postd
> a few days ago. Please consider this patch series for inclusion in the
> official blktests repository. Note: this patch series is also available as
> a github pull request, namely https://github.com/osandov/blktests/pull/24.
> 
> Thanks,
> 
> Bart.
> 
> Bart Van Assche (15):
>   common/rc: Fix _have_tracepoint()
>   Annotate include statements in shell scripts where the source file is
>     a variable
>   check, tests/meta/012: Use array["index"] instead of array[index]
>   Suppress shellcheck complaints about global variables
>   check: Avoid that shellcheck complains that $FULL appears unused
>   Multiple tests: remove unused and undefined variables
>   Avoid passing tests/block/002 arguments to _init_scsi_debug
>   check: Suppress a shellcheck warning about the DMESG_FILTER
>     initialization
>   Makefile: Do not suppress useful shellcheck warnings
>   tests/meta/group: Fix shellcheck complaints
>   make check: Also check tests/*/group files
>   check: Make TMPDIR absolute

I've applied all of these.

>   src/Makefile: Fix pattern rule
>   Add the discontiguous-io test program
>   Add tests for the SRP initiator and target drivers

For these, can you please reroll them with whatever group_requires()
check you need, and with the helper functions moved to tests/srp/rc.
Thanks!
