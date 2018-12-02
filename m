Return-Path: <SRS0=EAuX=OL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C00C04EB8
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 20:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DDD20851
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 20:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nchF5epz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DDD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbeLBUbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:31:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbeLBUbY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 15:31:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB2KTnOC010185;
        Sun, 2 Dec 2018 20:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uqJktl1DCrq8LhdqmMK8qNvpoIRJLFQt6X+JAWkq0YU=;
 b=nchF5epzwEuydipHlGTsFyds1679mfmA4X17gDPk0jZpz19dBomzMptlFV6WWZLBni3n
 BEI0/itmkZldZe+YZrqYy0ZmCzaMChcJeahOLEsov11F+cw25Geo9fOwA0n0Q6QAxfYk
 aleme0hNWHOAlaPCSuJc1CrqehBafEV1KpD8PDgy4PC+2ywgh7uYMjq6LxlP0+iPkjVr
 Mhd+CEurVMABqyPkdCQDbsm7MsyeOIebUUdUJL+SyRNM+bJvO+ZNS+YK67KYtZVoplfg
 WFkpVvQRgV8ZwbHd9F40Womp72JOzj9CAXaKBWbLtlqG9ErAswe5NmYxGDd+1v5ReKUW Gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxr36fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 02 Dec 2018 20:31:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB2KV99j002576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 2 Dec 2018 20:31:09 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB2KV8Oq007171;
        Sun, 2 Dec 2018 20:31:08 GMT
Received: from [10.159.153.92] (/10.159.153.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Dec 2018 20:31:08 +0000
Subject: Re: [Xen-devel] [PATCH] xen-blkfront: use old rinfo after enomem
 during migration
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
References: <1543468665-22795-1-git-send-email-manjunath.b.patil@oracle.com>
 <fab88d94-79de-8ff4-be69-ff768b3f9697@oracle.com>
 <1dafcf3d-c3b6-e6c5-f5d4-fbdb549aaa9c@oracle.com>
 <3da66993-a044-c65c-88a6-c0672ab8814f@oracle.com>
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
Organization: Oracle Corporation
Message-ID: <f187b34d-8b05-a1ce-cc96-731729a7da55@oracle.com>
Date:   Sun, 2 Dec 2018 12:31:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3da66993-a044-c65c-88a6-c0672ab8814f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9095 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812020197
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/2018 2:33 PM, Boris Ostrovsky wrote:

> On 11/30/18 4:49 PM, Manjunath Patil wrote:
>> Thank you Boris for your comments. I removed faulty email of mine.
>>
>> replies inline.
>> On 11/30/2018 12:42 PM, Boris Ostrovsky wrote:
>>> On 11/29/18 12:17 AM, Manjunath Patil wrote:
>>>> Hi,
>>>> Feel free to suggest/comment on this.
>>>>
>>>> I am trying to do the following at dst during the migration now.
>>>> 1. Dont clear the old rinfo in blkif_free(). Instead just clean it.
>>>> 2. Store the old rinfo and nr_rings into temp variables in
>>>> negotiate_mq()
>>>> 3. let nr_rings get re-calculated based on backend data
>>>> 4. try allocating new memory based on new nr_rings
>>> Since I suspect number of rings will likely be the same why not reuse
>>> the rings in the common case?
>> I thought attaching devices will be more often than migration. Hence
>> did not want add to an extra check for
>>    - if I am inside migration code path and
>>    - if new nr_rings is equal to old nr_rings or not
>>
>> Sure addition of such a thing would avoid the memory allocation
>> altogether in migration path,
>> but it would add a little overhead for normal device addition.
>>
>> Do you think its worth adding that change?
>
> IMO a couple of extra checks are not going to make much difference.
I will add this change
>
> I wonder though --- have you actually seen the case where you did fail
> allocation and changes provided in this patch made things work? I am
> asking because right after negotiate_mq() we will call setup_blkring()
> and it will want to allocate bunch of memory. A failure there is fatal
> (to ring setup). So it seems to me that you will survive negotiate_mq()
> but then will likely fail soon after.
I have noticed the ENOMEM insise negotiate_mq() on ct machine. When I 
included my patch, I manually triggered the ENOMEM using a debug flag.
The patch works for ENOMEM inside negotiate_mq().

As you mentioned, if we really hit the ENOMEM in negotiate_mq(), we 
might hit it in setup_blkring() as well.
We should add the similar change to blkif_sring struct as well.

I will make this change as well and send the new patch-set for review.
>
>>>
>>>> 5.
>>>>     a. If memory allocation is a success
>>>>        - free the old rinfo and proceed to use the new rinfo
>>>>     b. If memory allocation is a failure
>>>>        - use the old the rinfo
>>>>        - adjust the nr_rings to the lowest of new nr_rings and old
>>>> nr_rings
>>>> @@ -1918,10 +1936,24 @@ static int negotiate_mq(struct blkfront_info
>>>> *info)
>>>>                      sizeof(struct blkfront_ring_info),
>>>>                      GFP_KERNEL);
>>>>        if (!info->rinfo) {
>>>> -        xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating
>>>> ring_info structure");
>>>> -        info->nr_rings = 0;
>>>> -        return -ENOMEM;
>>>> -    }
>>>> +        if (unlikely(nr_rings_old)) {
>>>> +            /* We might waste some memory if
>>>> +             * info->nr_rings < nr_rings_old
>>>> +             */
>>>> +            info->rinfo = rinfo_old;
>>>> +            if (info->nr_rings > nr_rings_old)
>>>> +                info->nr_rings = nr_rings_old;
>>>> +            xenbus_dev_fatal(info->xbdev, -ENOMEM,
>>> Why xenbus_dev_fatal()?
>> I wanted to make sure that this msg is seen on console by default. So
>> that we know there was a enomem event happened and we recovered from it.
>> What do you suggest instead? xenbus_dev_error?
> Neither. xenbus_dev_fatal() is going to change connection state so it is
> certainly not what we want. And even xenbus_dev_error() doesn't look
> like the right thing to do since as far as block device setup is
> concerned there are no errors.
>
> Maybe pr_warn().
I will include this.

Thank you for your comments.
>
> -boris
>
>
>>> -boris
>>>
>>>
>>>> +            "reusing old ring_info structure(new ring size=%d)",
>>>> +                info->nr_rings);
>>>> +        } else {
>>>> +            xenbus_dev_fatal(info->xbdev, -ENOMEM,
>>>> +                "allocating ring_info structure");
>>>> +            info->nr_rings = 0;
>>>> +            return -ENOMEM;
>>>> +        }
>>>> +    } else if (unlikely(nr_rings_old))
>>>> +        kfree(rinfo_old);
>>>>          for (i = 0; i < info->nr_rings; i++) {
>>>>            struct blkfront_ring_info *rinfo;
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel

