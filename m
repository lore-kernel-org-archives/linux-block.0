Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3488BC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A5C20863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s9S6x3Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A5C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLAJor (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:44:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48942 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLAJor (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 04:44:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAUMTgYv161614;
        Fri, 30 Nov 2018 22:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ckz0jf49lrW+K58C+Olae2l5F9GWsEOqr7k4GDBRhaU=;
 b=s9S6x3Q77fCp8wsqX3JvGssXYhginm1XRwxM/tAoK9q0DDwc0MvKj6THNW3ByFEN5JJ0
 3eIm3GcdbShtTwSzWK/4WiYJX2zidCjOPzCQuLLZ8OwUPKY0eyI1kYA/ArZ46D/cSy9L
 H5+VkHk5r512RG9FFexPXVCBbj/uKbC7+3f8y0adBsRFh3LP6s1t7lu7atmdNzva7bu+
 Pc7K6U52BQMIBeWcSqcoENLSxfXP9UuoVHmdaCOaVcf2fbSs7vrKYHjx+ZMBrteLKS3U
 fC1TLU+hotbvam77o6VzlEovMszCB7XHnak3L4LLgq3e6K3JptmdqqrAF+CBP8zhsItL wA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nxy9rrn3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 22:33:49 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAUMXmfk008851
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 22:33:48 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAUMXmlt013335;
        Fri, 30 Nov 2018 22:33:48 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Nov 2018 14:33:48 -0800
Subject: Re: [Xen-devel] [PATCH] xen-blkfront: use old rinfo after enomem
 during migration
To:     Manjunath Patil <manjunath.b.patil@oracle.com>, jgross@suse.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
References: <1543468665-22795-1-git-send-email-manjunath.b.patil@oracle.com>
 <fab88d94-79de-8ff4-be69-ff768b3f9697@oracle.com>
 <1dafcf3d-c3b6-e6c5-f5d4-fbdb549aaa9c@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <3da66993-a044-c65c-88a6-c0672ab8814f@oracle.com>
Date:   Fri, 30 Nov 2018 17:33:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1dafcf3d-c3b6-e6c5-f5d4-fbdb549aaa9c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9093 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811300190
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 4:49 PM, Manjunath Patil wrote:
> Thank you Boris for your comments. I removed faulty email of mine.
>
> replies inline.
> On 11/30/2018 12:42 PM, Boris Ostrovsky wrote:
>> On 11/29/18 12:17 AM, Manjunath Patil wrote:
>>> Hi,
>>> Feel free to suggest/comment on this.
>>>
>>> I am trying to do the following at dst during the migration now.
>>> 1. Dont clear the old rinfo in blkif_free(). Instead just clean it.
>>> 2. Store the old rinfo and nr_rings into temp variables in
>>> negotiate_mq()
>>> 3. let nr_rings get re-calculated based on backend data
>>> 4. try allocating new memory based on new nr_rings
>> Since I suspect number of rings will likely be the same why not reuse
>> the rings in the common case?
> I thought attaching devices will be more often than migration. Hence
> did not want add to an extra check for
>   - if I am inside migration code path and
>   - if new nr_rings is equal to old nr_rings or not
>
> Sure addition of such a thing would avoid the memory allocation
> altogether in migration path,
> but it would add a little overhead for normal device addition.
>
> Do you think its worth adding that change?


IMO a couple of extra checks are not going to make much difference.

I wonder though --- have you actually seen the case where you did fail
allocation and changes provided in this patch made things work? I am
asking because right after negotiate_mq() we will call setup_blkring()
and it will want to allocate bunch of memory. A failure there is fatal
(to ring setup). So it seems to me that you will survive negotiate_mq()
but then will likely fail soon after.


>>
>>
>>> 5.
>>>    a. If memory allocation is a success
>>>       - free the old rinfo and proceed to use the new rinfo
>>>    b. If memory allocation is a failure
>>>       - use the old the rinfo
>>>       - adjust the nr_rings to the lowest of new nr_rings and old
>>> nr_rings
>>
>>> @@ -1918,10 +1936,24 @@ static int negotiate_mq(struct blkfront_info
>>> *info)
>>>                     sizeof(struct blkfront_ring_info),
>>>                     GFP_KERNEL);
>>>       if (!info->rinfo) {
>>> -        xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating
>>> ring_info structure");
>>> -        info->nr_rings = 0;
>>> -        return -ENOMEM;
>>> -    }
>>> +        if (unlikely(nr_rings_old)) {
>>> +            /* We might waste some memory if
>>> +             * info->nr_rings < nr_rings_old
>>> +             */
>>> +            info->rinfo = rinfo_old;
>>> +            if (info->nr_rings > nr_rings_old)
>>> +                info->nr_rings = nr_rings_old;
>>> +            xenbus_dev_fatal(info->xbdev, -ENOMEM,
>>
>> Why xenbus_dev_fatal()?
> I wanted to make sure that this msg is seen on console by default. So
> that we know there was a enomem event happened and we recovered from it.
> What do you suggest instead? xenbus_dev_error?

Neither. xenbus_dev_fatal() is going to change connection state so it is
certainly not what we want. And even xenbus_dev_error() doesn't look
like the right thing to do since as far as block device setup is
concerned there are no errors.

Maybe pr_warn().

-boris


>>
>> -boris
>>
>>
>>> +            "reusing old ring_info structure(new ring size=%d)",
>>> +                info->nr_rings);
>>> +        } else {
>>> +            xenbus_dev_fatal(info->xbdev, -ENOMEM,
>>> +                "allocating ring_info structure");
>>> +            info->nr_rings = 0;
>>> +            return -ENOMEM;
>>> +        }
>>> +    } else if (unlikely(nr_rings_old))
>>> +        kfree(rinfo_old);
>>>         for (i = 0; i < info->nr_rings; i++) {
>>>           struct blkfront_ring_info *rinfo;
>

