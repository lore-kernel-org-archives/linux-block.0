Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr10119.outbound.protection.outlook.com ([40.107.1.119]:53532
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbdJCORY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Oct 2017 10:17:24 -0400
Subject: Re: [PATCH] lightnvm: pblk: use vfree_atomic when freeing line
 metadata
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <1507038524-24587-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <5f64209d-ba28-a642-ed44-66a5eced9a99@virtuozzo.com>
 <9AF41216-3CB7-4AFA-B461-0957074AF0A5@lightnvm.io>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <2aa049d5-3c31-eabc-a995-499807837a19@virtuozzo.com>
Date: Tue, 3 Oct 2017 17:20:20 +0300
MIME-Version: 1.0
In-Reply-To: <9AF41216-3CB7-4AFA-B461-0957074AF0A5@lightnvm.io>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 10/03/2017 05:11 PM, Javier Gonz�lez wrote:
>> On 3 Oct 2017, at 16.07, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>
>>
>>
>> On 10/03/2017 04:48 PM, Hans Holmberg wrote:
>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>
>>> The commit bf22e37a6413 ("mm: add vfree_atomic()") made vfree unsafe to
>>> call in atomic context (unless the call came from an interrupt) and
>>> introduced vfree_atomic that is safe to call in atomic context.
>>>
>>> So, since we're holding locks when freeing line metadata, we need to
>>> use the atomic version of vfree.
>>>
>>> Fix this by introducing an atomic variant of pblk_mfree and
>>> switching to that in pblk_line_meta_free.
>>>
>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> ---
>>>
>>> The patch is for:
>>> https://github.com/OpenChannelSSD/linux branch for-4.15/pblk
>>>
>>> drivers/lightnvm/pblk-init.c | 3 ++-
>>> drivers/lightnvm/pblk.h      | 8 ++++++++
>>> 2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index c452478..3a191a6 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -396,7 +396,8 @@ static void pblk_line_meta_free(struct pblk *pblk)
>>> 	spin_lock(&l_mg->free_lock);
>>
>> What's the point in holding ->free_lock here? It seems like it could be just dropped.
>>
> 
> This lock can indeed be dropped,

So, let's do this. This would be the best way to fix this.

> but the general pblk semaphore, which
> serializes initialization and tear down cannot. This is taken on
> pblk_exit().
> 

But semaphore is not the problem here. We can sleep under semaphore, so it's fine.

> Javier
> 
