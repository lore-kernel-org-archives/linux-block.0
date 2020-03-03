Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFF4C3F2CD
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AF220857
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 13:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kOqCIMSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgCCNpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:45:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCCNpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 08:45:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023DgsjP103555;
        Tue, 3 Mar 2020 13:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vwBN/g7wSj2rxEfOmHREhq/V9cF9S95isMpxJfnzWDI=;
 b=kOqCIMSRkOpz4XSkCCbWSJMyd5BxXZQibLDHCHyHiVWImArzTc+FwBGmQ5YF8z3ixX7a
 B6rdv1ZyrDk9W2jEJJCePkVPZNcMXtAuDsEymEcSsHfY26cQeYXBSHnGHpGCmcIwq+E2
 kaVo/R9o392E/PZmYFahSwA4keDIRwgDqhXpx292xp3tNi+IAMlAguQJkbD1PxMKGgBD
 56Ly9By0DtjndLdwbRBRkiItS81leDBYhLo+uojZh+C55hMOHku3c102fwE7Cr3OLRrK
 ufTVaQygOGgim+Kaa4UdOcZmQJP4YPzsQlGoFIcMMnma7RYI1kyAE5XrraV7829vroBx SA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yghn332pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 13:44:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023Dh7c2026059;
        Tue, 3 Mar 2020 13:44:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2yg1gxfu0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 13:44:45 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 023Dij8D031981;
        Tue, 3 Mar 2020 13:44:45 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 05:44:44 -0800
Subject: Re: [PATCH] blktrace: fix dereference after null check
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Cengiz Can <cengiz@kernel.wtf>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200303073358.57799-1-cengiz@kernel.wtf>
 <ec24c6d8-617f-1460-0420-bc2ac3f346c6@oracle.com>
 <20200303083523.78233c24@gandalf.local.home>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <61e6efc2-6521-5dc3-b9cf-353f52e10e2c@oracle.com>
Date:   Tue, 3 Mar 2020 21:44:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20200303083523.78233c24@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=2 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030105
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/20 9:35 PM, Steven Rostedt wrote:
> On Tue, 3 Mar 2020 21:29:08 +0800
> Bob Liu <bob.liu@oracle.com> wrote:
> 
>> On 3/3/20 3:33 PM, Cengiz Can wrote:
>>> There was a recent change in blktrace.c that added a RCU protection to
>>> `q->blk_trace` in order to fix a use-after-free issue during access.
>>>
>>> However the change missed an edge case that can lead to dereferencing of
>>> `bt` pointer even when it's NULL:
>>>
>>> ```
>>>         bt->act_mask = value; // bt can still be NULL here
>>> ```
>>>
>>> Added a reassignment into the NULL check block to fix the issue.
>>>
>>> Fixes: c780e86dd48 ("blktrace: Protect q->blk_trace with RCU")
>>>
>>> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
>>> ---
>>>  Huge thanks goes to Steven Rostedt for his assistance.
>>>
>>>  kernel/trace/blktrace.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
>>> index 4560878f0bac..29ea88f10b87 100644
>>> --- a/kernel/trace/blktrace.c
>>> +++ b/kernel/trace/blktrace.c
>>> @@ -1896,8 +1896,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>>>  	}
>>>
>>>  	ret = 0;
>>> -	if (bt == NULL)
>>> +	if (bt == NULL) {
>>>  		ret = blk_trace_setup_queue(q, bdev);
>>> +		bt = q->blk_trace;  
>>
>> The return value 'ret' should be judged, it's wrong to set 'bt' if blk_trace_setup_queue()
>> return failure.
> 
> Why? If ret is an error, q is still valid, and bt would just be garbage. bt
> is ignored below if ret is anything but zero. Why add an unnecessary if
> condition here?
>

Oh..yes. You are right, sorry for missed the if (ret == 0) below.

Reviewed-by: Bob Liu <bob.liu@oracle.com>

> That said, the bt assignment still needs rcu annotation:
> > 		bt = rcu_dereference_protected(q->blk_trace,
> 				lockdep_is_held(&q->blk_trace_mutex));
> 
> -- Steve
> 
> 
>>
>>> +	}
>>>
>>>  	if (ret == 0) {
>>>  		if (attr == &dev_attr_act_mask)
>>> --
>>> 2.25.1
>>>   
> 

