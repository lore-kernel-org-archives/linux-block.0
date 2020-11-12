Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D8EC2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 13:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C01B2220B
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 13:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="grrkG6/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgKLN1h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:27:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727646AbgKLN1h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 08:27:37 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACD6Jn5172513;
        Thu, 12 Nov 2020 08:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NzEgnrbUfI1x4kE15Olf1XiFnie3lsOSefREnbDal9U=;
 b=grrkG6/Xanfo/34+iWWlGVlg/hJcI0snlqxqxEM7nSyJXmrmAHLEgElDEI7ba1/NbwMC
 UUgm8ZGcpzKR2ug11Yz8NWExSAU7f7FU9VMiu0kqM1siTmZmw0SsgUSOdVuN4i9FnsdE
 I83RdvPNe0B4TT9cp7QG43FbOqIMz+ym0v2UeFTB/ObzWcCjB9AJFqvwiKF2TqBvHeGT
 zQiMyfoftTYRNbEVr7lXlOVJ8KvSDUXDGsJM0/tnUIzq9yjRvXJFHfpmE801+iIL6JkL
 6PFK0tTFrAXMDW2NLZGLWtNCqDxM+HX1f913IlF1GVG5so+gGW/H9v3e4fqnAgqcLJug MQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34s5msrk56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 08:27:35 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACDM5En000342;
        Thu, 12 Nov 2020 13:27:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 34nk782wcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 13:27:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ACDRVKq3867378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 13:27:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A5105204E;
        Thu, 12 Nov 2020 13:27:31 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.59.230])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A3B675204F;
        Thu, 12 Nov 2020 13:27:30 +0000 (GMT)
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
 <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
 <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
 <17e1142c-4108-6f74-971a-dee007162786@kernel.dk>
 <ad3caaf7-ed8e-9f21-c3a6-c385139feb7b@linux.ibm.com>
 <6468cfad-e14c-060d-a525-00d75fe66819@kernel.dk>
 <30740ed3-21b9-71cd-b48c-1d6947c6f029@linux.ibm.com>
 <be2933c0-4827-ab38-872f-01cb02e44fc4@kernel.dk>
From:   Stefan Haberland <sth@linux.ibm.com>
Message-ID: <cb795828-48db-570b-e04d-cc1da6a87c95@linux.ibm.com>
Date:   Thu, 12 Nov 2020 14:27:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <be2933c0-4827-ab38-872f-01cb02e44fc4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_05:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=833
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120075
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 11.11.20 um 17:20 schrieb Jens Axboe:
> On 11/10/20 8:50 AM, Stefan Haberland wrote:
>> Am 14.10.20 um 03:19 schrieb Jens Axboe:
>>>> So, instead could you please apply the patches for 5.11 as soon as it is
>>>> suitable?
>>> I will - I have it queued up, won't create anything public until we
>>> get past the merge window.
>>>
>> Sorry to bother you again with this.
>> Is there any outlook when you are going to push the patches to your
>> for-next branch?
>>
>> Or shall I resend the patches?
> I already did apply it, just don't push out next release branches
> that early. Pushed out now, so it is in.
>

Thanks a lot.
