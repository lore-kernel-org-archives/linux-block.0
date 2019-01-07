Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68CCC43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E1F2173C
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 14:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zr6PDGL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfAGOGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:06:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59740 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfAGOGH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 09:06:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x07E3VLJ041731;
        Mon, 7 Jan 2019 14:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Hm7bmhvbOLZ8vis60xdUYQx8v3sR2LjrsFpV8CpH9iE=;
 b=Zr6PDGL8mIpGPhhZ73ay95m1Z624GSnynzFpGu7MRk1DSuhjb3UbsH1Ug+wd/lTVLhHD
 x2m+rIpo/8nlF/oDEF3nRooh++IYCnD+a2JQFroa7okUg+lgnZDwGoLPNPvJ28Ts+cOg
 if7nIlh/hhSKokRvpo++0Jf6JY+TPHqRhN+OnK5qWqOwzKSrdzu2NFTR7uPRzN4e8raK
 gLH1vnOgTwD3GQeq3veBYtfqBKw4/IqSzfp/TqK0TlvGNWKvSRDqDg9I+FW9dSzDXb+k
 stIQLeR24pX5On9fc/XbvW1ljesrtVRWf2h3cTUf02MBLPlQ6N3CEDW8QF6wEcAw+pwQ Mg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2ptj3dp3r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jan 2019 14:06:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x07E5stU025425
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jan 2019 14:05:54 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x07E5r64032656;
        Mon, 7 Jan 2019 14:05:53 GMT
Received: from [192.168.2.8] (/106.39.151.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jan 2019 06:05:53 -0800
Subject: Re: [Xen-devel] [PATCH v4 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Paul.Durrant@citrix.com
References: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
 <1546839359-5478-2-git-send-email-dongli.zhang@oracle.com>
 <20190107120107.euf7mrq7gk6bmibz@mac>
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <35c7d495-2d6c-5fec-abf8-c5aef55cf866@oracle.com>
Date:   Mon, 7 Jan 2019 22:05:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190107120107.euf7mrq7gk6bmibz@mac>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9128 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901070125
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 01/07/2019 08:01 PM, Roger Pau Monné wrote:
> On Mon, Jan 07, 2019 at 01:35:59PM +0800, Dongli Zhang wrote:
>> The xenstore 'ring-page-order' is used globally for each blkback queue and
>> therefore should be read from xenstore only once. However, it is obtained
>> in read_per_ring_refs() which might be called multiple times during the
>> initialization of each blkback queue.
>>
>> If the blkfront is malicious and the 'ring-page-order' is set in different
>> value by blkfront every time before blkback reads it, this may end up at
>> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
>> xen_blkif_disconnect() when frontend is destroyed.
>>
>> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
>> once.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>> Changed since v1:
>>   * change the order of xenstore read in read_per_ring_refs
>>   * use xenbus_read_unsigned() in connect_ring()
>>
>> Changed since v2:
>>   * simplify the condition check as "(err != 1 && nr_grefs > 1)"
>>   * avoid setting err as -EINVAL to remove extra one line of code
>>
>> Changed since v3:
>>   * exit at the beginning if !nr_grefs
>>   * change the if statements to avoid test (err != 1) twice
>>   * initialize a 'blkif' stack variable (refer to PATCH 1/2)
>>
>>  drivers/block/xen-blkback/xenbus.c | 76 +++++++++++++++++++++-----------------
>>  1 file changed, 43 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
>> index a4aadac..a2acbc9 100644
>> --- a/drivers/block/xen-blkback/xenbus.c
>> +++ b/drivers/block/xen-blkback/xenbus.c
>> @@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>>  	int err, i, j;
>>  	struct xen_blkif *blkif = ring->blkif;
>>  	struct xenbus_device *dev = blkif->be->dev;
>> -	unsigned int ring_page_order, nr_grefs, evtchn;
>> +	unsigned int nr_grefs, evtchn;
>>  
>>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
>>  			  &evtchn);
>> @@ -936,43 +936,38 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>>  		return err;
>>  	}
>>  
>> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
>> -			  &ring_page_order);
>> -	if (err != 1) {
>> -		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
>> +	nr_grefs = blkif->nr_ring_pages;
>> +
>> +	if (unlikely(!nr_grefs))
>> +		return -EINVAL;
> 
> Is this even possible? AFAICT read_per_ring_refs will always be called
> with blkif->nr_ring_pages != 0?
> 
> If so, I would consider turning this into a BUG_ON/WARN_ON.

It used to be "WARN_ON(!nr_grefs);" in the v3 of the patch.

I would turn it into WARN_ON if it is fine with both Paul and you.

I prefer WARN_ON because it would remind the developers in the future that
read_per_ring_refs() should be used only when blkif->nr_ring_pages != 0.

> 
>> +
>> +	for (i = 0; i < nr_grefs; i++) {
>> +		char ring_ref_name[RINGREF_NAME_LEN];
>> +
>> +		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
>> +		err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
>> +				   "%u", &ring_ref[i]);
>> +
>>  		if (err != 1) {
>> -			err = -EINVAL;
>> -			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
>> -			return err;
>> -		}
>> -		nr_grefs = 1;
>> -	} else {
>> -		unsigned int i;
>> -
>> -		if (ring_page_order > xen_blkif_max_ring_order) {
>> -			err = -EINVAL;
>> -			xenbus_dev_fatal(dev, err, "%s/request %d ring page order exceed max:%d",
>> -					 dir, ring_page_order,
>> -					 xen_blkif_max_ring_order);
>> -			return err;
>> +			if (nr_grefs == 1)
>> +				break;
>> +
> 
> You need to either set err to EINVAL before calling xenbus_dev_fatal,
> or call xenbus_dev_fatal with EINVAL as the second parameter.
> 
>> +			xenbus_dev_fatal(dev, err, "reading %s/%s",
>> +					 dir, ring_ref_name);
>> +			return -EINVAL;
>>  		}
>> +	}
>>  
>> -		nr_grefs = 1 << ring_page_order;
>> -		for (i = 0; i < nr_grefs; i++) {
>> -			char ring_ref_name[RINGREF_NAME_LEN];
>> -
>> -			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
>> -			err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
>> -					   "%u", &ring_ref[i]);
>> -			if (err != 1) {
>> -				err = -EINVAL;
>> -				xenbus_dev_fatal(dev, err, "reading %s/%s",
>> -						 dir, ring_ref_name);
>> -				return err;
>> -			}
>> +	if (err != 1) {
>> +		WARN_ON(nr_grefs != 1);
>> +
>> +		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u",
>> +				   &ring_ref[0]);
>> +		if (err != 1) {
>> +			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
> 
> Second parameter should be EINVAL, or err should be set to EINVAL
> before calling xenbus_dev_fatal.
> 
> Thanks, Roger.
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 

Dongli Zhang
