Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375B3C4363C
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 20:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54142083B
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 20:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q5eWdeLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgJGUKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 16:10:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727657AbgJGUKT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Oct 2020 16:10:19 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097K32jL190351;
        Wed, 7 Oct 2020 16:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p/h6W+8bNgsf8JrMgBR/9A8eDqIvgXGhoHo0a39nb+A=;
 b=q5eWdeLySPFKJSNZ+TCse5KbcQYVjOLbWnp18Lspm9ie28m1ist8qSQos0kDJyp7yz12
 BC8Eh+8FhM00TNj0fFHkSgUYuB6hpUXgMRiFfQtgJhHgLBmGsxip0oGARIEIyfRn41GG
 B1AXp+BdKHFhDov0EG0D6/+z2d+/SSQejiZRdHP+ZBdeLLQdgCd+FKdET0vvAWXgPckp
 pK2bdA042oL5AikBXqY5wNvycbfOAhDiOyyztc4Hq0SzXDKLeK08jYBdEBwtNFVXJHOY
 cw92Vqh0YgU+qbMAlRa3cXNmx3y7bmmz3Jv98lsoYTlItlISEk6+C/dq5Hw+YJWkljXg 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341kd79s48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 16:10:18 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 097K3fsi191653;
        Wed, 7 Oct 2020 16:10:17 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341kd79s3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 16:10:17 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097K6duf019502;
        Wed, 7 Oct 2020 20:10:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 33xgx82ds5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 20:10:14 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 097KABIl33620234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Oct 2020 20:10:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B91355204E;
        Wed,  7 Oct 2020 20:10:11 +0000 (GMT)
Received: from [9.145.166.36] (unknown [9.145.166.36])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5EE7F5204F;
        Wed,  7 Oct 2020 20:10:11 +0000 (GMT)
Subject: Re: [PATCH 08/10] s390/dasd: Display FC Endpoint Security information
 via sysfs
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
References: <20201002193940.24012-1-sth@linux.ibm.com>
 <20201002193940.24012-9-sth@linux.ibm.com>
 <20201006122632.098149ba.cohuck@redhat.com>
 <d88b8230-993e-d63d-394a-efcaf60f813d@linux.ibm.com>
 <20201007114928.6a088a7d.cohuck@redhat.com>
 <243fe10e-ce80-57de-a92c-3a6457cde40a@linux.ibm.com>
 <20201007184011.6dece07f.cohuck@redhat.com>
From:   =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Message-ID: <702cf75e-5193-92d3-79a7-182ac86df16e@linux.ibm.com>
Date:   Wed, 7 Oct 2020 22:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007184011.6dece07f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-07,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=2 impostorscore=0
 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070127
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/20 6:40 PM, Cornelia Huck wrote:
> On Wed, 7 Oct 2020 16:33:37 +0200
> Jan Höppner <hoeppner@linux.ibm.com> wrote:
> 
>>>>>> +static inline void dasd_path_release(struct kobject *kobj)
>>>>>> +{
>>>>>> +/* Memory for the dasd_path kobject is freed when dasd_free_device() is called */
>>>>>> +}
>>>>>> +    
>>>>>
>>>>> As already said, I don't think that's a correct way to implement this.
>>>>>     
>>>>
>>>> As you correctly pointed out, our release function doesn't do anything.
>>>> This is because our path data is a (static) part of our device.
>>>> This data is critical to keep our devices operational.
>>>> We can't simply rely on allocated memory if systems are under stress.   
>>>
>>> Yes, avoiding freeing and reallocating memory certainly makes sense.
>>>   
>>>>
>>>> Having this data dynamically allocated involves a lot of rework of our
>>>> path handling as well. There are a few things that are subject to improvement
>>>> and evaluating whether our dasd_path structures can be dynamic is one of
>>>> these things. However, even then, the above concern persists and I
>>>> highly doubt that dynamic dasd_paths objects are doable for us at this
>>>> moment.
>>>>
>>>> I do understand the concerns, however, we release the memory for dasd_path
>>>> structures eventually when dasd_free_device() is called. Until that point,
>>>> the data has to be kept alive. The rest is taking care of by the kobject
>>>> library.  
>>>
>>> Yes, there doesn't seem to be any memory leakage.
>>>   
>>>> In our path handling we also make sure that we can always verify/validate
>>>> paths information even if a system is under high memory pressure. Another
>>>> reason why it would contradictory for dasd_path objects to be dynamic.
>>>>
>>>> I hope this explains the reasoning behind the release function.  
>>>
>>> I understand where you're coming from.
>>>
>>> However, "static" kobjects (in the sense of "we may re-register the
>>> same kobject") are still problematic. Is there any way to simply
>>> "disappear" path objects that are not valid at the moment, or mark them
>>> as not valid?  
>>
>> You could use kobject_del(), but it is rather intended to be used for
>> a two-stage removal of the kobject.
>>
>>>
>>> Also, the simple act of registering/unregistering a kobject already
>>> creates stress from its sysfs interactions... it seems you should try
>>> to avoid that as well?
>>>   
>>
>> We don't re-register kobjects over and over again. The kobjects are
>> infact initialized and created only _once_. This is done either during
>> device initialization (after dasd_eckd_read_conf() in
>> dasd_eckd_check_characteristics()) or when a path is newly added
>> (in the path event handler).
>> The kobject will stay until the memory for the whole device is being
>> freed. This is also the reason why the kobject can stay initialized and
>> we track ourselves whether we did the initialization/creation already
>> (which we check e.g. when a path is removed and added again).
>> So, instead of the release function freeing the kobject data,
>> it is done by our dasd_free_device() (same thing, different function IMHO).
>>
>> I think the concerns would be more worrisome if we'd remove/add
>> the kobjects every time. And then I agree, we'd run into trouble.
>>
> 
> The thing that tripped me is
> 
> +void dasd_path_remove_kobj(struct dasd_device *device, int chp)
> +{
> +	if (device->path[chp].in_sysfs) {
> +		kobject_put(&device->path[chp].kobj);
> +		device->path[chp].in_sysfs = false;
> +	}
> +}
> 
> As an exported function, it is not clear where this may be called from.
> Given your explanation above (and some more code reading on my side),
> the code looks ok in its current incarnation (but non-idiomatic).
> 
> Is there a way to check that indeed nobody re-adds a previously removed
> path object due to a (future) programming error? And maybe add a
> comment that you must never re-register a path? "The path is gone,
> let's remove the object" looks quite tempting.
> 

A comment is the minimum I can think of at the moment and
I'll prepare a fixup patch or a new version of this patch that adds
a proper comment for this function.
Other ways to protect the usage must be investigated. 
I have to discuss with Stefan what the best approach would be as the patchset
is supposed to be ready for upstream integration.

I'd prefer a fixup patch that we could send with at least one more fixup patch
that we have in the pipe already. Let's see. I hope that's fine with you
(and Jens obviously) so far.

regards,
Jan
