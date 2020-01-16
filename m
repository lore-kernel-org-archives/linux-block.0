Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39682C33CB3
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0FB206E6
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 19:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r+Y7DAdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437379AbgAPTJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:09:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437384AbgAPTJL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 14:09:11 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GJ90pJ086933;
        Thu, 16 Jan 2020 19:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=vUJOBc8L8fwN+W+E7e9d5o4B0yc2nHeZhq+4rpw/zzQ=;
 b=r+Y7DAdia7cR9Jzs4WsSjQM/O1aJgfiX1L/2E8IJm9X6nFFxIfaG4IKvo5PZJgbDsW7A
 Ygx3mQzpxvcYhQro5n0QXsHsvafxunwQFYKRKkmID78iO73epV02d1pRdPHrIHJfYXcK
 gcaxqKIA+4di4w+Frpm/GlXZegn69C5PHV6+p9mj7qDbKKrQpObc9IV/NbMRgcduGBp9
 reNdb0ydpFaf2uqw+TOfG/jJ4QZ6nWfNyXEPBvdZAsBNyYM9WI7z/N5gW1+oy6uAX+0z
 7k3LXwoi6kowSM2FaTBCBiUSAhMxfg9jZP0l/pNDv35An55xk8bnXJGnAozwi9HfwL6R Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xf73yvhda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 19:09:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GJ8I2O107727;
        Thu, 16 Jan 2020 19:09:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xj1ptmawu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 19:09:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00GJ9704020695;
        Thu, 16 Jan 2020 19:09:07 GMT
Received: from [10.154.185.48] (/10.154.185.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 11:09:07 -0800
Subject: Re: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling
 io_issue_sqe()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
 <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
 <8f7986c7-e5b4-8f24-1c71-666c01b16c8b@kernel.dk>
 <1397cd55-37a6-4e14-91ac-eb3c35e7d962@kernel.dk>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <b43835cd-3bd6-705e-df51-923bbec78c67@oracle.com>
Date:   Thu, 16 Jan 2020 11:08:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1397cd55-37a6-4e14-91ac-eb3c35e7d962@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 200115-2, 01/15/2020), Outbound message
X-Antivirus-Status: Clean
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160153
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/2020 8:22 AM, Jens Axboe wrote:
> On 1/15/20 9:42 PM, Jens Axboe wrote:
>> On 1/15/20 9:34 PM, Jens Axboe wrote:
>>> On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
>>>> io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
>>>> so acquire ctx->uring_lock beforehand similar to other instances of
>>>> calling io_issue_sqe().
>>> Is the below not enough?
>> This should be better, we have two that set ->in_async, and only one
>> doesn't hold the mutex.
>>
>> If this works for you, can you resend patch 2 with that? Also add a:
>>
>> Fixes: 8a4955ff1cca ("io_uring: sqthread should grab ctx->uring_lock for submissions")
>>
>> to it as well. Thanks!
> I tested and queued this up:
>
> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.5&id=11ba820bf163e224bf5dd44e545a66a44a5b1d7a
>
> Please let me know if this works, it sits on top of the ->result patch you
> sent in.
>
That works, thanks.

I'm however still seeing a use-after-free error in the request 
completion path in nvme_unmap_data().  It happens only when testing with 
large block sizes in fio, typically > 128k, e.g. bs=256k will always hit it.

This is the error:

DMA-API: nvme 0000:00:04.0: device driver tries to free DMA memory it 
has not allocated [device address=0x6b6b6b6b6b6b6b6b] [size=1802201963 
bytes]

and this warning occasionally:

WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);

It seems like a request might be issued multiple times but I can't see 
anything in io_uring code that would account for it.

--bijan



