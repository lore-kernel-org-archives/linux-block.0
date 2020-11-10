Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875FBC388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4F020674
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 15:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DHvuCqjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgKJPwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:52:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726721AbgKJPwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 10:52:22 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAFkv4j150651;
        Tue, 10 Nov 2020 10:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WeGskIQqtSbIZM7/zDMutEYYyecROKoFmboUQXGkHoA=;
 b=DHvuCqjHY/4r7aTMOFYFObfsKoVrJRa+7GrUl6KNgMJp1XpZXAQmyd+AbKO/UBOtdBFa
 3x+9NjfrNWI8wp7YUVpHrje4gHhR2VCpWkKVMSFrpERX4gosG+nxYZsiD/I7HOBVaSp0
 YC7WoLW29Bb0N6wbSk3KYoSVdPW2/9WN32L6s4jgTUCF6l81oWHfQFthpdCTkDZDCPvp
 H2pjneY5wzg/+sjGYoeWTKySwi8aNkcZkT2E4PUM/f1avFlfjI0EX86Qf6VPiOSNq11F
 nmlsJOjFdHxADQCRVi1jr2Z8L799ww+NFfA+tlTE5lJJliTTx5WeUibGO3LqjFnJ9hMe Mw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qanb743v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 10:52:19 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AAFWFgo004506;
        Tue, 10 Nov 2020 15:50:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 34nk78kajq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 15:50:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AAFoscJ7930390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 15:50:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD1324C04A;
        Tue, 10 Nov 2020 15:50:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DA2D4C050;
        Tue, 10 Nov 2020 15:50:53 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.47.150])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Nov 2020 15:50:53 +0000 (GMT)
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
From:   Stefan Haberland <sth@linux.ibm.com>
Message-ID: <30740ed3-21b9-71cd-b48c-1d6947c6f029@linux.ibm.com>
Date:   Tue, 10 Nov 2020 16:50:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6468cfad-e14c-060d-a525-00d75fe66819@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_06:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 mlxlogscore=815 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100111
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 14.10.20 um 03:19 schrieb Jens Axboe:
>
>> So, instead could you please apply the patches for 5.11 as soon as it is
>> suitable?
> I will - I have it queued up, won't create anything public until we
> get past the merge window.
>

Sorry to bother you again with this.
Is there any outlook when you are going to push the patches to your
for-next branch?

Or shall I resend the patches?

