Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74338C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 17:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AED12080D
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 17:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFRRNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:13:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727926AbgFRRNW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 13:13:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IH1nDw042243;
        Thu, 18 Jun 2020 13:13:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ra8ymm65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 13:13:19 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05IH2dFP045783;
        Thu, 18 Jun 2020 13:13:18 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ra8ymm5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 13:13:18 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05IH9n3E005528;
        Thu, 18 Jun 2020 17:13:17 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 31qyx1ggv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 17:13:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05IHDDBd24182968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 17:13:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9E90A4065;
        Thu, 18 Jun 2020 17:13:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40D8BA405F;
        Thu, 18 Jun 2020 17:13:13 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.145.44.63])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jun 2020 17:13:13 +0000 (GMT)
Subject: Re: [PATCH v2] Revert "zram: convert remaining CLASS_ATTR() to
 CLASS_ATTR_RO()"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wade Mealing <wmealing@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20200617114946.GA2131650@kroah.com>
From:   Steffen Maier <maier@linux.ibm.com>
Message-ID: <dea7a650-e611-c976-39e7-45883c47199d@linux.ibm.com>
Date:   Thu, 18 Jun 2020 19:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617114946.GA2131650@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_14:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180125
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/20 1:49 PM, Greg Kroah-Hartman wrote:
> From: Wade Mealing <wmealing@redhat.com>
> 
> Turns out that the permissions for 0400 really are what we want here,
> otherwise any user can read from this file.
> 
> [fixed formatting, added changelog, and made attribute static - gregkh]
> 
> Reported-by: Wade Mealing <wmealing@redhat.com>
> Cc: stable <stable@vger.kernel.org>
> Fixes: f40609d1591f ("zram: convert remaining CLASS_ATTR() to CLASS_ATTR_RO()")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1847832
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Steffen Maier <maier@linux.ibm.com>

> ---
> v2: fix read/write confusion in the changelog, thanks to Steffen for the
>      review.
>      was more specific as to the changes I made to the original patch.
> 
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
