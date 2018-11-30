Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C12C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A5520867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HJuL3H99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A5520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLAJAQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:00:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37570 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLAJAQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 04:00:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAULij9e170174;
        Fri, 30 Nov 2018 21:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=KB6bcAvz3mHY6f72y8ceaKifF2JdZEDZqiIZdX7WrPs=;
 b=HJuL3H99o2CGRebCnE7TJl26quphtccNUOBrAqjycktS75rZzUcIX/kxtLkY1dIz/ZWU
 OPwne2bbYFD2pGDDKpH7wV0qAB/gqmnGtRR0HmEHZdlAcB1R7hTd9uPMdDpeNuyB3aMn
 yOhZqFvlpmzVmA5rVGIOHVimokCUaXqhEsD6HQGHP4iI6PosnHxewgXjOp+rqFeEww4X
 5CnEgxVYQC2RdSFI3H5r51Pb0KrxnWcC5UbjX2a7sBBlRoFrkmQaNgX0SwhPMjIajF0c
 GCSXhQEeR5hi6RdfzHlHVIC/0zSzwBf8qaC8zlYFLVwYudY8OpJZ3VOWvyrAqRznwwmV Gg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2p2jf0qu3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 21:49:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAULnIQ1000499
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 21:49:19 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAULnIxn010035;
        Fri, 30 Nov 2018 21:49:18 GMT
Received: from [10.159.230.74] (/10.159.230.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Nov 2018 13:49:18 -0800
Subject: Re: [Xen-devel] [PATCH] xen-blkfront: use old rinfo after enomem
 during migration
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
References: <1543468665-22795-1-git-send-email-manjunath.b.patil@oracle.com>
 <fab88d94-79de-8ff4-be69-ff768b3f9697@oracle.com>
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
Organization: Oracle Corporation
Message-ID: <1dafcf3d-c3b6-e6c5-f5d4-fbdb549aaa9c@oracle.com>
Date:   Fri, 30 Nov 2018 13:49:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fab88d94-79de-8ff4-be69-ff768b3f9697@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9093 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811300185
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thank you Boris for your comments. I removed faulty email of mine.

replies inline.
On 11/30/2018 12:42 PM, Boris Ostrovsky wrote:
> On 11/29/18 12:17 AM, Manjunath Patil wrote:
>> Hi,
>> Feel free to suggest/comment on this.
>>
>> I am trying to do the following at dst during the migration now.
>> 1. Dont clear the old rinfo in blkif_free(). Instead just clean it.
>> 2. Store the old rinfo and nr_rings into temp variables in negotiate_mq()
>> 3. let nr_rings get re-calculated based on backend data
>> 4. try allocating new memory based on new nr_rings
> Since I suspect number of rings will likely be the same why not reuse
> the rings in the common case?
I thought attaching devices will be more often than migration. Hence did 
not want add to an extra check for
   - if I am inside migration code path and
   - if new nr_rings is equal to old nr_rings or not

Sure addition of such a thing would avoid the memory allocation 
altogether in migration path,
but it would add a little overhead for normal device addition.

Do you think its worth adding that change?
>
>
>> 5.
>>    a. If memory allocation is a success
>>       - free the old rinfo and proceed to use the new rinfo
>>    b. If memory allocation is a failure
>>       - use the old the rinfo
>>       - adjust the nr_rings to the lowest of new nr_rings and old nr_rings
>
>> @@ -1918,10 +1936,24 @@ static int negotiate_mq(struct blkfront_info *info)
>>   			      sizeof(struct blkfront_ring_info),
>>   			      GFP_KERNEL);
>>   	if (!info->rinfo) {
>> -		xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating ring_info structure");
>> -		info->nr_rings = 0;
>> -		return -ENOMEM;
>> -	}
>> +		if (unlikely(nr_rings_old)) {
>> +			/* We might waste some memory if
>> +			 * info->nr_rings < nr_rings_old
>> +			 */
>> +			info->rinfo = rinfo_old;
>> +			if (info->nr_rings > nr_rings_old)
>> +				info->nr_rings = nr_rings_old;
>> +			xenbus_dev_fatal(info->xbdev, -ENOMEM,
>
> Why xenbus_dev_fatal()?
I wanted to make sure that this msg is seen on console by default. So 
that we know there was a enomem event happened and we recovered from it.
What do you suggest instead? xenbus_dev_error?
>
> -boris
>
>
>> +			"reusing old ring_info structure(new ring size=%d)",
>> +				info->nr_rings);
>> +		} else {
>> +			xenbus_dev_fatal(info->xbdev, -ENOMEM,
>> +				"allocating ring_info structure");
>> +			info->nr_rings = 0;
>> +			return -ENOMEM;
>> +		}
>> +	} else if (unlikely(nr_rings_old))
>> +		kfree(rinfo_old);
>>   
>>   	for (i = 0; i < info->nr_rings; i++) {
>>   		struct blkfront_ring_info *rinfo;

