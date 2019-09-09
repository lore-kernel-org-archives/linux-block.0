Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D33C433EF
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 02:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293A52086D
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 02:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IS9Lj8bR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbfIICt0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Sep 2019 22:49:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35998 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbfIICt0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Sep 2019 22:49:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892iUCM114038;
        Mon, 9 Sep 2019 02:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=4MN8jJzoNciSq/uZgMjvZeXOoEJlNQnAC2ubMM68AYY=;
 b=IS9Lj8bRziQ/xr52QlYlkf4YZpEEB7Xig0vdOjhSyYJC1aoEcARJDpX2A418aNoN4LkU
 7VF4HWud9m5DRByR6ngLJ9DVZdwdqKQll6oswKKZnEeZ60TePchkz2W01M7NjCMYfcRM
 l3o9YfC6FIi4YBSYLI8/4iHmTkuxdR73+F+QDYX22iHPGlg3tmcCItVKdF+114PfKkTQ
 UCTbQZ6ScKueXRY9kdbzN5YxaI3sMqLQoluZRZ5bmV3YbIFT7tOyID915pHS/S/5gowC
 YKKNEMGI2SWjp4Yf4RJB4082ayASgn60GWnVnticXnLR7Y9Ri3imfrF8Fi7jOsr/PP5z 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uw1jk19d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Sep 2019 02:49:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x892mol9033636;
        Mon, 9 Sep 2019 02:49:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2uv3wkwpv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Sep 2019 02:49:04 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x892n3gm012458;
        Mon, 9 Sep 2019 02:49:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 08 Sep 2019 19:49:03 -0700
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>, axboe@kernel.dk,
        keith.busch@intel.com, sagi@grimberg.me, israelr@mellanox.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        shlomin@mellanox.com, hch@lst.de
Subject: Re: [PATCH v4 2/3] block: don't remap ref tag for T10 PI type 0
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
        <1567956405-5585-2-git-send-email-maxg@mellanox.com>
        <yq1ftl6i4xx.fsf@oracle.com> <20190909023601.GA6772@keith-busch>
Date:   Sun, 08 Sep 2019 22:49:00 -0400
In-Reply-To: <20190909023601.GA6772@keith-busch> (Keith Busch's message of
        "Sun, 8 Sep 2019 20:36:02 -0600")
Message-ID: <yq136h6i3qb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=753
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909090029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9374 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=816 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909090029
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Keith,

> At least for nvme, type 0 means you have meta data but not for
> protection information,

Yeah, NVMe does not support DIX Type 0.

> so remapping the place the where reference tag exists for other PI
> types corrupts the metadata.

But the device shouldn't have an integrity profile in that case (see
previous mail about why keying off of the protection_type is a problem).

-- 
Martin K. Petersen	Oracle Linux Engineering
