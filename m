Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E9C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 08:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F2420850
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 08:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uAsQ6DLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfCSINo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:13:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfCSINo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 04:13:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J8Bkvm089146;
        Tue, 19 Mar 2019 08:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cRL02KRukfO1/OeuxBvZoGs2Fz7pvakqOJl/MZ/jAQo=;
 b=uAsQ6DLqW3CT6QmVypZTFWV2k1lBNPKIAGokPDlQxZeaoKn6RbrSkKvHJU2ayEiT3+mO
 qatUvAWFuCsX+Absn+m4TByQRj/fOACwhu5u4GtWWufwH36HQk8PTI2aDMm19tQV1waM
 5W41CN1Rokl2z7hofCLg6Om2+FKfrrXgHmN/suoeqTij17j4o64cM7WD+hVuTtoRbawB
 N+OqTSVbppFU2IjHa3npaD1U0dUuz+J34kVmvwemZMsdYgBu+Uvnjpa71hebQwR3IS/R
 Vi9UlWFsFaSgIAdZwx5gxDbP8eKYSIzNPJ92NGuTTSEk9hvmRoroKsKfPWfFMiXb+Xt8 Wg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r8rjuk0nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 08:13:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2J8DWRb006426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 08:13:32 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2J8DVHl029511;
        Tue, 19 Mar 2019 08:13:32 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 01:13:31 -0700
Subject: Re: [PATCH] sbitmap: order RW on old associated instance and setting
 clear bit
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20190319042447.27580-1-ming.lei@redhat.com>
 <9e784c48-2865-a14a-d8f4-e6c74f258f48@oracle.com>
 <20190319075815.GA28327@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <4b2ac159-a42b-b410-e0ba-19ec86681f48@oracle.com>
Date:   Tue, 19 Mar 2019 16:16:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319075815.GA28327@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=827 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190062
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

On 3/19/19 3:58 PM, Ming Lei wrote:
> On Tue, Mar 19, 2019 at 01:17:31PM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 3/19/19 12:24 PM, Ming Lei wrote:
>>> @@ -591,6 +591,15 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
>>>  void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
>>>  			 unsigned int cpu)
>>>  {
>>> +	/*
>>> +	 * Once the clear bit is set, it will be visible to allocation
>>> +	 * side.
>>> +	 *
>>> +	 * This memory barrier orders any READ/WRITE on the to-be-freed
>>> +	 * asssociated instance for avoiding potential use-after-free, and
>>> +	 * its pair is the memory barrier implied in sbitmap_get().
>> which one ?
> 
> test_and_set_bit_lock() in __sbitmap_get_word().

Yes, thanks for your pointing out.
Would you perhaps detail this in the comment ?

Thanks
Jianchao
> 
>>
>>> +	 */
>>> +	smp_mb();
>>
>> smp_mb_before_atomic should be enough.
> 
> Right, will change to it in V2.
> 
> Thanks,
> Ming
> 
