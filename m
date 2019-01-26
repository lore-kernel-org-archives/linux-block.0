Return-Path: <SRS0=xZ4d=QC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF96CC282C0
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 01:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A59C218F0
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 01:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yvTCXHIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfAZBQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:16:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44688 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 20:16:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0Q1EZUW042586;
        Sat, 26 Jan 2019 01:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=VN91eYyKNwPyf7kNfseFO0B3YkS+G7V0IlqHECbWM44=;
 b=yvTCXHIA66wHd5Xf7M6/xB/SwtEGuhxVCutJz/mAGnLPaB0sliDEEHY42A2pZD96VbGA
 urvmmoARBST+qPSLRYRcmNhixdWJcVfVqyWft//0/3OaEtfs/l2hlmb3NoPhNlLhGsPF
 6Hs2VehR8a38C2OFeVHYO/bMYI8IXVh/ldaEjMkIq/ZzGshCLNsPq6+EKTjzv+wNzF09
 44RzOpBtkDp1GMCAXg/ROp1buSv5x3InfrPXyAg7HVsV4cc2UcLrHwxk67WmkMqaquj4
 +cr5P+DgMpcHApM5OiMd5WFBJAo5Sou8dVkhtN/YHOKZPSVfCpnPauRHoGZMCrKGlPbW Yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2q8d2dr2h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Jan 2019 01:16:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0Q1GWe7011432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Jan 2019 01:16:32 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0Q1GVpl015879;
        Sat, 26 Jan 2019 01:16:31 GMT
Received: from [10.191.30.196] (/10.191.30.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jan 2019 17:16:31 -0800
Subject: Re: fsync hangs after scsi rejected a request
To:     Florian Stecker <m19@florianstecker.de>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
 <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
 <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
 <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com>
 <e18051e3-4008-e259-dee3-dd58f23642ab@oracle.com>
 <4b631218-49ee-c3ed-46be-17f9d30b663f@florianstecker.de>
 <c42631fa-3e61-e046-851e-8079906a14fb@oracle.com>
 <d9fd42a9-6105-2404-6e74-cc540da1cf16@florianstecker.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3d921990-06c4-4662-2853-7667b4e9a462@oracle.com>
Date:   Sat, 26 Jan 2019 09:18:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d9fd42a9-6105-2404-6e74-cc540da1cf16@florianstecker.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9147 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901260004
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/26/19 6:10 AM, Florian Stecker wrote:
> 
> 
> On 1/25/19 10:05 AM, jianchao.wang wrote:
>>
>>
>> On 1/25/19 4:56 PM, Florian Stecker wrote:
>>> On 1/25/19 4:49 AM, jianchao.wang wrote:
>>>>
>>>> It sounds like not so easy to trigger.
>>>>
>>>> blk_mq_dispatch_rq_list
>>>>     scsi_queue_rq
>>>>        if (atomic_read(&sdev->device_busy) ||
>>>>          scsi_device_blocked(sdev))
>>>>          ret = BLK_STS_DEV_RESOURCE;             scsi_end_request
>>>>                                                    __blk_mq_end_request
>>>>                                                      blk_mq_sched_restart // clear RESTART
>>>>                                                        blk_mq_run_hw_queue
>>>>                                                    blk_mq_run_hw_queues
>>>>       list_splice_init(list, &hctx->dispatch)
>>>>     needs_restart = blk_mq_sched_needs_restart(hctx)
>>>>
>>>> The 'needs_restart' will be false, so the queue would be rerun.
>>>>
>>>> Thanks
>>>> Jianchao
>>>
>>> Good point. So the RESTART flag is supposed to protect against this? Now I see, this is also sort of what the lengthy comment in blk_mq_dispatch_rq_list is saying.
>>>
>>> May I complain that this is very unintuitive (the queue gets rerun when the RESTART flag is _not_ set) and also unreliable, as not every caller of blk_mq_dispatch_rq_list seems to set the flag, and also it does not always get cleared in __blk_mq_end_request?
>>>
>>> __blk_mq_end_request does the following:
>>>
>>>      if (rq->end_io) {
>>>          rq_qos_done(rq->q, rq);
>>>          rq->end_io(rq, error);
>>>      } else {
>>>          if (unlikely(blk_bidi_rq(rq)))
>>>              blk_mq_free_request(rq->next_rq);
>>>          blk_mq_free_request(rq);
>>>      }
>>>
>>> and blk_mq_free_request then calls blk_mq_sched_restart, which clears the flag. But in my case, rq->end_io != 0, so blk_mq_free_request is never called.
>>
>> So what is your rq->end_io ?
>> flush_end_io ? or mq_flush_data_end_io ? or other ?
>> In normal case, the blk_mq_end_request should be finally invoked.
>>
>> Did you ever try the bfq io scheduler instead of mq-deadline ?
>>
>> Can you share your dmesg and config file here ?
> 
> Sure.
> 
> dmesg: https://urldefense.proofpoint.com/v2/url?u=https-3A__florianstecker.de_dmesg-2D2019-2D01-2D25.txt&d=DwIDaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=t_udGGsH8ivtjXHin4oQ4LxELuPoXbl_ARP7oSxiQ6k&s=DC2fhRw2g4haGhhHxOYyX4zD6FWQQ5YoERdfptVRHM4&e=
> Note that no I/O scheduler is in use here, I deactivated them in a udev rule because I still want to be able to use my laptop. When I test this stuff I just reactivate mq-deadline manually.
> 
> Config is the default in Arch Linux: https://urldefense.proofpoint.com/v2/url?u=https-3A__git.archlinux.org_svntogit_packages.git_tree_trunk_config-3Fh-3Dpackages_linux&d=DwIDaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=t_udGGsH8ivtjXHin4oQ4LxELuPoXbl_ARP7oSxiQ6k&s=GjV_fyXaKZ8za8zdB_gqmKW7yBlbla2OHRaAT0iGZkc&e=
> 
> The problem also appears with BFQ.
> 
> And rq->end_io is set to mq_flush_data_end_io when this happens. The only point I see where this function could invoke blk_mq_end_request is via blk_flush_complete_seq, but it does so only if seq == REQ_FSEQ_DONE. However, seq is REQ_FSEQ_POSTFLUSH for me (i.e. it just transitioned from REQ_FSEQ_DATA to REQ_FSEQ_POSTFLUSH).


Could it be this scenario ?

data + post flush

blk_flush_complete_seq          a flush
  case REQ_FSEQ_DATA
  blk_flush_queue_rq
  
  finally issued to driver      blk_mq_dispatch_rq_list
                                try to issue a flush req
                                failed due to NON-NCQ command
                                due to RESTART is set, do nothing
  req complete
  req->end_io（） // doesn't check RESTART
  mq_flush_data_end_io
　  blk_flush_complete_seq
     case REQ_FSEQ_POSTFLUSH
     blk_kick_flush
       do nothing because previous flush
       has not been completed, so 
       flush_pending_idx != flush_running_idx

Thanks
Jianchao
  


>>
> 
