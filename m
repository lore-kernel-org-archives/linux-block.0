Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F7AC04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 03:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3052B20850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 03:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ry7fs3NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3052B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLDDPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:15:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55158 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLDDPK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 22:15:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB433qFQ185240;
        Tue, 4 Dec 2018 03:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=O/bmHXB/4hGvDr+tIEUirjVWJjCDsFOg3OiFz19hbIU=;
 b=Ry7fs3NOGpIn+A1RpE2vrw0DLEG8LHQS6dvw4XrCTT9L8FoHwlWCEJRhChh+JKDRQfzh
 XIiT+lPYehru1kM6Ogl21SNUI/LXEmywk37h3cA3rldTtKdHQw+IsGA7TFHppJmutEaZ
 +ydRZYwQkNJwIPrJOO+NfOu77IRewkOfqs/Hfz8k0AZvtm/aF7S/6hHkX7ckiB8nTZ3S
 z1O+eCj5O2SydzDtdbZLyo+0Q5uwtZzdEs3njTSbyWk9jq6hE0JcXsbPZDpHGwYa8Yuf
 fw64JkMi71kvLlSv9B7HGs1NosJ88aRU0AMVvLdqSxaWthD1Vj4s0qHZfJjY1PUdG6cz qg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p3jxr9trg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 03:15:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB43F0Uw024937
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 03:15:01 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB43F088012801;
        Tue, 4 Dec 2018 03:15:00 GMT
Received: from [10.182.71.9] (/10.182.71.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 03:14:59 +0000
Subject: Re: [Xen-devel] [PATCH] xen-blkfront: use old rinfo after enomem
 during migration
To:     Manjunath Patil <manjunath.b.patil@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk
References: <1543468665-22795-1-git-send-email-manjunath.b.patil@oracle.com>
 <fab88d94-79de-8ff4-be69-ff768b3f9697@oracle.com>
 <1dafcf3d-c3b6-e6c5-f5d4-fbdb549aaa9c@oracle.com>
 <3da66993-a044-c65c-88a6-c0672ab8814f@oracle.com>
 <f187b34d-8b05-a1ce-cc96-731729a7da55@oracle.com>
 <ee73815a-3b0c-bb3e-bd52-239c9b3d8cc0@oracle.com>
 <5cdcbb60-d862-b3c7-2869-4961c5565dfa@oracle.com>
 <d16b1282-623a-f834-6e43-21098953a329@oracle.com>
 <6a470f6c-d12a-1431-d5e1-eaf71fe28682@oracle.com>
Cc:     linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <31f8d261-e840-e38d-6f52-a3f14f7a2908@oracle.com>
Date:   Tue, 4 Dec 2018 11:17:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <6a470f6c-d12a-1431-d5e1-eaf71fe28682@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040025
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Manjunath,

On 12/04/2018 10:49 AM, Manjunath Patil wrote:
> On 12/3/2018 6:16 PM, Boris Ostrovsky wrote:
> 
>> On 12/3/18 8:14 PM, Dongli Zhang wrote:
>>> Hi Boris,
>>>
>>> On 12/04/2018 12:07 AM, Boris Ostrovsky wrote:
>>>> On 12/2/18 3:31 PM, Manjunath Patil wrote:
>>>>> On 11/30/2018 2:33 PM, Boris Ostrovsky wrote:
>>>>>
>>>>>> On 11/30/18 4:49 PM, Manjunath Patil wrote:
>>>>>>> Thank you Boris for your comments. I removed faulty email of mine.
>>>>>>>
>>>>>>> replies inline.
>>>>>>> On 11/30/2018 12:42 PM, Boris Ostrovsky wrote:
>>>>>>>> On 11/29/18 12:17 AM, Manjunath Patil wrote:
>>>>>>>>> Hi,
>>>>>>>>> Feel free to suggest/comment on this.
>>>>>>>>>
>>>>>>>>> I am trying to do the following at dst during the migration now.
>>>>>>>>> 1. Dont clear the old rinfo in blkif_free(). Instead just clean it.
>>>>>>>>> 2. Store the old rinfo and nr_rings into temp variables in
>>>>>>>>> negotiate_mq()
>>>>>>>>> 3. let nr_rings get re-calculated based on backend data
>>>>>>>>> 4. try allocating new memory based on new nr_rings
>>>>>>>> Since I suspect number of rings will likely be the same why not reuse
>>>>>>>> the rings in the common case?
>>>>>>> I thought attaching devices will be more often than migration. Hence
>>>>>>> did not want add to an extra check for
>>>>>>>     - if I am inside migration code path and
>>>>>>>     - if new nr_rings is equal to old nr_rings or not
>>>>>>>
>>>>>>> Sure addition of such a thing would avoid the memory allocation
>>>>>>> altogether in migration path,
>>>>>>> but it would add a little overhead for normal device addition.
>>>>>>>
>>>>>>> Do you think its worth adding that change?
>>>>>> IMO a couple of extra checks are not going to make much difference.
>>>>> I will add this change
>>>>>> I wonder though --- have you actually seen the case where you did fail
>>>>>> allocation and changes provided in this patch made things work? I am
>>>>>> asking because right after negotiate_mq() we will call setup_blkring()
>>>>>> and it will want to allocate bunch of memory. A failure there is fatal
>>>>>> (to ring setup). So it seems to me that you will survive negotiate_mq()
>>>>>> but then will likely fail soon after.
>>>>> I have noticed the ENOMEM insise negotiate_mq() on ct machine. When I
>>>>> included my patch, I manually triggered the ENOMEM using a debug flag.
>>>>> The patch works for ENOMEM inside negotiate_mq().
>>>>>
>>>>> As you mentioned, if we really hit the ENOMEM in negotiate_mq(), we
>>>>> might hit it in setup_blkring() as well.
>>>>> We should add the similar change to blkif_sring struct as well.
>>>> Won't you have a similar issue with other frontends, say, netfront?
>>> I think the kmalloc is failed not because of OOM.
>>>
>>> In fact, the size of "blkfront_ring_info" is large. When domU have 4
>>> queues/rings, the size of 4 blkfront_ring_info can be about 300+ KB.
>>>
>>> There is chance that kmalloc() 300+ KB would fail.
>>>
>>>
>>> About netfront, to kmalloc() 8 'struct netfront_queue' seems consumes <70 KB?
>> TBH these look like comparable sizes to me.  I am not convinced that
>> these changes will make a difference. If the number of rings on source
>> and destination were the same I'd absolutely agree with this patch but
>> since you are trying to handle different sizes the code becomes somewhat
>> more complex, and I am not sure it's worth it. (Can you actually give me
>> an example of when we can expect number of rings to change during
>> migration?)
>>
>> But others may think differently.
> Hi Boris,
> I think allocation of 300KB chunk[order 7 allocation] is more likely to fail
> than 70KB[order 5] especially under memory pressure.
> If it comes to that, I think we should fix this too.
> 
> The no.of rings in most cases remain 4 thanks to xen_blkif_max_queues module
> parameter.
> If the src host has allocated less than 4[may be vpcu given to this dom0 were
> less than 4], then we can expect the dst to allocate more than src side and vice
> versa.

xen_blkif_max_queues is tunable so the size to kmalloc() would be larger when
both xen_blkif_max_queues and dom0 vcpu are large.

Dongli Zhang
