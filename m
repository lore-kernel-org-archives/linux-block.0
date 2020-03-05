Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E1C3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 10:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C67020848
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 10:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLFvXCWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCEKOP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:14:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38108 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgCEKOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 05:14:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025A7mv2038879;
        Thu, 5 Mar 2020 10:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SGXNoWNlZVLnSYJIxa2/4WB0jyZ02hYC4NTOct1cKkQ=;
 b=JLFvXCWsTdaT86bZXB2zn8XjFgTtkJFosOBxbYl+jtJTDwQFO4EpD1WYdi3aWJ7FL1YW
 9FbJUMo4I0omrJiwDpGwmlpGvH68jzzALWaUDhfqSVmyPkWwi/PC1xEM0ZNXiVdeG1a4
 8Y0glEHr5VwcbOvDYKAt2GFV9JOoxJ9iDV29kNGHiUzyWIkdgfrA+e9KZWCDmMM1BM8w
 uqAIZg2H5XW6VFAEW1FaVHXc0Id6yxv55s7t4F6ziMf5iKvvJ8TfqlIakpBlxMo+HB6K
 9pqrF575lSX0ietRKXPNhzozvi4npitTINZHJW4oWF6hw2b/XIoi+RzYKrFSHshyKtFG rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2yffcuv8vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 10:13:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025ACuAd064867;
        Thu, 5 Mar 2020 10:13:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2yg1rus3dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 10:13:37 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 025ADYBw000924;
        Thu, 5 Mar 2020 10:13:34 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Mar 2020 02:13:34 -0800
Subject: Re: [PATCH v2] blktrace: fix dereference after null check
To:     Cengiz Can <cengiz@kernel.wtf>, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200304105818.11781-1-cengiz@kernel.wtf>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <dd82137a-5152-7c93-a632-ac1766286be5@oracle.com>
Date:   Thu, 5 Mar 2020 18:13:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20200304105818.11781-1-cengiz@kernel.wtf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=2 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050063
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/20 6:58 PM, Cengiz Can wrote:
> There was a recent change in blktrace.c that added a RCU protection to
> `q->blk_trace` in order to fix a use-after-free issue during access.
> 
> However the change missed an edge case that can lead to dereferencing of
> `bt` pointer even when it's NULL:
> 
> Coverity static analyzer marked this as a FORWARD_NULL issue with CID
> 1460458.
> 
> ```
> /kernel/trace/blktrace.c: 1904 in sysfs_blk_trace_attr_store()
> 1898            ret = 0;
> 1899            if (bt == NULL)
> 1900                    ret = blk_trace_setup_queue(q, bdev);
> 1901
> 1902            if (ret == 0) {
> 1903                    if (attr == &dev_attr_act_mask)
>>>>     CID 1460458:  Null pointer dereferences  (FORWARD_NULL)
>>>>     Dereferencing null pointer "bt".
> 1904                            bt->act_mask = value;
> 1905                    else if (attr == &dev_attr_pid)
> 1906                            bt->pid = value;
> 1907                    else if (attr == &dev_attr_start_lba)
> 1908                            bt->start_lba = value;
> 1909                    else if (attr == &dev_attr_end_lba)
> ```
> 
> Added a reassignment with RCU annotation to fix the issue.
> 
> Fixes: c780e86dd48 ("blktrace: Protect q->blk_trace with RCU")
> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>

This version looks good to me, thanks.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

> ---
> 
>     Patch Changelog
>     * v2: Added RCU annotation to assignment
> 
>  kernel/trace/blktrace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 4560878f0bac..ca39dc3230cb 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1896,8 +1896,11 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>  	}
> 
>  	ret = 0;
> -	if (bt == NULL)
> +	if (bt == NULL) {
>  		ret = blk_trace_setup_queue(q, bdev);
> +		bt = rcu_dereference_protected(q->blk_trace,
> +				lockdep_is_held(&q->blk_trace_mutex));
> +	}
> 
>  	if (ret == 0) {
>  		if (attr == &dev_attr_act_mask)
> --
> 2.25.1
> 

