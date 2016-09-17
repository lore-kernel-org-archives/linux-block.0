Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34493 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751027AbcIQTk2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Sep 2016 15:40:28 -0400
Subject: Re: [PATCH] sbitmap: don't update the allocation hint on clear after
 resize
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <54286aca-7ce6-5138-9189-83a2dff444b1@fb.com>
 <29fb3ca2c78084b3548fd87c0c9a946e2b68bffc.1474139647.git.osandov@fb.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <227b6d24-8500-4ec9-5999-fd83f7221b8a@fb.com>
Date: Sat, 17 Sep 2016 13:39:59 -0600
MIME-Version: 1.0
In-Reply-To: <29fb3ca2c78084b3548fd87c0c9a946e2b68bffc.1474139647.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/17/2016 01:20 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> If we have a bunch of high-numbered bits allocated and then we resize
> the struct sbitmap_queue, when those bits get cleared, we'll update the
> hint and then have to re-randomize it repeatedly. Avoid that by checking
> that the cleared bit is still a valid hint. No measurable performance
> difference in the common case.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Jens,
>
> Small tweak to patch 6 that occurred to me after I sent the series out.
> Feel free to fold it in to patch 6 or apply it separately as you see
> fit.

No worries. I can't fold since the series was already applied, so I just
added the extra patch.

-- 
Jens Axboe

