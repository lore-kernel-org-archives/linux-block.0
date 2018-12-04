Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEE5C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 05:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E4420834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 05:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E4420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLDF5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:57:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:33176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeLDF5D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 00:57:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EDC4AC2C;
        Tue,  4 Dec 2018 05:57:01 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen-blkfront: use old rinfo after enomem
 during migration
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
References: <1543468665-22795-1-git-send-email-manjunath.b.patil@oracle.com>
 <fab88d94-79de-8ff4-be69-ff768b3f9697@oracle.com>
 <1dafcf3d-c3b6-e6c5-f5d4-fbdb549aaa9c@oracle.com>
 <3da66993-a044-c65c-88a6-c0672ab8814f@oracle.com>
 <f187b34d-8b05-a1ce-cc96-731729a7da55@oracle.com>
 <ee73815a-3b0c-bb3e-bd52-239c9b3d8cc0@oracle.com>
 <5cdcbb60-d862-b3c7-2869-4961c5565dfa@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cc70048a-5ad0-9696-0bec-d6c976fb6bb5@suse.com>
Date:   Tue, 4 Dec 2018 06:57:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <5cdcbb60-d862-b3c7-2869-4961c5565dfa@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/12/2018 02:14, Dongli Zhang wrote:
> Hi Boris,
> 
> On 12/04/2018 12:07 AM, Boris Ostrovsky wrote:
>> On 12/2/18 3:31 PM, Manjunath Patil wrote:
>>> On 11/30/2018 2:33 PM, Boris Ostrovsky wrote:
>>>
>>>> On 11/30/18 4:49 PM, Manjunath Patil wrote:
>>>>> Thank you Boris for your comments. I removed faulty email of mine.
>>>>>
>>>>> replies inline.
>>>>> On 11/30/2018 12:42 PM, Boris Ostrovsky wrote:
>>>>>> On 11/29/18 12:17 AM, Manjunath Patil wrote:
>>>>>>> Hi,
>>>>>>> Feel free to suggest/comment on this.
>>>>>>>
>>>>>>> I am trying to do the following at dst during the migration now.
>>>>>>> 1. Dont clear the old rinfo in blkif_free(). Instead just clean it.
>>>>>>> 2. Store the old rinfo and nr_rings into temp variables in
>>>>>>> negotiate_mq()
>>>>>>> 3. let nr_rings get re-calculated based on backend data
>>>>>>> 4. try allocating new memory based on new nr_rings
>>>>>> Since I suspect number of rings will likely be the same why not reuse
>>>>>> the rings in the common case?
>>>>> I thought attaching devices will be more often than migration. Hence
>>>>> did not want add to an extra check for
>>>>>    - if I am inside migration code path and
>>>>>    - if new nr_rings is equal to old nr_rings or not
>>>>>
>>>>> Sure addition of such a thing would avoid the memory allocation
>>>>> altogether in migration path,
>>>>> but it would add a little overhead for normal device addition.
>>>>>
>>>>> Do you think its worth adding that change?
>>>>
>>>> IMO a couple of extra checks are not going to make much difference.
>>> I will add this change
>>>>
>>>> I wonder though --- have you actually seen the case where you did fail
>>>> allocation and changes provided in this patch made things work? I am
>>>> asking because right after negotiate_mq() we will call setup_blkring()
>>>> and it will want to allocate bunch of memory. A failure there is fatal
>>>> (to ring setup). So it seems to me that you will survive negotiate_mq()
>>>> but then will likely fail soon after.
>>> I have noticed the ENOMEM insise negotiate_mq() on ct machine. When I
>>> included my patch, I manually triggered the ENOMEM using a debug flag.
>>> The patch works for ENOMEM inside negotiate_mq().
>>>
>>> As you mentioned, if we really hit the ENOMEM in negotiate_mq(), we
>>> might hit it in setup_blkring() as well.
>>> We should add the similar change to blkif_sring struct as well.
>>
>>
>> Won't you have a similar issue with other frontends, say, netfront?
> 
> I think the kmalloc is failed not because of OOM.
> 
> In fact, the size of "blkfront_ring_info" is large. When domU have 4
> queues/rings, the size of 4 blkfront_ring_info can be about 300+ KB.
> 
> There is chance that kmalloc() 300+ KB would fail.

So kmalloc() might not be the best choice. Any reason why you don't
change it to vmalloc()? This should address the problem in a much
simpler way.


Juergen
