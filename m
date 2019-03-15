Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B74C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0A21872
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VL2GRuup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfCOJmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:42:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:42:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F9dLFG060322;
        Fri, 15 Mar 2019 09:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=urU9MH5R9fQKmuCqhBHeuTRXRXND67dLKRNtbX53Rlo=;
 b=VL2GRuupZZ46ek0pVGD0Z2sjM8wnfrRYluza6xTFTp/WOe6k2xFDERWNfOUMrgtcusE7
 06y3FKcrC1ibVczcMOtY7k2JRwkxDdfZhee8MOsg+qtUwG71IKSundErAjU6CvUwMs4s
 PEtwu8+4kbURrI6KIC6AwK85wFiOD5pOPNEeUXbsJDK1+GYkNhNcYRV5QjEZ+orxxSUs
 OKCkzkGtv2o1GHVrNMGnp23vDzs9R6zuBYUZFOgV19km4lAmi9lTbwtDZbW3BXi/gzrm
 ICVlljsi89nnM2T0r3YIjtKm4BL1/9lpkc8ylXv4Sche65w8k2vzQ/WKsUo8TQzXdNOq zw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2r464rwp9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:41:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2F9fdxt019268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:41:40 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2F9fc6R002943;
        Fri, 15 Mar 2019 09:41:38 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 09:41:37 +0000
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        bvanassche@acm.org, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, hare@suse.de, jthumshirn@suse.de,
        sagi@grimberg.me
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <20190315092020.GA2405@lst.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a36be8bd-bb9c-745e-cfdb-018cf0a96d42@oracle.com>
Date:   Fri, 15 Mar 2019 17:44:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315092020.GA2405@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150071
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/15/19 5:20 PM, Christoph Hellwig wrote:
> On Fri, Mar 15, 2019 at 04:57:36PM +0800, Jianchao Wang wrote:
>> Hi Jens
>>
>> As we know, there is a risk of accesing stale requests when iterate
>> in-flight requests with tags->rqs[] and this has been talked in following
>> thread,
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dscsi-26m-3D154511693912752-26w-3D2&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=CydqJPTf4FUrfs7ipUc2chm2jGuNuDVn_onIetKEehM&s=ZQ7RfO6-737-t5kQv7SFlXMhIdpwn_AxJI93d6c-nj0&e=
>> [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D154526189023236-26w-3D2&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=CydqJPTf4FUrfs7ipUc2chm2jGuNuDVn_onIetKEehM&s=EBV1M5p4mE8jZ5ZD1ecU5kMbJ9EtbpVJoc7Tqolrsc8&e=
> 
> I'd rather take one step back and figure out why we are iterating
> the busy requests.  There really shouldn't be any reason why a driver
> is even doings that (vs some error handling helpers in the core
> block code that can properly synchronize).
> 

A typical scene is blk_mq_in_flight,
                          
blk_mq_get_request         blk_mq_in_flight
  -> blk_mq_get_tag        -> blk_mq_queue_tag_busy_iter
                             -> bt_for_each
                               -> bt_iter
                                 -> rq = taags->rqs[]
                                 -> rq->q       //---> get a stale request
  -> blk_mq_rq_ctx_init
    -> data->hctx->tags->rqs[rq->tag] = rq

This stale request maybe something that has been freed due to io scheduler
is detached or a q using a shared tagset is gone.

And also the blk_mq_timeout_work could use it to pick up the expired request.
The driver would also use it to requeue the in-flight requests when the device is dead.

Compared with adding more synchronization, using static_rqs[] directly maybe simpler :)

Thanks
Jianchao

