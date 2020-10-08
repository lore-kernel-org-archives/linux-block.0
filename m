Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC43C43467
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 11:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D27215A4
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 11:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L2ktugXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgJHLE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 07:04:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbgJHLE6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 07:04:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098B3CRW060052;
        Thu, 8 Oct 2020 07:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ygHhJ+k9Xgc6Yv6v2BUMeYd2RGOiavfQh4VBmKc4WR0=;
 b=L2ktugXytLzjjC2ux2atzd/7A31BJcJ625370iWlcRBbQvmbPysDrgNbLcvTjquSo02b
 YQf4LK2MUi/70hBs0g3ReSMr2Ek7shYVkimyEKBpVyJp/mGhELrmJ2AsssOvqdPMpQkt
 xu6i601ztdoQLVBCSaKlTnyxEtmtotaH6HbJDqtFPEZRjkZrhJulcD7+YrHobxeV8oap
 GjtndqqN6yYIVVXl9KJYwGtRFnX3rfMkMWOzlS3dOpig3CjyQMeb0DJH+IHDiXtfbH05
 KqUvNmYpC6ApmO2KIBLZI7dtMcfCKpCl+eIYSGrzxrxfyTbyNNKNZiOvBfypGKI1pgfe xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3421by8dg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 07:04:55 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 098B3VDk061799;
        Thu, 8 Oct 2020 07:04:55 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3421by8dfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 07:04:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098B1SYl022617;
        Thu, 8 Oct 2020 11:04:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 33xgx858kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 11:04:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098B4o3L30343652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 11:04:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7480352057;
        Thu,  8 Oct 2020 11:04:50 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.40.105])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2C72952059;
        Thu,  8 Oct 2020 11:04:50 +0000 (GMT)
Subject: Re: [PATCH 08/10] s390/dasd: Display FC Endpoint Security information
 via sysfs
To:     Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20201002193940.24012-1-sth@linux.ibm.com>
 <20201002193940.24012-9-sth@linux.ibm.com>
 <20201006122632.098149ba.cohuck@redhat.com>
 <d88b8230-993e-d63d-394a-efcaf60f813d@linux.ibm.com>
 <20201007114928.6a088a7d.cohuck@redhat.com>
 <243fe10e-ce80-57de-a92c-3a6457cde40a@linux.ibm.com>
 <20201007184011.6dece07f.cohuck@redhat.com>
 <702cf75e-5193-92d3-79a7-182ac86df16e@linux.ibm.com>
 <20201008090319.4161c220.cohuck@redhat.com>
From:   Stefan Haberland <sth@linux.ibm.com>
Autocrypt: addr=sth@linux.ibm.com; keydata=
 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
 cH4TNHyhiR0KAbxE8qKx3Jc=
