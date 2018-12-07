Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3972C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946E32083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 15:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A+fyGXVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946E32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLGPug (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:50:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36430 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGPug (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 10:50:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7FiIM8161795;
        Fri, 7 Dec 2018 15:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=QV5AcxzyRjKMXhPGb/P7qMDdWw9xBqG9bVnM4r+T9Ws=;
 b=A+fyGXVk70U5wecX53GlSG7clyKXNoMuU+eio4MeGrj1xd3+tkiW/9Wtw3EiEv92xPW7
 PbZoeovNTbflRSXaGyftouG7QnL951fNQEuEU2Ty2vmg9tqgBi3aUar+qPUQqpnpVZOK
 J8TWOLvqdDerGTSQUmZ2f/7ZqxoI2uRcU/8DeMBkZgpESezS2QDd/eY0yD2oL9sl9QSj
 T6iyphrdnK4o3ITdfsAO2H48LPuKNKXeYP51mPUGjOs+sZ6Rlrk3K4HX5dGXV9qp7X7X
 HcBPQJMoe1OTN8jkUJACko0tshuZ8zU/B1lgumQzZtkzi6f8RH8+gSabH06kEll9TV+D oA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2p3ftfjg4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 15:50:29 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB7FoSBr020914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 15:50:28 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB7FoRCT031100;
        Fri, 7 Dec 2018 15:50:27 GMT
Received: from [192.168.2.8] (/1.202.67.146)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 07:50:26 -0800
Subject: Re: [Xen-devel] [PATCH 1/1] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
To:     Paul Durrant <Paul.Durrant@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1544156284-7756-1-git-send-email-dongli.zhang@oracle.com>
 <742d0e02a1aa4031ad68a9f81fe2bdc4@AMSPEX02CL03.citrite.net>
 <f3fb198f-5a63-7fae-88da-9550019d7de7@oracle.com>
 <4b5b3d4fb52c421d9be3f204b5695cc2@AMSPEX02CL03.citrite.net>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Roger Pau Monne <roger.pau@citrix.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <91c15571-124d-60bd-af3f-8c1315422dd2@oracle.com>
Date:   Fri, 7 Dec 2018 23:50:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <4b5b3d4fb52c421d9be3f204b5695cc2@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070127
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/07/2018 11:15 PM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Dongli Zhang [mailto:dongli.zhang@oracle.com]
>> Sent: 07 December 2018 15:10
>> To: Paul Durrant <Paul.Durrant@citrix.com>; linux-kernel@vger.kernel.org;
>> xen-devel@lists.xenproject.org; linux-block@vger.kernel.org
>> Cc: axboe@kernel.dk; Roger Pau Monne <roger.pau@citrix.com>;
>> konrad.wilk@oracle.com
>> Subject: Re: [Xen-devel] [PATCH 1/1] xen/blkback: rework connect_ring() to
>> avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
>>
>> Hi Paul,
>>
>> On 12/07/2018 05:39 PM, Paul Durrant wrote:
>>>> -----Original Message-----
>>>> From: Xen-devel [mailto:xen-devel-bounces@lists.xenproject.org] On
>> Behalf
>>>> Of Dongli Zhang
>>>> Sent: 07 December 2018 04:18
>>>> To: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org;
>> linux-
>>>> block@vger.kernel.org
>>>> Cc: axboe@kernel.dk; Roger Pau Monne <roger.pau@citrix.com>;
>>>> konrad.wilk@oracle.com
>>>> Subject: [Xen-devel] [PATCH 1/1] xen/blkback: rework connect_ring() to
>>>> avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
>>>>
>>>> The xenstore 'ring-page-order' is used globally for each blkback queue
>> and
>>>> therefore should be read from xenstore only once. However, it is
>> obtained
>>>> in read_per_ring_refs() which might be called multiple times during the
>>>> initialization of each blkback queue.
>>>
>>> That is certainly sub-optimal.
>>>
>>>>
>>>> If the blkfront is malicious and the 'ring-page-order' is set in
>> different
>>>> value by blkfront every time before blkback reads it, this may end up
>> at
>>>> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));"
>> in
>>>> xen_blkif_disconnect() when frontend is destroyed.
>>>
>>> I can't actually see what useful function blkif->nr_ring_pages actually
>> performs any more. Perhaps you could actually get rid of it?
>>
>> How about we keep it? Other than reading from xenstore, it is the only
>> place for
>> us to know the value from 'ring-page-order'.
>>
>> This helps calculate the initialized number of elements on all
>> xen_blkif_ring->pending_free lists. That's how "WARN_ON(i !=
>> (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" is used to double
>> check if
>> there is no leak of elements reclaimed from all xen_blkif_ring-
>>> pending_free.
>>
>> It helps vmcore analysis as well. Given blkif->nr_ring_pages, we would be
>> able
>> to double check if the number of ring buffer slots are correct.
>>
>> I could not see any drawback leaving blkif->nr_ring_pagesin the code.
> 
> No, there's no drawback apart from space, but apart from that cross-check and, as you say, core analysis it seems to have little value.
> 
>   Paul

I will not remove blkif->nr_ring_pages and leave the current patch waiting for
review.

Dongli Zhang



> 
>>
>> Dongli Zhang
>>
>>>
>>>>
>>>> This patch reworks connect_ring() to read xenstore 'ring-page-order'
>> only
>>>> once.
>>>
>>> That is certainly a good thing :-)
>>>
>>>   Paul
>>>
>>>>
>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> ---
>>>>  drivers/block/xen-blkback/xenbus.c | 49 ++++++++++++++++++++++++------
>> ---
>>>> -----
>>>>  1 file changed, 31 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-
>>>> blkback/xenbus.c
>>>> index a4bc74e..4a8ce20 100644
>>>> --- a/drivers/block/xen-blkback/xenbus.c
>>>> +++ b/drivers/block/xen-blkback/xenbus.c
>>>> @@ -919,14 +919,15 @@ static void connect(struct backend_info *be)
>>>>  /*
>>>>   * Each ring may have multi pages, depends on "ring-page-order".
>>>>   */
>>>> -static int read_per_ring_refs(struct xen_blkif_ring *ring, const char
>>>> *dir)
>>>> +static int read_per_ring_refs(struct xen_blkif_ring *ring, const char
>>>> *dir,
>>>> +			      bool use_ring_page_order)
>>>>  {
>>>>  	unsigned int ring_ref[XENBUS_MAX_RING_GRANTS];
>>>>  	struct pending_req *req, *n;
>>>>  	int err, i, j;
>>>>  	struct xen_blkif *blkif = ring->blkif;
>>>>  	struct xenbus_device *dev = blkif->be->dev;
>>>> -	unsigned int ring_page_order, nr_grefs, evtchn;
>>>> +	unsigned int nr_grefs, evtchn;
>>>>
>>>>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
>>>>  			  &evtchn);
>>>> @@ -936,28 +937,18 @@ static int read_per_ring_refs(struct
>> xen_blkif_ring
>>>> *ring, const char *dir)
>>>>  		return err;
>>>>  	}
>>>>
>>>> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
>>>> -			  &ring_page_order);
>>>> -	if (err != 1) {
>>>> +	nr_grefs = blkif->nr_ring_pages;
>>>> +
>>>> +	if (!use_ring_page_order) {
>>>>  		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u",
>>>> &ring_ref[0]);
>>>>  		if (err != 1) {
>>>>  			err = -EINVAL;
>>>>  			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
>>>>  			return err;
>>>>  		}
>>>> -		nr_grefs = 1;
>>>>  	} else {
>>>>  		unsigned int i;
>>>>
>>>> -		if (ring_page_order > xen_blkif_max_ring_order) {
>>>> -			err = -EINVAL;
>>>> -			xenbus_dev_fatal(dev, err, "%s/request %d ring page
>>>> order exceed max:%d",
>>>> -					 dir, ring_page_order,
>>>> -					 xen_blkif_max_ring_order);
>>>> -			return err;
>>>> -		}
>>>> -
>>>> -		nr_grefs = 1 << ring_page_order;
>>>>  		for (i = 0; i < nr_grefs; i++) {
>>>>  			char ring_ref_name[RINGREF_NAME_LEN];
>>>>
>>>> @@ -972,7 +963,6 @@ static int read_per_ring_refs(struct xen_blkif_ring
>>>> *ring, const char *dir)
>>>>  			}
>>>>  		}
>>>>  	}
>>>> -	blkif->nr_ring_pages = nr_grefs;
>>>>
>>>>  	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
>>>>  		req = kzalloc(sizeof(*req), GFP_KERNEL);
>>>> @@ -1030,6 +1020,8 @@ static int connect_ring(struct backend_info *be)
>>>>  	size_t xspathsize;
>>>>  	const size_t xenstore_path_ext_size = 11; /* sufficient for "/queue-
>>>> NNN" */
>>>>  	unsigned int requested_num_queues = 0;
>>>> +	bool use_ring_page_order = false;
>>>> +	unsigned int ring_page_order;
>>>>
>>>>  	pr_debug("%s %s\n", __func__, dev->otherend);
>>>>
>>>> @@ -1075,8 +1067,28 @@ static int connect_ring(struct backend_info *be)
>>>>  		 be->blkif->nr_rings, be->blkif->blk_protocol, protocol,
>>>>  		 pers_grants ? "persistent grants" : "");
>>>>
>>>> +	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
>>>> +			   &ring_page_order);
>>>> +
>>>> +	if (err != 1) {
>>>> +		be->blkif->nr_ring_pages = 1;
>>>> +	} else {
>>>> +		if (ring_page_order > xen_blkif_max_ring_order) {
>>>> +			err = -EINVAL;
>>>> +			xenbus_dev_fatal(dev, err,
>>>> +					 "requested ring page order %d exceed
>>>> max:%d",
>>>> +					 ring_page_order,
>>>> +					 xen_blkif_max_ring_order);
>>>> +			return err;
>>>> +		}
>>>> +
>>>> +		use_ring_page_order = true;
>>>> +		be->blkif->nr_ring_pages = 1 << ring_page_order;
>>>> +	}
>>>> +
>>>>  	if (be->blkif->nr_rings == 1)
>>>> -		return read_per_ring_refs(&be->blkif->rings[0], dev-
>>>>> otherend);
>>>> +		return read_per_ring_refs(&be->blkif->rings[0], dev->otherend,
>>>> +					  use_ring_page_order);
>>>>  	else {
>>>>  		xspathsize = strlen(dev->otherend) + xenstore_path_ext_size;
>>>>  		xspath = kmalloc(xspathsize, GFP_KERNEL);
>>>> @@ -1088,7 +1100,8 @@ static int connect_ring(struct backend_info *be)
>>>>  		for (i = 0; i < be->blkif->nr_rings; i++) {
>>>>  			memset(xspath, 0, xspathsize);
>>>>  			snprintf(xspath, xspathsize, "%s/queue-%u", dev-
>>>>> otherend, i);
>>>> -			err = read_per_ring_refs(&be->blkif->rings[i], xspath);
>>>> +			err = read_per_ring_refs(&be->blkif->rings[i], xspath,
>>>> +						 use_ring_page_order);
>>>>  			if (err) {
>>>>  				kfree(xspath);
>>>>  				return err;
>>>> --
>>>> 2.7.4
>>>>
>>>>
>>>> _______________________________________________
>>>> Xen-devel mailing list
>>>> Xen-devel@lists.xenproject.org
>>>> https://lists.xenproject.org/mailman/listinfo/xen-devel
