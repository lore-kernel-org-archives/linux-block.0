Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED706C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 02:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6FE2243E
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 02:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KYLvovaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6FE2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeKMMhc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:37:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeKMMhb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 07:37:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAD2YWWb084146;
        Tue, 13 Nov 2018 02:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=I/FKXjdl2oSkJpZZQHHJ4BWXMm4ulfFsEiyU0ClqHf0=;
 b=KYLvovaj/n11O+cisyiHUQOfJKKmkTXGL9xBqa45PWc4KwM7hZpQ9Lh7LLCBePHOrKXq
 PAEB8ZIwD2RAVtOOvZWMwhdv2quCFNDQqNjVBuYo+xrx9TCWDpVp9sKvyFm7HI9fF3QY
 GMnVPJcEILZ9y/H/ixbIUCwvQzRYwbmbI9GrxqTpun78vPgJg57I67JNC4rZGcfBdNDq
 g3hvtUwtLg226g5il2SOS95mfu1yjT/DIhJU8Bk8nw1OGfMSY//Inzx8cuzgfgFRsNj2
 JQAj+fLZ0X5m/o7TsIbxJ1hKAt0oztbLYV1e6FDeqyMKloYse6IWyP33+lg3sKCMfVfE 4w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nnwg17tar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 02:41:29 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAD2fSlg010897
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 02:41:28 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAD2fSgX002615;
        Tue, 13 Nov 2018 02:41:28 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Nov 2018 18:41:27 -0800
Subject: Re: [PATCH V5 1/6] blk-mq: make __blk_mq_issue_directly be able to
 accept NULL cookie pointer
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542014609-1769-2-git-send-email-jianchao.w.wang@oracle.com>
 <01bd2f70-cc78-9bfd-aa30-b73c44eaa9bb@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <87aa2951-54ce-e979-790f-8f1c18d78f14@oracle.com>
Date:   Tue, 13 Nov 2018 10:41:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <01bd2f70-cc78-9bfd-aa30-b73c44eaa9bb@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9075 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=872
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811130022
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

On 11/13/18 1:10 AM, Jens Axboe wrote:
> On 11/12/18 2:23 AM, Jianchao Wang wrote:
>> Make __blk_mq_issue_directly be able to accept a NULL cookie pointer
>> and remove the dummy unused_cookie in blk_mq_request_issue_directly.
> 
> What's the reasoning behind this? Seems faster to store the cookie
> always, instead of introducing a branch to the hot path.
> 

It is to make the interface more usable then we needn't input a dummy cookie
pointer but just a NULL if we don't use the return cookie.

If the introduced branch in hot path is concerned, I could drop this one.

Thanks
Jianchao
