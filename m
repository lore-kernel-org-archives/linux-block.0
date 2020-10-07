Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D053C4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBD0212CC
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QMKclFhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgJGOdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:33:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728535AbgJGOdp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Oct 2020 10:33:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097E7fXw091236;
        Wed, 7 Oct 2020 10:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vDTD/PVLSpMOzc27rVeGmqr8Buz9bIX61olcH7mjtUo=;
 b=QMKclFhlobLj1MzghLysomc0k6zX9zm/R6e9XH7h9tkrHVu1NfgfwJZ/0SjKMMcYjl42
 +fM+Eb5Y2P8mOtn52kvg0qUjHfOc8h27kD2iPtDHz2sN3FObAG83jp9w2+32XJCScfdG
 MKOOw3MRHN8N4BjjHD/agUKZiB11Oz0lkcUVTvdsqf7VbfBkU/UUUzPlQwyS2rocNXbq
 Q3BSetR/YEEW4R2HfEsNLW6djJpRP7bRpW/N4TJPVdR/9a7KOXhH1Zo0MjnKl7305+wp
 4mKBFmCZbnCeNfAty8ZiXPS8t2nbE/MkBwS1s+vXq6tiOHSYdsRxLbMc78whSe2EGMWN uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341ewm9jhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 10:33:43 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 097E92i4099377;
        Wed, 7 Oct 2020 10:33:43 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341ewm9jft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 10:33:43 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097EXf2i011763;
        Wed, 7 Oct 2020 14:33:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 33xgjh4cw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 14:33:41 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 097EXcGM26804574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Oct 2020 14:33:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46E9311C052;
        Wed,  7 Oct 2020 14:33:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE45111C04C;
        Wed,  7 Oct 2020 14:33:37 +0000 (GMT)
Received: from [9.145.183.254] (unknown [9.145.183.254])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Oct 2020 14:33:37 +0000 (GMT)
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
From:   =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Message-ID: <243fe10e-ce80-57de-a92c-3a6457cde40a@linux.ibm.com>
Date:   Wed, 7 Oct 2020 16:33:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007114928.6a088a7d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_09:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=2 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070090
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

