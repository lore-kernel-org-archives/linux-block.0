Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FCFC33C9E
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 03:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E38E206F0
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 03:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fjyE/L+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgAIDdV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 22:33:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46754 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIDdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 22:33:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093X6ZQ172912;
        Thu, 9 Jan 2020 03:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=VZ2TqqhPaSVHPFCAp9VkRzjFCSnuYTScC7/s8agUkio=;
 b=fjyE/L+jNX+n98vIuWlmkegIicSZka25fXXqO1N0OaEemyKeMKzZT0UyBvlSMvjESw/S
 C96XCfmhYBPaDucAw0Vz+pF9OWrZZmP82UpDN98Hp7Aq9oHVQAqjx+SaPP63YY19msNh
 ZtPXQkzjSPoc1QACp/6BaT+Pl8MKlhAzmSKHdyFzpLTHXu5Rz55O7vTfP9KnTBuTnj9n
 fxTrXAmYHMexVm7uOIj4NY8Zv5bJ9lFpGAHTy9nI2urV8mq3EItqeqR2BYBSeG62EgmY
 QQRCQKgJH13O91NdBKcy/lDtQLpv7MqH0qeGumW4Sx8s5HBsjjlPXqAg0fFZIJk1Gwiq vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbr00d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jan 2020 03:33:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093X9LJ106882;
        Thu, 9 Jan 2020 03:33:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xdmrx8p5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jan 2020 03:33:08 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0093X3XP026880;
        Thu, 9 Jan 2020 03:33:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jan 2020 19:33:02 -0800
To:     "hch\@lst.de" <hch@lst.de>
Cc:     "Singh\, Balbir" <sblbir@amazon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chaitanya.Kulkarni\@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme\@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "jejb\@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst\@redhat.com" <mst@redhat.com>,
        "axboe\@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju\, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use disk_set_capacity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200102075315.22652-1-sblbir@amazon.com>
        <20200102075315.22652-5-sblbir@amazon.com>
        <BYAPR04MB57490FFCC025A88F4D97D40A86220@BYAPR04MB5749.namprd04.prod.outlook.com>
        <1b88bedc6d5435fa7154f3356fa3f1a3e6888ded.camel@amazon.com>
        <20200108150447.GC10975@lst.de>
Date:   Wed, 08 Jan 2020 22:33:00 -0500
In-Reply-To: <20200108150447.GC10975@lst.de> (hch@lst.de's message of "Wed, 8
        Jan 2020 16:04:47 +0100")
Message-ID: <yq1k161xq1f.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=854
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001090033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=915 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001090033
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

>> The expected behaviour is not clear, but the functionality is not
>> broken, user space should be able to deal with a resize event where
>> the previous capacity == new capacity IMHO.
>
> I think it makes sense to not bother with a notification unless there
> is an actual change.

I agree.

-- 
Martin K. Petersen	Oracle Linux Engineering
