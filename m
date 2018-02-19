Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46162 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeBSHbe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Feb 2018 02:31:34 -0500
Received: by mail-lf0-f65.google.com with SMTP id r80so1369450lfe.13
        for <linux-block@vger.kernel.org>; Sun, 18 Feb 2018 23:31:34 -0800 (PST)
Subject: Re: [PATCH v2 5/6] lightnvm: remove nvm_dev_ops->max_phys_sect
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20180215131200.3354-1-mb@lightnvm.io>
 <20180215131200.3354-6-mb@lightnvm.io>
 <918E7340-05D7-4E2F-BC43-2B81D435C3C6@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <899e5ed5-4bf7-666a-d756-d86420cf9c9e@lightnvm.io>
Date: Mon, 19 Feb 2018 08:31:31 +0100
MIME-Version: 1.0
In-Reply-To: <918E7340-05D7-4E2F-BC43-2B81D435C3C6@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/16/2018 07:48 AM, Javier Gonzalez wrote:
> 
>> On 15 Feb 2018, at 05.11, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> The value of max_phys_sect is always static. Instead of
>> defining it in the nvm_dev_ops structure, declare it as a global
>> value.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/lightnvm/core.c          | 28 +++++++---------------------
>> drivers/lightnvm/pblk-init.c     |  9 ++++-----
>> drivers/lightnvm/pblk-recovery.c |  8 ++------
>> drivers/nvme/host/lightnvm.c     |  5 +----
>> include/linux/lightnvm.h         |  5 ++---
>> 5 files changed, 16 insertions(+), 39 deletions(-)
>>
> 
> The patch looks good, but I have a question. If a target implements the
> scalar interface, then it will not be limited to 64 lbas/ppas and it
> will not make sense to split the bio base don this value. In fact, it
> looks like in time, we will move to a scalar interface in the 2.0 path
> to align with the zoned interface, so this value will be dependent on
> whether the target is using the scalar or vector interface.
> 

Both read/write and vector interface will coexist. I am only removing 
what is hardwired into the specification.

The read/write interface has always been able issue more than 64 LBAs, 
it is instead limited by what the hardware reports its max transfer size 
to be.