Message-ID: <98443e35-081f-12cf-9dd1-3078dcc1d015@linux.ibm.com>
Date:   Thu, 8 Oct 2020 13:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008090319.4161c220.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_07:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=2 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010080077
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 08.10.20 um 09:03 schrieb Cornelia Huck:
> On Wed, 7 Oct 2020 22:10:11 +0200
> Jan Höppner <hoeppner@linux.ibm.com> wrote:
>
>> On 10/7/20 6:40 PM, Cornelia Huck wrote:
>>> On Wed, 7 Oct 2020 16:33:37 +0200
>>> Jan Höppner <hoeppner@linux.ibm.com> wrote:
>>>   
>>>>>>>> +static inline void dasd_path_release(struct kobject *kobj)
>>>>>>>> +{
>>>>>>>> +/* Memory for the dasd_path kobject is freed when dasd_free_device() is called */
>>>>>>>> +}
>>>>>>>> +      
>>>>>>> As already said, I don't think that's a correct way to implement this.
>>>>>>>       
>>>>>> As you correctly pointed out, our release function doesn't do anything.
>>>>>> This is because our path data is a (static) part of our device.
>>>>>> This data is critical to keep our devices operational.
>>>>>> We can't simply rely on allocated memory if systems are under stress.     
>>>>> Yes, avoiding freeing and reallocating memory certainly makes sense.
>>>>>     
>>>>>> Having this data dynamically allocated involves a lot of rework of our
>>>>>> path handling as well. There are a few things that are subject to improvement
>>>>>> and evaluating whether our dasd_path structures can be dynamic is one of
>>>>>> these things. However, even then, the above concern persists and I
>>>>>> highly doubt that dynamic dasd_paths objects are doable for us at this
>>>>>> moment.
>>>>>>
>>>>>> I do understand the concerns, however, we release the memory for dasd_path
>>>>>> structures eventually when dasd_free_device() is called. Until that point,
>>>>>> the data has to be kept alive. The rest is taking care of by the kobject
>>>>>> library.    
>>>>> Yes, there doesn't seem to be any memory leakage.
>>>>>     
>>>>>> In our path handling we also make sure that we can always verify/validate
>>>>>> paths information even if a system is under high memory pressure. Another
>>>>>> reason why it would contradictory for dasd_path objects to be dynamic.
>>>>>>
>>>>>> I hope this explains the reasoning behind the release function.    
>>>>> I understand where you're coming from.
>>>>>
>>>>> However, "static" kobjects (in the sense of "we may re-register the
>>>>> same kobject") are still problematic. Is there any way to simply
>>>>> "disappear" path objects that are not valid at the moment, or mark them
>>>>> as not valid?    
>>>> You could use kobject_del(), but it is rather intended to be used for
>>>> a two-stage removal of the kobject.
>>>>  
>>>>> Also, the simple act of registering/unregistering a kobject already
>>>>> creates stress from its sysfs interactions... it seems you should try
>>>>> to avoid that as well?
>>>>>     
>>>> We don't re-register kobjects over and over again. The kobjects are
>>>> infact initialized and created only _once_. This is done either during
>>>> device initialization (after dasd_eckd_read_conf() in
>>>> dasd_eckd_check_characteristics()) or when a path is newly added
>>>> (in the path event handler).
>>>> The kobject will stay until the memory for the whole device is being
>>>> freed. This is also the reason why the kobject can stay initialized and
>>>> we track ourselves whether we did the initialization/creation already
>>>> (which we check e.g. when a path is removed and added again).
>>>> So, instead of the release function freeing the kobject data,
>>>> it is done by our dasd_free_device() (same thing, different function IMHO).
>>>>
>>>> I think the concerns would be more worrisome if we'd remove/add
>>>> the kobjects every time. And then I agree, we'd run into trouble.
>>>>  
>>> The thing that tripped me is
>>>
>>> +void dasd_path_remove_kobj(struct dasd_device *device, int chp)
>>> +{
>>> +	if (device->path[chp].in_sysfs) {
>>> +		kobject_put(&device->path[chp].kobj);
>>> +		device->path[chp].in_sysfs = false;
>>> +	}
>>> +}
>>>
>>> As an exported function, it is not clear where this may be called from.
>>> Given your explanation above (and some more code reading on my side),
>>> the code looks ok in its current incarnation (but non-idiomatic).
>>>
>>> Is there a way to check that indeed nobody re-adds a previously removed
>>> path object due to a (future) programming error? And maybe add a
>>> comment that you must never re-register a path? "The path is gone,
>>> let's remove the object" looks quite tempting.
>>>   
>> A comment is the minimum I can think of at the moment and
>> I'll prepare a fixup patch or a new version of this patch that adds
>> a proper comment for this function.
>> Other ways to protect the usage must be investigated. 
>> I have to discuss with Stefan what the best approach would be as the patchset
>> is supposed to be ready for upstream integration.
>>
>> I'd prefer a fixup patch that we could send with at least one more fixup patch
>> that we have in the pipe already. Let's see. I hope that's fine with you
>> (and Jens obviously) so far.
> Fine with me. I don't really have a horse in that race; I just wanted
> to look at this from a vfio-ccw perspective and then stumbled over the
> kobject handling...
>

Thanks for this. I will send a v2 shortly.

