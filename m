Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE4C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0089F20892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xiHcJavq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0089F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGD0A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:26:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45714 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGD0A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:26:00 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB73OUfO001467;
        Fri, 7 Dec 2018 03:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HUL2igTSGf2aHg9hhP48aEPvyNhWdZ3qngjeHDvPnCM=;
 b=xiHcJavq/aXOdfxeSwXAvU/1MxY/jTa/6JBI0POXM86LKhU/EiYGGrt6RcvP7onw32q/
 +sRgdCfSadwJjzC/5QIovbIs9+xmQWSFRiokl1jERmoQ9wqVoQgNd6X5A2gwKfillOik
 Zmhcko+3UKz7L3AwQMWl+LKLdkFAZnKQ7zdDX3tDMHiCNBnIKn2PRh1fPAgItXmMS3CX
 R4UVNKUxsUQfBXIee1/1U9kz1lLWvGpKD4Yzle+jXOF0HEL966l3ZE4VqoItTf44RCuM
 X9GW2FA2bvDuWrvOkpYZbkYc6K7UZWnqL09q15dK/UKh3y1P/43zvyUQdLCF5ilNhcRZ DQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2p3ftffhhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 03:25:55 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB73PtQU004569
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 03:25:55 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB73Pskj016411;
        Fri, 7 Dec 2018 03:25:54 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 19:25:54 -0800
Subject: Re: [PATCH V11 0/4] blk-mq: refactor code of issue directly
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
 <b2bcbb76-af6f-7660-2bc3-9796338cccff@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <0adf3419-bcce-93d8-51fb-aee7cbb5ae17@oracle.com>
Date:   Fri, 7 Dec 2018 11:26:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b2bcbb76-af6f-7660-2bc3-9796338cccff@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070027
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/7/18 11:16 AM, Jens Axboe wrote:
> On 12/6/18 8:09 PM, Jianchao Wang wrote:
>> Hi Jens
>>
>> Please consider this patchset for 4.21.
>>
>> It refactors the code of issue request directly to unify the interface
>> and make the code clearer and more readable.
>>
>> This patch set is rebased on the recent for-4.21/block and add the 1st
>> patch which inserts the non-read-write request to hctx dispatch
>> list to avoid to involve merge and io scheduler when bypass_insert
>> is true, otherwise, inserting is ignored, BLK_STS_RESOURCE is returned
>> and the caller will fail forever.
>>
>> The 2nd patch refactors the code of issue request directly to unify the
>> helper interface which could handle all the cases.
>>
>> The 3rd patch make blk_mq_sched_insert_requests issue requests directly
>> with 'bypass' false, then it needn't to handle the non-issued requests
>> any more.
>>
>> The 4th patch replace and kill the blk_mq_request_issue_directly.
> 
> Sorry to keep iterating on this, but let's default to inserting to
> the dispatch list if we ever see busy from a direct dispatch. I'm fine
> with doing that for 4.21, as suggested by Ming, I just didn't want to
> fiddle with it for 4.20. This will prevent any merging on the request
> going forward, which I think is a much safer default.
> 
> You do this already for some cases. Let's do it unconditionally for
> a request that was ever subjected to ->queue_rq() and we didn't either
> error or finish after the fact.
> 
I have done it in this version if I get your point correctly.
Please refer to the following fragment in the 2nd patch.

+	/*
+	 * If the request is issued unsuccessfully with
+	 * BLK_STS_DEV_RESOURCE or BLK_STS_RESOURCE, insert
+	 * the request to hctx dispatch list due to attached
+	 * lldd resource.
+	 */
+	force = true;
+	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
+out_unlock:
+	hctx_unlock(hctx, srcu_idx);
+out:
+	switch (ret) {
+	case BLK_STS_OK:
+		break;
+	case BLK_STS_DEV_RESOURCE:
+	case BLK_STS_RESOURCE:
+		if (force) {
+			blk_mq_request_bypass_insert(rq, run_queue);
+			ret = bypass ? BLK_STS_OK : ret;
+		} else if (!bypass) {
+			blk_mq_sched_insert_request(rq, false,
+						    run_queue, false);
+		}
+		break;
+	default:


Thanks
Jianchao
