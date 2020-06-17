Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5976EC433E1
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 11:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DEA520776
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 11:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgFQLGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:06:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgFQLGF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 07:06:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HB4Shl183167;
        Wed, 17 Jun 2020 07:06:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31q6hdjd9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 07:06:00 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05HB60Qn192394;
        Wed, 17 Jun 2020 07:06:00 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31q6hdjd82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 07:05:59 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05HAu2rS000734;
        Wed, 17 Jun 2020 11:05:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 31q6ckrc7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 11:05:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05HB5tlE36306996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 11:05:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CDC711C054;
        Wed, 17 Jun 2020 11:05:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0018411C052;
        Wed, 17 Jun 2020 11:05:54 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.145.171.180])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Jun 2020 11:05:54 +0000 (GMT)
Subject: Re: [PATCH] Revert "zram: convert remaining CLASS_ATTR() to
 CLASS_ATTR_RO()"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wade Mealing <wmealing@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20200617103412.GA2027053@kroah.com>
From:   Steffen Maier <maier@linux.ibm.com>
Message-ID: <5cde1d94-275e-2555-b13d-0b04a7a70fc7@linux.ibm.com>
Date:   Wed, 17 Jun 2020 13:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617103412.GA2027053@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_03:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 cotscore=-2147483648 malwarescore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170083
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/20 12:34 PM, Greg Kroah-Hartman wrote:
> From: Wade Mealing <wmealing@redhat.com>
> 
> Turns out that the permissions for 0400 really are what we want here,
> otherwise any user can write to this file.

Minor confusion on my side:
Did you mean "read from" instead of "write to"?
I.e. only owner may read but not group nor others.
Whereas using CLASS_ATTR_RO would resolve into 0444.

> 
> [fixed formatting and made static - gregkh]
> 
> Reported-by: Wade Mealing <wmealing@redhat.com>
> Cc: stable <stable@vger.kernel.org>
> Fixes: f40609d1591f ("zram: convert remaining CLASS_ATTR() to CLASS_ATTR_RO()")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1847832
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/block/zram/zram_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 6e2ad90b17a3..270dd810be54 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2021,7 +2021,8 @@ static ssize_t hot_add_show(struct class *class,
>   		return ret;
>   	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
>   }
> -static CLASS_ATTR_RO(hot_add);
> +static struct class_attribute class_attr_hot_add =
> +	__ATTR(hot_add, 0400, hot_add_show, NULL);
> 
>   static ssize_t hot_remove_store(struct class *class,
>   			struct class_attribute *attr,
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
