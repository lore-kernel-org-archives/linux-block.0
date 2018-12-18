Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04BDC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 15:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3520815
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 15:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sJ0cZmWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeLRP3e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:29:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52406 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeLRP3e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 10:29:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIFTTp3041264;
        Tue, 18 Dec 2018 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=niJuTMJE7sALPAy3HHGbpxLpeTOx3yliOv3/M/tLOPg=;
 b=sJ0cZmWEB20erYrQQH5ulJ3EgwKCh4RYk7ZHpJFoVM3HNmJ0TCJFHi6wOA6BMau633jR
 exBmBld75fGil+qbWkwSwpO79XK+yOfnBQSMVKgdryV+FDH2YIs2a/MDdM3ntlJSfStP
 ofbXAp9U0WIr/g1RYF8MCsmXIznnDmZ23dhp+s/tU1YJLFtTJ8Gl2LRQC/msbBNSBaQh
 m/u7rzAQMSHBqFveMh6KdlbxkbSg38EG+ld+DC+XUANyRy/bt+13NRUi1TNJxC7oWaRa
 FusLP+YcWG6mxKR0nfmMsNwSZH/C99C2Z+yXrsIiTEqrvAisSM0+sKLW4k/NGoeYYoNf vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pct8qv0t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 15:29:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBIFTSUd002740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 15:29:28 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBIFTSTN021431;
        Tue, 18 Dec 2018 15:29:28 GMT
Received: from [192.168.2.8] (/1.202.67.146)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 07:29:27 -0800
Subject: Re: [Xen-devel] [PATCH v2 1/1] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <1545094538-31426-1-git-send-email-dongli.zhang@oracle.com>
 <20181218093300.qfslnloxooqnu2im@mac>
 <51ea8086-e5fd-b1db-f935-101160ca9359@oracle.com>
 <20181218151331.iwkq3roqwigf3e2r@mac>
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        paul.durrant@citrix.com, xen-devel@lists.xenproject.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <c3e3919c-3f82-2db5-23cf-c548bc8731ea@oracle.com>
Date:   Tue, 18 Dec 2018 23:29:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181218151331.iwkq3roqwigf3e2r@mac>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180131
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/18/2018 11:13 PM, Roger Pau Monné wrote:
> On Tue, Dec 18, 2018 at 07:31:59PM +0800, Dongli Zhang wrote:
>> Hi Roger,
>>
>> On 12/18/2018 05:33 PM, Roger Pau Monné wrote:
>>> On Tue, Dec 18, 2018 at 08:55:38AM +0800, Dongli Zhang wrote:
>>>> The xenstore 'ring-page-order' is used globally for each blkback queue and
>>>> therefore should be read from xenstore only once. However, it is obtained
>>>> in read_per_ring_refs() which might be called multiple times during the
>>>> initialization of each blkback queue.
>>>>
>>>> If the blkfront is malicious and the 'ring-page-order' is set in different
>>>> value by blkfront every time before blkback reads it, this may end up at
>>>> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
>>>> xen_blkif_disconnect() when frontend is destroyed.
>>>>
>>>> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
>>>> once.
>>>>
>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> ---
>>>> Changed since v1:
>>>>   * change the order of xenstore read in read_per_ring_refs(suggested by Roger Pau Monne)
>>>>   * use xenbus_read_unsigned() in connect_ring() (suggested by Roger Pau Monne)
>>>>
>>>>  drivers/block/xen-blkback/xenbus.c | 70 ++++++++++++++++++++++----------------
>>>>  1 file changed, 40 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
>>>> index a4bc74e..7178f0f 100644
>>>> --- a/drivers/block/xen-blkback/xenbus.c
>>>> +++ b/drivers/block/xen-blkback/xenbus.c
>>>> @@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>>>>  	int err, i, j;
>>>>  	struct xen_blkif *blkif = ring->blkif;
>>>>  	struct xenbus_device *dev = blkif->be->dev;
>>>> -	unsigned int ring_page_order, nr_grefs, evtchn;
>>>> +	unsigned int nr_grefs, evtchn;
>>>>  
>>>>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
>>>>  			  &evtchn);
>>>> @@ -936,43 +936,38 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>>>>  		return err;
>>>>  	}
>>>>  
>>>> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
>>>> -			  &ring_page_order);
>>>> -	if (err != 1) {
>>>> -		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
>>>> -		if (err != 1) {
>>>> +	nr_grefs = blkif->nr_ring_pages;
>>>> +	WARN_ON(!nr_grefs);
>>>> +
>>>> +	for (i = 0; i < nr_grefs; i++) {
>>>> +		char ring_ref_name[RINGREF_NAME_LEN];
>>>> +
>>>> +		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
>>>> +		err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
>>>> +				   "%u", &ring_ref[i]);
>>>> +
>>>> +		if (err != 1 && (i || (!i && nr_grefs > 1))) {
>>>
>>> AFAICT the above condition can be simplified as "err != 1 &&
>>> nr_grefs".
>>>
>>>>  			err = -EINVAL;
>>>
>>> There's no point in setting err here...
>>>
>>>> -			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
>>>> +			xenbus_dev_fatal(dev, err, "reading %s/%s",
>>>> +					 dir, ring_ref_name);
>>>>  			return err;
>>>
>>> ...since you can just return -EINVAL (same applies to the other
>>> instance below).
>>
>> I would like to confirm if I would keep the err = -EINVAL in below because most
>> of the below code is copied from original implementation without modification.
>>
>> There is no err set by xenbus_read_unsigned().
> 
> Right, but instead of doing:
> 
> err = -EINVAL;
> return err;
> 
> You can just do:
> 
> return -EINVAL;
> 
> Which is one line shorter :).

However, for the "ring-page-order" case, the err used in xenbus_dev_fatal() is
not set as xenbus_read_unsigned() does not return any err?

For "ring-page-order", I would still need to set err = -EINVAL with extra one
line of code?

> 
>> +       ring_page_order = xenbus_read_unsigned(dev->otherend,
>> +                                              "ring-page-order", 0);
>> +
>> +       if (ring_page_order > xen_blkif_max_ring_order) {
>> +               err = -EINVAL;
>> +               xenbus_dev_fatal(dev, err,
>> +                                "requested ring page order %d exceed max:%d",
>> +                                ring_page_order,
>> +                                xen_blkif_max_ring_order);
>> +               return err;
>> +       }
>> +
>> +       be->blkif->nr_ring_pages = 1 << ring_page_order;
>>
>>
>> For the rest, I would do something like:
>>
>> +               err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
>> +                                  "%u", &ring_ref[i]);
>> +
>> +               if (err != 1 && nr_grefs > 1) {
>> +                       xenbus_dev_fatal(dev, err, "reading %s/%s",
>> +                                        dir, ring_ref_name);
>> +                       return -EINVAL;
>> +               }
>>
>>
>> Thank you very much!
> 
> Thanks!
> 

Dongli Zhang
