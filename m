Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC4C10F13
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 03:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E42206B7
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 03:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+Y8+l4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfDODVb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 23:21:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51726 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDODVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 23:21:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F3ItdD001908;
        Mon, 15 Apr 2019 03:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uRKJZMtH9o5Widzr70y2k1rpemlJMN/Lq0UmCe+NoeY=;
 b=O+Y8+l4QMWx+Rrmc34F3gFWFf68SL3bH4hR3HgVs1RAChDnQj55/17PBEBwnqA2P6Dqz
 BWIXIGaJ9JWY5u/zsiutl3cSdIj4yWY8uLO7JHikjsHfhCSJFRVqvn79bJAgv0moTwHX
 CC1URSQbtszVqxtsBHRuOoLzTf0H6mRWIyRp9vaM3C4DuBlXFasMOfLx9oCu63vJa98v
 IKV1afc/Os/4NfgUqAQtj/5FWEF2MFPxGucmrQg+ULlw2wbnjuZBLFdix0/Z749qYy2S
 2mYia4h1X8qiJi8KWFP4jYLnSEKjpQYqBajJ4uacfKYk4YwlbQyZ1PBnhRPfH1yjACAS tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ru76t43e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 03:21:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F3KKwP057713;
        Mon, 15 Apr 2019 03:21:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2rubq5gsf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 03:21:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3F3LPsj024153;
        Mon, 15 Apr 2019 03:21:26 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Apr 2019 20:21:24 -0700
Subject: Re: io_uring is zero copy or not?
To:     Feng Li <lifeng1519@gmail.com>
References: <CAEK8JBAGxbVan-zsQDmu4upOVzp91fwbCU6cVtXi9D4TUs1p=A@mail.gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <f1e9e648-9321-d4b1-6a25-ea1b611719a8@oracle.com>
Date:   Mon, 15 Apr 2019 11:25:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEK8JBAGxbVan-zsQDmu4upOVzp91fwbCU6cVtXi9D4TUs1p=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=656
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150020
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=686 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/15/19 11:09 AM, Feng Li wrote:
> Hi Jens,
> 
> I'm interested in the io_uring, and have a doubt about it.
> If I setup io_uring with IORING_REGISTER_BUFFERS,
> the kernel doesn't need copy data from user space to the kernel, right?
> Does it mean this is a zero-copy feature?

Doesn't it depends on the definition of 'copy'?

There is still a copy from original userspace pages to the registered buffer?

Dongli Zhang

> 
> From the code, kernel directly get the userspace virtual address's
> pages and store them:
> 
> 2475 pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
> 2476 pages, vmas);
> 
> 
> 
