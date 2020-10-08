Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F1AC4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C546421974
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IFitAXU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgJHO41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:56:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730721AbgJHO4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 10:56:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098E3n75082536;
        Thu, 8 Oct 2020 10:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HUkcGQ91cL9eMMJ93eDlDPqlAilxEvmlKhsVmdxxE18=;
 b=IFitAXU8kBfvnaqpzQRU+exHfdKNKphyFHcEGiDrl3WSMyz3/RRs1s+Scne1M73mPx6S
 FpuWSXBySjkPgllUUKekIOpoXr04/lT3gIUskZQDiG6DIXd2gp5CenKA6JVZDGeJAfoB
 Afa9PZMFw5viQIbJfE/UfJqg1csxluCRUUfSN6QP8aBFNONIoP6oS6mYCtdozAUVgs2U
 gpHXFNYkgAT+eg35wU+f+s8Faz+Tzd89top+jQ2vLun+fWvsZGxoyvBR8t1Vk7vS31hl
 SVg87I+4XCWL6wogpicl2VGr2JmkARd0czjkya7AUF4ZpsEWw2EleOzPfLcf28R1LdLZ QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3422u0cvte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 10:56:22 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 098E4KIo085214;
        Thu, 8 Oct 2020 10:56:21 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3422u0cvsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 10:56:21 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098EquE0013754;
        Thu, 8 Oct 2020 14:56:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 33xgx7tujx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 14:56:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098EuGCU30146896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 14:56:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BCA111C05C;
        Thu,  8 Oct 2020 14:56:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED7E011C054;
        Thu,  8 Oct 2020 14:56:15 +0000 (GMT)
Received: from [9.145.57.25] (unknown [9.145.57.25])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Oct 2020 14:56:15 +0000 (GMT)
Subject: Re: [PATCH v2 10/10] s390/dasd: Process FCES path event notification
To:     Cornelia Huck <cohuck@redhat.com>,
        Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201008131336.61100-11-sth@linux.ibm.com>
 <20201008165428.40044398.cohuck@redhat.com>
From:   =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Message-ID: <7d2ac903-5750-79f5-df04-952161bc0f0f@linux.ibm.com>
Date:   Thu, 8 Oct 2020 16:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008165428.40044398.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_08:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=938 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080106
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/20 4:54 PM, Cornelia Huck wrote:
> On Thu,  8 Oct 2020 15:13:36 +0200
> Stefan Haberland <sth@linux.ibm.com> wrote:
> 
>> From: Jan Höppner <hoeppner@linux.ibm.com>
>>
>> If the Fibre Channel Endpoint-Security status of a path changes, a
>> corresponding path event is received from the CIO layer.
>>
>> Process this event by re-reading the FCES information.
>>
>> As the information is retrieved for all paths on a single CU in one
>> call, the internal status can also be updated for all paths and no
>> processing per path is necessary.
>>
>> Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
>> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>> ---
>>  drivers/s390/block/dasd.c      | 19 +++++++++++----
>>  drivers/s390/block/dasd_eckd.c | 12 +++++++---
>>  drivers/s390/block/dasd_int.h  | 42 +++++++++++++++++++++++++++++++++-
>>  3 files changed, 64 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks a lot for reviewing the whole set, much appreciated!

regards,
Jan
