Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06562C48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 07:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1626611EE
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 07:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFPHY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 03:24:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64080 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbhFPHY1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 03:24:27 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G7FRSv051764;
        Wed, 16 Jun 2021 03:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zX9b+Sw3MKLiKxWOQZ+yTXFWP90BJU6FpveR4UCc22A=;
 b=R254F9pk7RpmfnTeno+L9eS8A19jCojaILr6VwCocrD1i4jT3A0YuMtRFmehMeR9VTFH
 gqEfl5oAFn/T0gHbAjKl0RxakkOpZdtOag9KsoHc8f8yolSLG8q7/tJRAqeJJZiO+3BB
 tXDgAmim66kxY5m4suoYVejQMJsPM7GHiR3a1RYk7FdsvI3EX3d/F1zhmgW9lLtoK+fg
 S3N7QvJZsofk2QuaAvwEF/LzFFI9oEEEaK0nN84Y+GXmsIXeXNAJbZsVxjKJk97n8uEI
 aeE1qWjpaYbV24KuSq81Rx+BQs2VTvpfKR6riGOxVy4r1JYyH0xeiVyM8f9Sx0fvyc1H cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397crb06hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 03:22:21 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15G7GdVW054969;
        Wed, 16 Jun 2021 03:22:20 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397crb06gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 03:22:20 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15G79Sg6005624;
        Wed, 16 Jun 2021 07:22:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 394m6h92a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 07:22:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15G7MGFT9240964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 07:22:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E63794C04A;
        Wed, 16 Jun 2021 07:22:15 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC3254C040;
        Wed, 16 Jun 2021 07:22:15 +0000 (GMT)
Received: from [9.145.29.243] (unknown [9.145.29.243])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jun 2021 07:22:15 +0000 (GMT)
Subject: Re: loop_set_block_size: loop0 () has still dirty pages (nrpages=2)
To:     Karel Zak <kzak@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juergen Christ <jchrist@linux.ibm.com>
References: <8bed44f2-273c-856e-0018-69f127ea4258@linux.ibm.com>
 <YMIliuPi2tTLUJxv@T590> <cf3c803f-350e-c365-afac-0a07a9b6cee2@linux.ibm.com>
 <20210615084259.yj5pmyjonfqcg7lg@ws.net.home>
From:   Ingo Franzki <ifranzki@linux.ibm.com>
Message-ID: <72939177-a284-b5b6-e75e-2de9ab989bb4@linux.ibm.com>
Date:   Wed, 16 Jun 2021 09:22:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210615084259.yj5pmyjonfqcg7lg@ws.net.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uf0w129m6XjaDQqVOcPR1nsdgRdeqjYW
X-Proofpoint-GUID: sRbxXFlPRMouknHT3oWpBFJWlIQYTH1e
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_09:2021-06-15,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160043
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.06.2021 10:42, Karel Zak wrote:
> On Mon, Jun 14, 2021 at 09:35:30AM +0200, Ingo Franzki wrote:
>> However, shouldn't then the losetup userspace utility implement some kind of retry logic in case of -EAGAIN ?
>> I don't see that in the source of losetup.c nor in loopdev.c in the util-linux package. There is a retry loop in create_loop() in losetup.c retrying loopcxt_setup_device() in case of EBUSY, but not in case of EAGAIN.
>>
>> And losetup also hides the original error code and just returns EXIT_FAILURE in case of a failure. So no real good chance for the script that uses losetup to catch that error situation and perform a retry itself.
>>
>> Adding Karel Zak (the maintainer of util-linux).
>>
>> @Karel Zak: How about adding EAGAIN to the condition for performing a retry? 
>>
>> Something like this:
>>
>> -		if (errno == EBUSY && !hasdev && ntries < 64) {
>> +		if ((errno == EBUSY || errno == EAGAIN) && !hasdev && ntries < 64) {
>> 			xusleep(200000);
>> 			ntries++;
>> 			continue;
>> 		}
>  
> EAGAIN sounds like the best reason to try it again :-) 
> 
> Committed, it will be also available in v2.37.1.

Thanks a lot for the quick resolution!

Do you by any chance know if Fedora 34 will be updated with v2.37.1? 
I guess Fedora 35 will get it in any case.
> 
>   Karel
> 
> 


-- 
Ingo Franzki
eMail: ifranzki@linux.ibm.com  
Linux on IBM Z Development, Schoenaicher Str. 220, 71032 Boeblingen, Germany

IBM Deutschland Research & Development GmbH / Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM DATA Privacy Statement: https://www.ibm.com/privacy/us/en/
