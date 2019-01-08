Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E333C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 09:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5720A20827
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 09:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VAtfMRPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfAHJwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:52:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36614 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfAHJwb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 04:52:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x089oOxG158111;
        Tue, 8 Jan 2019 09:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=s8ZejUAJjZrdgOuybCIsuyBw3ahtCm9zkbQJS2N9n6Q=;
 b=VAtfMRPVlhQ/a1SdMIh8F3ijDUZ9eaIcOtYV1FGksqfx+2ZEXn/XOEI8uM9Vd/lfFeRR
 jIoz7XSXUxfBY2Xl5XfzADRjzi1wrZAoJp/xo+SS3FWR1ekS4YhPAThgAk/cGOG24wFM
 OgtQB8GmLhbPhtrmPRq+8I2gXjWM0vO/T1scWrSrVgDjesDPQmYB0fsrAge4OCFVnvaW
 cfiY0uC+TcQdnxN8OVo6XJiEhcQ5hEFn0+PRCbPA0LG5jovvTVlgq6zCXRstWEgQpei9
 ncRpjg+X/AzcdewiGAL64kfPDubvs9r7QQRlPRtHnmpMNM9xWYIfRX9WF6PGCehlU4ZO KA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ptj3dtrqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 09:52:26 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x089qPUo013459
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 09:52:25 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x089qOKV006082;
        Tue, 8 Jan 2019 09:52:24 GMT
Received: from [192.168.2.8] (/106.39.151.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 01:52:24 -0800
Subject: Re: [Xen-devel] [PATCH v4 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
 <1546839359-5478-2-git-send-email-dongli.zhang@oracle.com>
 <20190107120107.euf7mrq7gk6bmibz@mac>
 <35c7d495-2d6c-5fec-abf8-c5aef55cf866@oracle.com>
 <56819579-def2-b045-f414-4de45188fe2e@oracle.com>
 <20190107152708.z4mecdm2apfxz2rk@mac>
Cc:     Paul.Durrant@citrix.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <d347524f-20e1-6ce4-70f5-95b699374bb2@oracle.com>
Date:   Tue, 8 Jan 2019 17:52:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190107152708.z4mecdm2apfxz2rk@mac>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080081
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Roger,

On 01/07/2019 11:27 PM, Roger Pau Monné wrote:
> On Mon, Jan 07, 2019 at 10:07:34PM +0800, Dongli Zhang wrote:
>>
>>
>> On 01/07/2019 10:05 PM, Dongli Zhang wrote:
>>>
>>>
>>> On 01/07/2019 08:01 PM, Roger Pau Monné wrote:
>>>> On Mon, Jan 07, 2019 at 01:35:59PM +0800, Dongli Zhang wrote:
>>>>> The xenstore 'ring-page-order' is used globally for each blkback queue and
>>>>> therefore should be read from xenstore only once. However, it is obtained
>>>>> in read_per_ring_refs() which might be called multiple times during the
>>>>> initialization of each blkback queue.
>>>>>
>>>>> If the blkfront is malicious and the 'ring-page-order' is set in different
>>>>> value by blkfront every time before blkback reads it, this may end up at
>>>>> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
>>>>> xen_blkif_disconnect() when frontend is destroyed.
>>>>>
>>>>> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
>>>>> once.
>>>>>
>>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>>> ---
>>>>> Changed since v1:
>>>>>   * change the order of xenstore read in read_per_ring_refs
>>>>>   * use xenbus_read_unsigned() in connect_ring()
>>>>>
>>>>> Changed since v2:
>>>>>   * simplify the condition check as "(err != 1 && nr_grefs > 1)"
>>>>>   * avoid setting err as -EINVAL to remove extra one line of code
>>>>>
>>>>> Changed since v3:
>>>>>   * exit at the beginning if !nr_grefs
>>>>>   * change the if statements to avoid test (err != 1) twice
>>>>>   * initialize a 'blkif' stack variable (refer to PATCH 1/2)
>>>>>
>>>>>  drivers/block/xen-blkback/xenbus.c | 76 +++++++++++++++++++++-----------------
>>>>>  1 file changed, 43 insertions(+), 33 deletions(-)
>>>>>
>>>>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
>>>>> index a4aadac..a2acbc9 100644
>>>>> --- a/drivers/block/xen-blkback/xenbus.c
>>>>> +++ b/drivers/block/xen-blkback/xenbus.c
>>>>> @@ -926,7 +926,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>>>>>  	int err, i, j;
>>>>>  	struct xen_blkif *blkif = ring->blkif;
>>>>>  	struct xenbus_device *dev = blkif->be->dev;
>>>>> -	unsigned int ring_page_order, nr_grefs, evtchn;
>>>>> +	unsigned int nr_grefs, evtchn;
>>>>>  
>>>>>  	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
>>>>>  			  &evtchn);
>>>>> @@ -936,43 +936,38 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
>>>>>  		return err;
>>>>>  	}
>>>>>  
>>>>> -	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
>>>>> -			  &ring_page_order);
>>>>> -	if (err != 1) {
>>>>> -		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
>>>>> +	nr_grefs = blkif->nr_ring_pages;
>>>>> +
>>>>> +	if (unlikely(!nr_grefs))
>>>>> +		return -EINVAL;
>>>>
>>>> Is this even possible? AFAICT read_per_ring_refs will always be called
>>>> with blkif->nr_ring_pages != 0?
>>>>
>>>> If so, I would consider turning this into a BUG_ON/WARN_ON.
>>>
>>> It used to be "WARN_ON(!nr_grefs);" in the v3 of the patch.
>>>
>>> I would turn it into WARN_ON if it is fine with both Paul and you.
>>
>> To clarify, I would use WARN_ON() before exit with -EINVAL (when
>> blkif->nr_ring_pages is 0).
> 
> Given that this function will never be called with nr_ring_pages == 0
> I would be fine with just using a BUG_ON, getting here with
> nr_ring_pages == 0 would imply memory corruption or some other severe
> issue has happened, and there's no possible recovery.
> 
> If you want to instead keep the return, please use plain WARN instead
> of WARN_ON.
> 
> Thanks, Roger.
> 

Is there any reason using WARN than WARN_ON? Because of the message printed by
WARN? something like below?

 941         if (unlikely(!nr_grefs)) {
 942                 WARN(!nr_grefs,
 943                      "read_per_ring_refs() should be called with
blkif->nr_ring_pages != 0");
 944                 return -EINVAL;
 945         }

Thank you very much.

Dongli Zhang
