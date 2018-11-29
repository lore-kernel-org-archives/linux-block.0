Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AD4C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 02:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A3B206B6
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 02:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qh0tFGJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A3B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeK2Nnm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:43:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33792 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeK2Nnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 08:43:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAT2d1XR087528;
        Thu, 29 Nov 2018 02:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=BgaSc0tBIjA2WcoXmp+eGKvdbZIcMyrLcFJnZSIHX+c=;
 b=qh0tFGJylffoMOu0T7K3Eeoe5ZHhNSned3Y3qX/PGXIKeinggESg+cJYyiX+tMs1q4g8
 jHphHZHaBO6NjpTms621YTdJbBRRFavWGkoP46Zow7CwaAGDL4ufWrDq6GSnChZXBf7r
 CSwIs4v5iY1D0u4O+lX63YjEBrYXRoqn47GQyjy6LyoasLFItdv+M5zpGsommDOOIsqv
 eGfgFptfqi7ZT43865DZ3hXnl9qzZMekiJOHwy+ZeTnCwkyavtrnMH5DeTGgfkNtz2GW
 u+9rbjFn7RJ8kEOdoPOb1QPeT1j/zNmPso8CVAmDrCfbQyb5rYukOnfk4yZ+wD4uR4UE ag== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqnnkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:39:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAT2dmlH006715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:39:48 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAT2dlHg022801;
        Thu, 29 Nov 2018 02:39:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 18:39:46 -0800
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181126165430.4519-1-keith.busch@intel.com>
        <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
        <20181128021959.GG11128@ming.t460p> <20181128070010.GA20369@lst.de>
        <20181128100659.GA16495@ming.t460p> <20181128100848.GA23567@lst.de>
        <20181129021521.GB23390@ming.t460p>
Date:   Wed, 28 Nov 2018 21:39:44 -0500
In-Reply-To: <20181129021521.GB23390@ming.t460p> (Ming Lei's message of "Thu,
        29 Nov 2018 10:15:22 +0800")
Message-ID: <yq1woowzjwv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=881
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290019
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming,

> On Wed, Nov 28, 2018 at 11:08:48AM +0100, Christoph Hellwig wrote:
>> On Wed, Nov 28, 2018 at 06:07:01PM +0800, Ming Lei wrote:
>> > > Is this the nvme target on top of null_blk?
>> > 
>> > Yes.
>> 
>> And it goes away if you revert just the last patch?
>
> Today I run this test again and can't reproduce it any more.
>
> So maybe not a new issue, and it is just triggered in yesterday's
> for-4.21/block, :-)

Can you reproduce with yesterday's tree then?

I'm obviously a bit concerned about merging something without knowing
the cause of the problems you were seeing.

-- 
Martin K. Petersen	Oracle Linux Engineering
