Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33069 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbdDLU5d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 16:57:33 -0400
Received: by mail-lf0-f43.google.com with SMTP id h125so20533295lfe.0
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2017 13:57:33 -0700 (PDT)
Subject: Re: [PATCH v6] lightnvm: physical block device (pblk) target
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1492003155-19320-1-git-send-email-javier@cnexlabs.com>
 <1492003155-19320-2-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart.VanAssche@sandisk.com,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0167c816-9955-8fcc-3b53-b8965fef41f1@lightnvm.io>
Date: Wed, 12 Apr 2017 22:57:30 +0200
MIME-Version: 1.0
In-Reply-To: <1492003155-19320-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/12/2017 03:19 PM, Javier González wrote:
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
> ---

Thanks Javier. Applied to 4.12, and replaced the v5 version.
