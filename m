Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB76CC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 03:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD19420850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 03:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aC5ljE8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD19420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeLDDzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:55:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeLDDzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 22:55:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB43sTe6022240;
        Tue, 4 Dec 2018 03:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xw+ycnsmmRpehYiAeaNdSgpBW/9N3QNg55eCLzW19DY=;
 b=aC5ljE8dAi+ODqvGY4VXkfP/B7iE/l4tW9udpXMjYD2lQ+4KUB8eqAGQUlzhfiidhW10
 Sa2avpVwiG2lqKldrqpgu7RvmYmNXFRnQv7z8LiLH+rp9F5tUoHIBnqFKOH4dmNzl89D
 g8qHGWgb4aHGSXGN++dW9ib9CF0qZGa0VXLhNENlIXSAOeZQ+iEDPDx8mPVf1METpWvf
 NGMjAKToSyASo1B18x95+zzNYLaGN+Jgw9QfeZ+d8/WGbLnnDrx2A2tCYOBp/XvosF14
 2jqHkksh1/hIg91Gg1WbHT/0VzNtsdD0/Lk1W1Oqvh79bbBs4zEBb8YosquyF8AzBX2v Sw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p3jxr9x0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 03:55:29 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB43tSE1011266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 03:55:29 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB43tSFT032690;
        Tue, 4 Dec 2018 03:55:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 19:55:27 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "chenxiang \(M\)" <chenxiang66@hisilicon.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Steffen Maier <maier@linux.ibm.com>
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
        <20181127130811.GA2780@ming.t460p>
        <6c573f36-60d8-0631-e9ac-dacd72f6c8ad@hisilicon.com>
        <20181130011935.GA7573@ming.t460p>
        <e0e07583-98ca-4fc5-e60d-055e5474c084@huawei.com>
Date:   Mon, 03 Dec 2018 22:55:25 -0500
In-Reply-To: <e0e07583-98ca-4fc5-e60d-055e5474c084@huawei.com> (John Garry's
        message of "Fri, 30 Nov 2018 11:26:07 +0000")
Message-ID: <yq1k1kqt07m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040032
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi John,

> We have also noticed that if we just enable DIF in hisi_sas (with MQ),
> and not DIX, then no issue.

Enabling DIF doesn't really do anything on the kernel side other than
setting PROTECT=1 in the READ/WRITE CDB and telling the driver which DIX
protection operation the HBA should use. Since protection information is
invisible to the kernel and only sent on the wire between initiator and
target, enabling DIF doesn't really have the ability to interfere with
anything on the kernel side. We're basically just setting flags asking
HBA and storage to enable protected transfers.

> I did also noticed mail "[PATCH v2 01/23] zfcp: make DIX experimental,
> disabled, and independent of DIF", where DIX is made experimental.

...for the zfcp driver on zSeries.

Just nitpicking on terminology here:

T10 Protection Information (formerly known as DIF) describes how to
generate and verify 8 bytes of extra information that's sent trailing
each logical block on the wire between an initiator and target. The T10
PI spec is focused on the target device implementation of this and
largely ignores the initiator side.

DIX tries to remedy this deficiency. It is a spec that describes a set
of logical operations an initiator must implement to facilitate sending
and receiving the T10 protection information to/from host memory instead
of terminating it at the HBA. The DIX spec isn't experimental, it's
about a decade old and hasn't changed in years.

The Linux kernel support for data integrity passthrough in the block
layer and SCSI isn't experimental either. It's also a decade old and
used extensively in production.

So I object to the notion of "DIX being made experimental". An
ASIC/firmware/driver implementation of DIX may be experimental. And of
course I can't rule out regressions in the kernel block integrity
implementation as a result of some of the recent MQ changes (will be
happy to work with you guys to figure those out).

But DIX isn't experimental, nor is the kernel support for passing
protection information to an HBA.

> For now we may not support DIX. It seems to have issues. We wanted to
> try 3008 card on our system, but it does not seem to support DIX 0-3.

For some reason Broadcom have not upstreamed their DIX support. It's
supposedly available in their outbox driver.

-- 
Martin K. Petersen	Oracle Linux Engineering
