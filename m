Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0A3C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 03:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C66206DF
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 03:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xofL2sxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfCKDzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Mar 2019 23:55:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57460 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfCKDzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Mar 2019 23:55:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2B3nDbd032033;
        Mon, 11 Mar 2019 03:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=+vREQ1wU3EPVMBrMtRt4cZAFfp1xqXNMQ12mozysDfY=;
 b=xofL2sxd2XMyfyv5maUQGxfXYdBtqcJcGdXcjFXYpfBRzZKorSOsoLp8D79BnhNWtS0N
 7NYfHvqTOTRhvKUCOfHBXxxzpA1OCAwjS7CCy/2RfUpUbqJTleWdLxbmnKtr2BsXzN4C
 ElInxP9pb+Rqq8aaVx7yNSqxSaTVySytbB4Fn5JUwdlWPme1O1t+TW1lSDQw63rHkzJm
 XXvuR4JKZ/rjMTkiDsTilq/flMoHBb22hslBViq25jeyUq55x/c0U7jX/LWmfvuIvJBO
 Jb8ePVbBKRF/zaaERJLI4O+K7n6RAwY0yWueADxSCMAP1dtX1ZGoLtDdODr1fg8AV2Z6 aQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r44wtv0pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 03:55:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2B3tOTR029910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 03:55:24 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2B3tN27009220;
        Mon, 11 Mar 2019 03:55:23 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 10 Mar 2019 20:55:23 -0700
Subject: Re: [PATCH 4/5] nvme: Fail dead namespace's entered requests
To:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-4-keith.busch@intel.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <671edb24-d3a7-988e-c1e5-3ba140da5451@oracle.com>
Date:   Mon, 11 Mar 2019 11:58:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308174006.5032-4-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9191 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=934 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110028
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith

How about introducing a per hctx queue_rq callback, then install a
separate .queue_rq callback for the dead hctx. Then we just need to
start and complete the request there.

Thanks
Jianchao

