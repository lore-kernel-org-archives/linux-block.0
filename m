Return-Path: <SRS0=jKGj=DT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B5C433E7
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 19:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2CD20BED
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 19:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ST6QdcCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgJLTuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:50:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbgJLTuq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Oct 2020 15:50:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CJWLPm093759;
        Mon, 12 Oct 2020 15:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VWPGcO3ZgggpxQYZYBbsHCTFxsPTlRztqzZpbzfdkdY=;
 b=ST6QdcCn7DzFPjh1DWCvtxHioz8asBmKaPadsVcvcxzRNUBDDQwOL0wzugHDI1J2vcV1
 +Y8ZPGHBe3DOjZ4lzCkK2ZmkuU86gczyULWiliTT+uuJuSgBKdt0dwURD7eXtZt5rUAF
 p9ecJUVX61yy26eXN2PwHjEOnXUzuhNeLY77d9aOl0kqQnHQ3m257wHPMG2ED25BCmGf
 7VP6/p7r+lnOaPhUkCgB16FS805zByeO08ae2k0rK+XT/ZKJ3ptA8Ap6UGQFmaQCH6oA
 Pvonho/xzAWnJ4ttULZWwSWqFt1SQVPBKEWfPsgSHuuxcahVekU6dEFS7w0h3i3U5UOM fA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344w3t8s66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 15:50:44 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CJkgpQ004483;
        Mon, 12 Oct 2020 19:50:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3434k7s6kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 19:50:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CJodtM29032736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 19:50:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A87A04C04A;
        Mon, 12 Oct 2020 19:50:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5756E4C040;
        Mon, 12 Oct 2020 19:50:39 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.163.240])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 19:50:39 +0000 (GMT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
 <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
From:   Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
Message-ID: <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
Date:   Mon, 12 Oct 2020 21:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_15:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=993
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 12.10.20 um 21:33 schrieb Jens Axboe:
> On 10/12/20 1:06 PM, Stefan Haberland wrote:
>> Hi Jens,
>>
>> quick ping. Are you going to apply this for 5.10?
> I actually wasn't planning on it - it arrived a bit late, and
> it seemed like one of those things that needed a bit more review
> talk before being able to be applied.
>

OK, too bad. I had hoped that this was still OK.
The patches have been tested and reviewed internally for quite a while.
Which actually was the reason for the late submission. Cornelia also
gave her RB last week.

But OK, if you think this needs some more review we will have to wait
for 5.11.


