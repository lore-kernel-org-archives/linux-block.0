Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B91EC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 02:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199B62147C
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 02:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rcXx8oqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfCSCBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:01:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60354 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfCSCBu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 22:01:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J1xD5N052089;
        Tue, 19 Mar 2019 02:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=qRP0v67g8qqW9Dregqsi0hYaw1mJNAEkd/RTyV5Yy0A=;
 b=rcXx8oqnOVAjOEgVsFFwn4AuqaK0hMSrKWkJaiHFgvnzmZvmUi21+P0L3qqmSziqotoh
 byrJRWeWFpBTQOwYj7mAXitZ0k9yRLd6wYkKgkoiFZHve7ljb0BeuM6O6MiFfXZfjSZf
 XHuVqt6TdGIEPcH0iFXP05CZmro/D/vLCBCjIZYZB2Lqd2o5vxCXiqLiW9c8CI+W6JKz
 HqovSOpBk/kSWRbqdH0QIIKtR+yjTvsCgAx+PUxNZqXn8o7JPX56hy2EkdfQnotSfM+B
 apEdKGvGBzhOQczj9x2Nxecz+0mulKvjF1eGMV17OEpcSL92oezQnCx69YouDuEUmnVq 0A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r8pnej2wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 02:01:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2J21GvF009205
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 02:01:16 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2J21Fjx002656;
        Tue, 19 Mar 2019 02:01:15 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 19:01:15 -0700
Subject: Re: [PATCH 5/8] nbd: use blk_mq_queue_tag_busy_iter
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, hare@suse.de, jthumshirn@suse.de, hch@lst.de
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-6-git-send-email-jianchao.w.wang@oracle.com>
 <1552929384.152266.27.camel@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <6447c549-d531-58a7-57f7-00480ec2d128@oracle.com>
Date:   Tue, 19 Mar 2019 10:04:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552929384.152266.27.camel@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190013
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart

Thanks for your comment on this.

On 3/19/19 1:16 AM, Bart Van Assche wrote:
> On Fri, 2019-03-15 at 16:57 +0800, Jianchao Wang wrote:
>> blk_mq_tagset_busy_iter is not safe that it could get stale request
>> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  drivers/block/nbd.c | 2 +
>>  1 file changed, 1 insertion(), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 7c9a949..9e7e828 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -747,7 +747,7 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
>>  static void nbd_clear_que(struct nbd_device *nbd)
>>  {
>>         blk_mq_quiesce_queue(nbd->disk->queue);
>> -       blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
>> +       blk_mq_queue_tag_busy_iter(nbd->disk->queue, nbd_clear_req, NULL, true);
>>         blk_mq_unquiesce_queue(nbd->disk->queue);
>>         dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
>>  }
> 
> Hi Jianchao,
> 
> The nbd driver calls nbd_clear_que() after having called sock_shutdown(). So
> what makes you think that it's not safe to call blk_mq_tagset_busy_iter()
> from nbd_clear_que()?
> 

The request_queue is not frozen, so there still could be someone enters and get
request. If no io scheduler attached, the driver tag could be allocated and 
tags->rqs[] would be set. During this, blk_mq_tagset_busy_iter could get some stale
requests in tags->rqs[] which maybe freed due to switching io scheduler to none.

Thanks
Jianchao
