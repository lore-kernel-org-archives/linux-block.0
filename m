Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D1DC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002AA20830
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DuU0UdwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfCYHOe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:14:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46070 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbfCYHOe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 03:14:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P7Dgre086555;
        Mon, 25 Mar 2019 07:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=gn1J2mfFH9tzliczQIqyF3ccwE8byCWrg5+JR27iD+g=;
 b=DuU0UdwIw1da4YPnkUKCikH64YmCRNul62tod0HUuObhDSI1b/ZwZ2cWmzfOhA7H9L8b
 jzsME7gwRgbutJu5Jnr3Xa7bnvJXEc7t6g0Hbo1LdCWO0uHFMYyETWM2KJbxkV8F2EsG
 8qnY4aB6+RqvNFA8L7AJtuVuo0YszWpdzf/Fvw9+cG43MH13/t1K7wrBGdPbASOW44pv
 YHzdDaqVVVFbx4ltxMY74eTSyw9x1aVGbUOqicKx8HB9EOG1KJ1QIFFmI4Reo58j81lX
 EtcvB2UvelQRKBbxVGej27Ie8cG4G3MtPg3AQpuNeFM1+R5tK/ssES09HLiD5SdNq97R 2Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2re6dj2806-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 07:14:12 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2P7EBbb000383
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 07:14:11 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P7EAmW018083;
        Mon, 25 Mar 2019 07:14:10 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 00:14:10 -0700
Subject: Re: [PATCH V2 2/8] blk-mq: use static_rqs instead of rqs to iterate
 tags
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, hare@suse.de, jthumshirn@suse.de,
        hch@lst.de, bvanassche@acm.org
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-3-git-send-email-jianchao.w.wang@oracle.com>
 <58796005-2f96-ad5c-fa21-b3a0071deb06@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a34ae014-6e99-7c57-42bd-5061dd6ea900@oracle.com>
Date:   Mon, 25 Mar 2019 15:14:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <58796005-2f96-ad5c-fa21-b3a0071deb06@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=929 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250055
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Dongli

Thanks for your kindly response.

On 3/25/19 3:12 PM, Dongli Zhang wrote:
> Hi Jianchao,
> 
> On 3/25/19 1:38 PM, Jianchao Wang wrote:
>> tags->rqs[] will not been cleaned when free driver tag to avoid
>> an extra store on a shared area in the per io path. But there
>> is a window between get driver tag and write tags->rqs[], so we
>> may see stale rq in tags->rqs[] which may have been freed, as
>> following case,
>> blk_mq_get_request         blk_mq_queue_tag_busy_iter
>>   -> blk_mq_get_tag
> 
> Sorry I forgot to mention below when I was studying the v1 patchset.
> 
> If there is further review iteration, I would suggest clarify here that
> blk_mq_get_tag() would set the bit in sbitmap (e.g., via __sbitmap_get_word())
> that bt_for_each() would iterate. Otherwise, please ignore my message.
> 
> E.g.,
> 
> blk_mq_get_request
>   -> blk_mq_get_tag
>       -> taint sbitmap tag bit
>          without setting tags->rqs[tag]
> 
>                                           -> bt_for_each
>                                               -> iterate all dirty bit...
> 
> This would be much more friendly for people not working on block layer and when
> they are looking for the potential fix for a bug by simply searching over the
> commit messages. People not working on this would be able to quickly understand
> there is a window between setting bit and setting data.

Yes, I will do that.

> 
> 
>>                              -> bt_for_each
>>                                -> bt_iter
>>                                  -> rq = taags->rqs[]
> 
> %s/taags/tags/g

Yes.


Thanks
Jianchao

> 
>>                                  -> rq->q
>>   -> blk_mq_rq_ctx_init
>>     -> data->hctx->tags->rqs[rq->tag] = rq;
>>
> 
> Thank you very much!
> 
> Dongli Zhang
> 
