Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35427 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbdDKOlt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 10:41:49 -0400
Received: by mail-wm0-f42.google.com with SMTP id w64so65624723wma.0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 07:41:48 -0700 (PDT)
Subject: Re: [PATCH v5] lightnvm: physical block device (pblk) target
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1491921077-9377-1-git-send-email-javier@cnexlabs.com>
 <1491921077-9377-2-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart.VanAssche@sandisk.com,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c2f1bccd-5b1e-b51e-a236-5d2186159e32@lightnvm.io>
Date: Tue, 11 Apr 2017 16:41:46 +0200
MIME-Version: 1.0
In-Reply-To: <1491921077-9377-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/11/2017 04:31 PM, Javier González wrote:
> This patch introduces pblk, a host-side translation layer for
> Open-Channel SSDs to expose them like block devices. The translation
> layer allows data placement decisions, and I/O scheduling to be
> managed by the host, enabling users to optimize the SSD for their
> specific workloads.
>
> An open-channel SSD has a set of LUNs (parallel units) and a
> collection of blocks. Each block can be read in any order, but
> writes must be sequential. Writes may also fail, and if a block
> requires it, must also be reset before new writes can be
> applied.
>
> To manage the constraints, pblk maintains a logical to
> physical address (L2P) table,  write cache, garbage
> collection logic, recovery scheme, and logic to rate-limit
> user I/Os versus garbage collection I/Os.
>
> The L2P table is fully-associative and manages sectors at a
> 4KB granularity. Pblk stores the L2P table in two places, in
> the out-of-band area of the media and on the last page of a
> line. In the cause of a power failure, pblk will perform a
> scan to recover the L2P table.
>
> The user data is organized into lines. A line is data
> striped across blocks and LUNs. The lines enable the host to
> reduce the amount of metadata to maintain besides the user
> data and makes it easier to implement RAID or erasure coding
> in the future.
>
> pblk implements multi-tenant support and can be instantiated
> multiple times on the same drive. Each instance owns a
> portion of the SSD - both regarding I/O bandwidth and
> capacity - providing I/O isolation for each case.
>
> Finally, pblk also exposes a sysfs interface that allows
> user-space to peek into the internals of pblk. The interface
> is available at /dev/block/*/pblk/ where * is the block
> device name exposed.
>
> This work also contains contributions from:
>   Matias Bjørling <matias@cnexlabs.com>
>   Simon A. F. Lund <slund@cnexlabs.com>
>   Young Tack Jin <youngtack.jin@gmail.com>
>   Huaicheng Li <huaicheng@cs.uchicago.edu>
>
> Signed-off-by: Javier González <javier@cnexlabs.com>

Awesome. Applied for 4.12.
