Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90EBC433DF
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 20:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B26220BED
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 20:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T/ZC7ToP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgJMUPT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 16:15:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727436AbgJMUPT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 16:15:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09DKEPm2089324;
        Tue, 13 Oct 2020 16:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wMAzr8fWhjRQn5r15H6iNLEtpvVmOWTGM2H+JNXgSIE=;
 b=T/ZC7ToPpFgoPGoQugj+dhSOjEXnLD/uEASHc+42Kdk5i9nlyJFPmienCN/foiAyxvpz
 BOyW5wmbmJBVRhmOrHbVnA7yn7yzKnEDZ76m4OMF56XJHtR+W9biORefT+3m+qWsKIUu
 oe8QkR7pJYDXBqKdOKc+9JOGfLS8sQ4BerB+VZaLCC6m7bajbgJRWxU6/iVZdccwsgRd
 nnRtArjAdySY53CxCzn2SI9SnVXYgfORRew3Mw+esFcUUkhDHYgdkO6sb7hMrui6cKEW
 jxjAht7Rwuvouskf+IywqRQX5a5RQtoJAZQX80AWxWxsOqE62gbZKbujQtM+7rBxUdfr pA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 345k3qg0qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 16:15:17 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09DKDQFD022592;
        Tue, 13 Oct 2020 20:15:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 34347h1s85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 20:15:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09DKFCr335520842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 20:15:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 380DA4204D;
        Tue, 13 Oct 2020 20:15:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E36D242042;
        Tue, 13 Oct 2020 20:15:11 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.180.112])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Oct 2020 20:15:11 +0000 (GMT)
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
From:   Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
Message-ID: <ad3caaf7-ed8e-9f21-c3a6-c385139feb7b@linux.ibm.com>
Date:   Tue, 13 Oct 2020 22:15:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <17e1142c-4108-6f74-971a-dee007162786@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_13:2020-10-13,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=885 priorityscore=1501 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 13.10.20 um 21:40 schrieb Jens Axboe:
> On 10/12/20 1:50 PM, Stefan Haberland wrote:
>> Am 12.10.20 um 21:33 schrieb Jens Axboe:
>>> On 10/12/20 1:06 PM, Stefan Haberland wrote:
>>>> Hi Jens,
>>>>
>>>> quick ping. Are you going to apply this for 5.10?
>>> I actually wasn't planning on it - it arrived a bit late, and
>>> it seemed like one of those things that needed a bit more review
>>> talk before being able to be applied.
>>>
>> OK, too bad. I had hoped that this was still OK.
>> The patches have been tested and reviewed internally for quite a while=
=2E
>> Which actually was the reason for the late submission. Cornelia also
>> gave her RB last week.
> I'm not worried about the stability of it as much as whether the specia=
l
> feature is warranted. From the former point of view, it's probably fine=

> to go in now.
>> But OK, if you think this needs some more review we will have to wait
>> for 5.11.
> I'd definitely feel more comfortable with that.
>

OK, I will take care that features will be sent earlier next time.

So, instead could you please apply the patches for 5.11 as soon as it is
suitable?


