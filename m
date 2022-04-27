Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D564C433FE
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 19:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiD0Ttt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 15:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiD0Tsx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 15:48:53 -0400
X-Greylist: delayed 678 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 12:43:56 PDT
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A222D1F9
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 12:43:56 -0700 (PDT)
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RGnS90026015;
        Wed, 27 Apr 2022 20:32:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=En4aHoZK3NbhY+oA5W/g9EOIPnQRFnsBfonDIymvc9Y=;
 b=IWka3CnC55i6Q8EvMmC29w77OtNOB4bqnr16MsywCbhjLrK0UxNrzpqh9KHWcQE1XPG+
 j4V7Eunj2lv54Gc41I1i+4TjJokyTDCB8GJ/dwYMy10Tkrkt8vy70sEiJmJGxI7vCBYK
 PIfIiBFIBgq0jeL05KlEeh8gtDE3op1SoiykCO3MS9iYjtUmjvN/U6m+v1q1V63YMeQ8
 qkI90/JLnYjf5U7dqQ23ppDQ+1AtLFgjpFbdgg7dqRyC9Lgk153O3Y24Y0JaJlJWesnr
 aof/EHtfQUV6FDn3NF7j4FVoTBdmnYroyNMtnkJuw3cXkylsATdgDEDpnFuM4fp2ould SQ== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3fpskm7jvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 20:32:28 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 23RJIxm1029597;
        Wed, 27 Apr 2022 15:32:27 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint4.akamai.com with ESMTP id 3fmct0ypav-1;
        Wed, 27 Apr 2022 15:32:27 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 2685A6018D;
        Wed, 27 Apr 2022 19:32:26 +0000 (GMT)
Message-ID: <63116fb6-bc11-d551-6734-f5407c8f3af4@akamai.com>
Date:   Wed, 27 Apr 2022 12:32:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Precise disk statistics
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>,
        "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
Cc:     "yukuai (C)" <yukuai3@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <1650661324247.40468@akamai.com> <1650915337169.63486@akamai.com>
 <87031651-ba75-2b6f-8a5e-b0b4ef41c65f@huawei.com>
 <1651017390610.22782@akamai.com>
 <alpine.LRH.2.02.2204270549490.10147@file01.intranet.prod.int.rdu2.redhat.com>
From:   Josh Hunt <johunt@akamai.com>
In-Reply-To: <alpine.LRH.2.02.2204270549490.10147@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=812 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270120
X-Proofpoint-GUID: nnwFYBv1rIHTXbYSSpRLT-bhx1wUjvYP
X-Proofpoint-ORIG-GUID: nnwFYBv1rIHTXbYSSpRLT-bhx1wUjvYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=807 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270120
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/22 02:57, Mikulas Patocka wrote:
>> [+ Mikulas and Ming]
>>
>> I see. Thank you for the response, Kuai, appreciate it.
>>
>> The conversation here https://urldefense.com/v3/__https://lkml.org/lkml/2020/3/24/1870__;!!GjvTz_vk!US3LozmCgynsWtz-1LkwhFPTXfY0XZNT7XKAw9GSNjZn0JkehqevMU7StsFKkjsS9b1hfGRsOCu0e1E$  hints at
>> potential improvements to io_ticks tracking.
>>
>> @Mikulas, Mike, please let us know if you have plans for more accurate
>> accounting or if there is some idea we can work on and submit a patch.
> 
> I know that the accounting is not accurate, but more accurate accounting
> needed a shared atomic variable and it caused performance degradation. So,
> we don't plan to improve the accounting.

Thanks this is all very helpful.

If we know the accounting is not accurate then is there any reason to 
keep it around? What value is it providing? Also, should we update tools 
that use ioticks like iostat to report that disk utilization is 
deprecated and should not be referred to going forward?

Josh
