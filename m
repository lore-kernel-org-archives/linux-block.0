Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A060BC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7B92086C
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fu6hCRZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfDADZ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:25:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34068 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbfDADZz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 23:25:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x313JToL016775;
        Mon, 1 Apr 2019 03:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=dhXuUhKYb6x4+EBgFd2eEIcgj2A7eWm1apv6g3LA+dk=;
 b=Fu6hCRZmpQkUAVXCMyu7ZC7dSr3BlK4qsxuGQz7FFQknMacaLW6bE7aR4RYBEnoOd5Uk
 8YdjCaFUCDpmMH5iKnl6bmvgUDwSwATKaZ4fVg042WNeu744mFePu2Dsc9ppei252S5L
 Jx5ki0fg6bDDM6vTL4jIdllYfYyNwAac9SKrgJ9ZAavCiMFsQdHMtTwe1wWYlf7KTuyh
 IQyMoWBgCIjA5dF6y4gkrkDMQMZHMmbW5tR2aM6R/B78lt6nqpsKStxjlBo9SnQNFxNu
 iN4hht6FqyXdMQKgWurxHMQLfOItgRjU8AfpFpqbtFytR36mjD6Xe8vHMQdJpZcEkW90 IA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2rhyvsvcp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 03:25:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x313PgCk030809
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 03:25:43 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x313PfF6005391;
        Mon, 1 Apr 2019 03:25:41 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Mar 2019 20:25:41 -0700
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
To:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
 <20190401020036.GB30776@ming.t460p>
 <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
 <20190401025237.GE30776@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
Date:   Mon, 1 Apr 2019 11:25:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401025237.GE30776@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=925 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010023
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

On 4/1/19 10:52 AM, Ming Lei wrote:
>> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
>> percpu_ref_kill() changes the state of a per-cpu counter to the "dead"
>> state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue()
>> already calls blk_set_queue_dying() and that last function calls
>> blk_freeze_queue_start(). So I think that what you wrote is not correct and
>> that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
>> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and
>> also that moving the percpu_ref_exit() call into blk_release_queue() makes
>> sense.
> If percpu_ref_exit() is moved to blk_release_queue(), we still need to
> move freeing of hw queue's resource into blk_release_queue() like what
> the patchset is doing.
> 
> Then we don't need to get/put q_usage_counter in blk_mq_run_hw_queues() any more,
> do we?

IMO, if we could get a way to prevent any attempt to run queue, it would be
better and clearer.

Thanks
Jianchao
