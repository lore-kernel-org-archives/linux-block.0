Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A7AC43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 13:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBF7214D8
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 13:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfLKN46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:56:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:58636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728128AbfLKN46 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 08:56:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F388AAB8;
        Wed, 11 Dec 2019 13:56:56 +0000 (UTC)
Subject: Re: [PATCH] xen-blkback: prevent premature module unload
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        "Durrant, Paul" <pdurrant@amazon.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20191210145305.6605-1-pdurrant@amazon.com>
 <20191211112754.GM980@Air-de-Roger>
 <14a01d62046c48ee9b2486917370b5f5@EX13D32EUC003.ant.amazon.com>
 <20191211135523.GP980@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <ab90f484-0641-a33d-6fcf-6fccc602e8c2@suse.com>
Date:   Wed, 11 Dec 2019 14:56:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211135523.GP980@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11.12.19 14:55, Roger Pau Monné wrote:
> On Wed, Dec 11, 2019 at 01:27:42PM +0000, Durrant, Paul wrote:
>>> -----Original Message-----
>>> From: Roger Pau Monné <roger.pau@citrix.com>
>>> Sent: 11 December 2019 11:29
>>> To: Durrant, Paul <pdurrant@amazon.com>
>>> Cc: xen-devel@lists.xenproject.org; linux-block@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>;
>>> Jens Axboe <axboe@kernel.dk>
>>> Subject: Re: [PATCH] xen-blkback: prevent premature module unload
>>>
>>> On Tue, Dec 10, 2019 at 02:53:05PM +0000, Paul Durrant wrote:
>>>> Objects allocated by xen_blkif_alloc come from the 'blkif_cache' kmem
>>>> cache. This cache is destoyed when xen-blkif is unloaded so it is
>>>> necessary to wait for the deferred free routine used for such objects to
>>>> complete. This necessity was missed in commit 14855954f636 "xen-blkback:
>>>> allow module to be cleanly unloaded". This patch fixes the problem by
>>>> taking/releasing extra module references in xen_blkif_alloc/free()
>>>> respectively.
>>>>
>>>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>>>
>>> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
>>>
>>> One nit below.
>>>
>>>> ---
>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>> Cc: "Roger Pau Monné" <roger.pau@citrix.com>
>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>   drivers/block/xen-blkback/xenbus.c | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-
>>> blkback/xenbus.c
>>>> index e8c5c54e1d26..59d576d27ca7 100644
>>>> --- a/drivers/block/xen-blkback/xenbus.c
>>>> +++ b/drivers/block/xen-blkback/xenbus.c
>>>> @@ -171,6 +171,15 @@ static struct xen_blkif *xen_blkif_alloc(domid_t
>>> domid)
>>>>   	blkif->domid = domid;
>>>>   	atomic_set(&blkif->refcnt, 1);
>>>>   	init_completion(&blkif->drain_complete);
>>>> +
>>>> +	/*
>>>> +	 * Because freeing back to the cache may be deferred, it is not
>>>> +	 * safe to unload the module (and hence destroy the cache) until
>>>> +	 * this has completed. To prevent premature unloading, take an
>>>> +	 * extra module reference here and release only when the object
>>>> +	 * has been free back to the cache.
>>>                      ^ freed
>>
>> Oh yes. Can this be done on commit, or would you like me to send a v2?
> 
> Adjusting on commit would be fine for me, but it's up to Juergen since
> he is the one that will pick this up. IIRC the module unload patches
> didn't go through the block subsystem.

Oh, right. Yes, will fix this when committing.


Juergen

