Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F3C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B722146D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 01:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mhCXdSLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B722146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLGBPp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:15:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53970 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLGBPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 20:15:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB719C4A111393;
        Fri, 7 Dec 2018 01:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BtBqsYp/AGAgnDu5zGBDraLt1/GUknDEf1Lc3/P0G1c=;
 b=mhCXdSLex+QMFOxiHVq1zFPXJtkXiOcargRsvPYIfYsli1KnW20d/YS4hptdOrIclzoq
 KpnW1yoLD2XZpuf+TfR/MZroMGN6B1Ej+Wpm6RqrkhYtAefOh/ItUlHlsIyY9NQdDzUA
 Uhozx7/X8Lhq8YxOQURpPlenR4vR6I/Otp/olHQNUs0cMFw7t2PewnHBDvf4kvZ6kpjo
 ulJ0Nke+0WnqS8LfFCyz+Bf7bOurQX4uJY3FQ2uiKX2tou1NeNdW9XjAYoq8qaB1a6TA
 +/F41u6K8z4yjmiKNDMMnYVZ6WvLvQBoNVEgRbUw5S+FQGvNhNb4vLEQnMniIebkwjEq ww== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftff8jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 01:15:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB71Ff0A016862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 01:15:41 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB71FfZU027443;
        Fri, 7 Dec 2018 01:15:41 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 17:15:41 -0800
Subject: Re: [PATCH V10 3/4] blk-mq: issue directly with bypass 'false' in
 blk_mq_sched_insert_requests
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544067160-20564-1-git-send-email-jianchao.w.wang@oracle.com>
 <1544067160-20564-4-git-send-email-jianchao.w.wang@oracle.com>
 <840accff-5050-744d-9c95-febce5433ab2@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <eedc417a-3ad2-e586-2ef2-a051a403228e@oracle.com>
Date:   Fri, 7 Dec 2018 09:16:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <840accff-5050-744d-9c95-febce5433ab2@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/6/18 11:19 PM, Jens Axboe wrote:
> On 12/5/18 8:32 PM, Jianchao Wang wrote:
>> It is not necessary to issue request directly with bypass 'true'
>> in blk_mq_sched_insert_requests and handle the non-issued requests
>> itself. Just set bypass to 'false' and let blk_mq_try_issue_directly
>> handle them totally. Remove the blk_rq_can_direct_dispatch check,
>> because blk_mq_try_issue_directly can handle it well.
>>
>> With respect to commit_rqs hook, we only need to care about the last
>> request's result. If it is inserted, invoke commit_rqs.
> 
> I don't think there's anything wrong, functionally, with this patch,
> but I question the logic of continuing to attempt direct dispatch
> if we fail one. If we get busy on one, for instance, we should just
> insert that one to the dispatch list, and insert the rest of the list
> normally.
> 
> 
It is OK for me to stop to attempt direct dispatch and insert all of the
rest when meet the non-ok case.

Thanks
Jianchao
