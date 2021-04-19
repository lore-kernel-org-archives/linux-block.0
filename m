Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A941C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 16:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273C96100B
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 16:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhDSQlC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 12:41:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51424 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhDSQlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 12:41:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JGYlrK130227;
        Mon, 19 Apr 2021 16:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cjjprptH8XWae5Iq/kct1mx5Xc07DNe0yIzTBqI/D4U=;
 b=OtFCA+nOlNm6tH/JuUZFY48+5pkDrk/Hk5IaoP0qe0R/PQzdO49b2bTnydeAcbtGYbgJ
 /Ad0r/O8WLg5LViCXl8W6ke/W/4sd2wVFT49/WpDZ14nAUJ1Cf+ZzOqXCLQ73C4mnGxU
 uWksdIa5bvBMfurUd4CzDH86M9M31oerNBBt/BHzxj0zRjCPJuzn7tH2pB/pWOylXQ3D
 ty19qd4NP5JtLKQJJJs7OYDUYiaYuoRB1F6VdLOTIb5YZGJoQIF3ShTylaM+wd6YS5J2
 qeIKDEYq8EMdOx7FCxXcao733Wk/qtZho7A1Dt8jyTuyH2gRW9pW51+IBir78gJZTDLx tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37yveac0ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 16:40:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JGa5XQ177018;
        Mon, 19 Apr 2021 16:40:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3809jy32jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 16:40:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13JGeNQM017811;
        Mon, 19 Apr 2021 16:40:23 GMT
Received: from dhcp-10-159-154-74.vpn.oracle.com (/10.159.154.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Apr 2021 09:40:23 -0700
Subject: Re: [PATCH] block: fix io hung by block throttle
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
References: <20210414211830.5720-1-junxiao.bi@oracle.com>
 <20210417101008.4132-1-hdanton@sina.com>
 <20210418123342.13740-1-hdanton@sina.com>
 <1c3a2874-35bd-3ff0-3088-1a6ea968d016@oracle.com>
Message-ID: <9f02eb4d-4832-9f84-9df9-364f2000dd29@oracle.com>
Date:   Mon, 19 Apr 2021 09:39:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1c3a2874-35bd-3ff0-3088-1a6ea968d016@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190113
X-Proofpoint-GUID: XQ3G561llKYoy5KGI1q-LxblaCQL0ez-
X-Proofpoint-ORIG-GUID: XQ3G561llKYoy5KGI1q-LxblaCQL0ez-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190113
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/18/21 11:09 PM, Junxiao Bi wrote:
>> - finish_wait(&rqw->wait, &data.wq);
>> +    mutex_lock(&rqw->throttle_mutex);
>> +    wait_event(rqw->wait, acquire_inflight_cb(rqw, private_data));
>> +    mutex_unlock(&rqw->throttle_mutex);
>
> This will break the throttle? There is a inflight io limitation. With 
> this change, there can be only one io inflight whatever the limit is.
Sorry, ignore this. I should go sleep that time.
>
> Thanks,
>
> Junxiao.
