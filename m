Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87AAC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858A320700
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 09:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3sCEy9rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfC0Jje (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:39:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47050 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0Jje (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 05:39:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2R9TYA6013736;
        Wed, 27 Mar 2019 09:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=T6FxGEX8wZ0ucXVUO/6cQUUaT4yt29W6rySXrN49bns=;
 b=3sCEy9rdHI94R5ngXBhqLAX6GelYck557nol2RjoqSWNy7P+Op3poxrdF1r6IWfDGGp3
 MJjpvKYcAWownJJp8qyKXPZeSQn8NoXtLWjJ+DW2dPaJvmdFjQcbBCadM/CA75RR0QOR
 OhYZMNVsWwzMr1X1diKU9o8TFn9rvag3cKVhcm2d8sOTLeHsghLPkMfaLHEm3BiaDTim
 uCioLjqMrD1R16fVKballXL7/6ouXybsC7LLTTtFK+5GlVHgrkt32/KhSoZKf/EVwHR7
 5vh11GHUT4o58bN2d5lSkrI7JuTCo1QQgoq0v04EBrDWdbThNMsjDKU0qNiUT2SYbQHg cw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2re6djfg74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 09:39:23 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2R9dM35011189
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 09:39:22 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2R9dLUD006899;
        Wed, 27 Mar 2019 09:39:21 GMT
Received: from [192.168.2.8] (/106.39.150.192)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 02:39:21 -0700
Subject: Re: [PATCH] make blk_mq_map_queues more friendly for cpu topology
To:     luferry <luferry@163.com>
References: <20190325152640.48120-1-luferry@163.com>
 <20190326073954.GD21617@lst.de>
 <48ca2186.fc76.169b8fef63a.Coremail.luferry@163.com>
 <20190327081619.GG20525@lst.de>
 <764f3c.12445.169be70834b.Coremail.luferry@163.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <8e02b730-b504-50a2-64e6-72817b07e93d@oracle.com>
Date:   Wed, 27 Mar 2019 17:39:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <764f3c.12445.169be70834b.Coremail.luferry@163.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=675 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270069
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 03/27/2019 05:17 PM, luferry wrote:
> 
> 
> 
> Actually,  I just bought one vm from public cloud provider and run into this problem.
> after reading code and compare pci device info, I reproduce this scenario.

There is lack of vector issue when number of queues is more than maxcpus as well.

https://lore.kernel.org/lkml/e4afe4c5-0262-4500-aeec-60f30734b4fc@default

I was going to send out patch to fix that specific case on virtio side.

BTW, is your VM's virtio mmio based or pci based?

As mentioned in previous email, when I was playing with firecracker by amazon,
the virtio-blk is mmio based. Not sure if that would lead to the lack of vector
issue.

Dongli Zhang