... snip ...
>>>   
>>>> +static struct kobj_type path_attr_type = {
>>>> +	.release	= dasd_path_release,  
>>>
>>> This function does nothing; I think there's something wrong with your
>>> kobject handling?  
>>
>> Explanation below.
>>
>>>   
>>>> +	.default_attrs	= paths_info_attrs,
>>>> +	.sysfs_ops	= &kobj_sysfs_ops,
>>>> +};
>>>> +
>>>> +static void dasd_path_init_kobj(struct dasd_device *device, int chp)
>>>> +{
>>>> +	device->path[chp].kobj.kset = device->paths_info;
>>>> +	kobject_init(&device->path[chp].kobj, &path_attr_type);  
>>>
>>> This inits a static kobject; as you never free it, doesn't the code  
>>
>> kobject_put() frees the kobject data.
> 
> Not quite; if the last ref is put, it invokes the provided ->release
> callback and frees the allocated name. If the ->release callback does
> not free the object embedding the kobject, only the name is freed
> AFAICS.
> 

True, the rest is freed when the device is being destroyed with
dasd_free_device().

>>
>>> moan about state_initialized if you try to do that a second time?  
>>
>> No, because we check whether we have this kobject already present
>> in sysfs before we try to initialize it (we have in_sysfs per path
>> object for this).
> 
> I might be confused by the path revalidation logic; but don't you unset
> in_sysfs when you remove the path object? What happens when you readd it?

We set it to true again (See dasd_path_create_kobj()). (More details below)

> 
>>
>>>   
>>>> +}
>>>> +
>>>> +void dasd_path_create_kobj(struct dasd_device *device, int chp)
>>>> +{
>>>> +	int rc;
>>>> +
>>>> +	if (test_bit(DASD_FLAG_OFFLINE, &device->flags))
>>>> +		return;
>>>> +	if (!device->paths_info) {
>>>> +		dev_warn(&device->cdev->dev, "Unable to create paths objects\n");  
>>>
>>> I guess this warns every time you come along here, is warning more than
>>> once useful?
>>>   
>>
>> paths_info is a kset created during the device initialization. Do you mean,
>> in case the kset creation fails, this check here should only warn once?
>> I'm not sure about that, hm.
> 
> If the kset could not be set up during init, you'll hit this for every
> path object you want to add afterwards -- one warning per device of
> that should be enough, I guess :)

I think this could be changed to one warning.

> 
>>
>>>> +		return;
>>>> +	}
>>>> +	if (device->path[chp].in_sysfs)
>>>> +		return;
>>>> +	if (!device->path[chp].conf_data)  
>>>
>>> Out of interest: Have you tried this with vfio-ccw under QEMU, where
>>> some information is simply not available?  
>>
>> I did not, sorry.
>>
>>>   
>>>> +		return;
>>>> +
>>>> +	dasd_path_init_kobj(device, chp);
>>>> +
>>>> +	rc = kobject_add(&device->path[chp].kobj, NULL, "%x.%02x",
>>>> +			 device->path[chp].cssid, device->path[chp].chpid);
>>>> +	if (rc)
>>>> +		kobject_put(&device->path[chp].kobj);  
>>>
>>> This will eventually lead to the nop release function, which doesn't
>>> unset state_initialized (see above) -- but OTOH, it shouldn't muck
>>> around with kobject internals anyway.  
>>
>> The release function is supposed to free memory of the structure where
>> the kobject lies in (our release function is explained below).
>> The rest is taking care of by the kobject library.
> 
> Yes, but the kobject code does not unset state_initialized.
>>
>>>
>>> I think the kobjects really want to be dynamically allocated; instead
>>> of going through a remove/add cycle, is there a way to make path
>>> objects "invisible" instead? Or add an "available" attribute, and error
>>> out reading any other attribute?
> 
>>> (...)
>>>   
>>>> +static inline void dasd_path_release(struct kobject *kobj)
>>>> +{
>>>> +/* Memory for the dasd_path kobject is freed when dasd_free_device() is called */
>>>> +}
>>>> +  
>>>
>>> As already said, I don't think that's a correct way to implement this.
>>>   
>>
>> As you correctly pointed out, our release function doesn't do anything.
>> This is because our path data is a (static) part of our device.
>> This data is critical to keep our devices operational.
>> We can't simply rely on allocated memory if systems are under stress. 
> 
> Yes, avoiding freeing and reallocating memory certainly makes sense.
> 
>>
>> Having this data dynamically allocated involves a lot of rework of our
>> path handling as well. There are a few things that are subject to improvement
>> and evaluating whether our dasd_path structures can be dynamic is one of
>> these things. However, even then, the above concern persists and I
>> highly doubt that dynamic dasd_paths objects are doable for us at this
>> moment.
>>
>> I do understand the concerns, however, we release the memory for dasd_path
>> structures eventually when dasd_free_device() is called. Until that point,
>> the data has to be kept alive. The rest is taking care of by the kobject
>> library.
> 
> Yes, there doesn't seem to be any memory leakage.
> 
>> In our path handling we also make sure that we can always verify/validate
>> paths information even if a system is under high memory pressure. Another
>> reason why it would contradictory for dasd_path objects to be dynamic.
>>
>> I hope this explains the reasoning behind the release function.
> 
> I understand where you're coming from.
> 
> However, "static" kobjects (in the sense of "we may re-register the
> same kobject") are still problematic. Is there any way to simply
> "disappear" path objects that are not valid at the moment, or mark them
> as not valid?

You could use kobject_del(), but it is rather intended to be used for
a two-stage removal of the kobject.

> 
> Also, the simple act of registering/unregistering a kobject already
> creates stress from its sysfs interactions... it seems you should try
> to avoid that as well?
> 

We don't re-register kobjects over and over again. The kobjects are
infact initialized and created only _once_. This is done either during
device initialization (after dasd_eckd_read_conf() in
dasd_eckd_check_characteristics()) or when a path is newly added
(in the path event handler).
The kobject will stay until the memory for the whole device is being
freed. This is also the reason why the kobject can stay initialized and
we track ourselves whether we did the initialization/creation already
(which we check e.g. when a path is removed and added again).
So, instead of the release function freeing the kobject data,
it is done by our dasd_free_device() (same thing, different function IMHO).

I think the concerns would be more worrisome if we'd remove/add
the kobjects every time. And then I agree, we'd run into trouble.
