Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD287C43331
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 11:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8144A20786
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 11:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XXkSA/2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCXLDa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:03:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXLDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 07:03:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OAsEGM039518;
        Tue, 24 Mar 2020 11:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=x4uMEC8YdZFduFruwe6jobGlWhXqv6+0URS9V3CSpC8=;
 b=XXkSA/2GiNBvPGj/OsxSCFfS4fNi2khAlETOIrNOGMbf5yoph1/ApI8pLqlwkVEBix9B
 q7WcTFlVwXAVGd5SoUKSVZ0OVaieFfCpldaE6+WxJfdFL1TmzVANDhfHQYYHaqJnHHY6
 CjPYalS3BoQY+c+Vjl2R4atOh0wCPcSmem8dJTGas2WpRzltobuZIRHQ5lrjTwiE/bVx
 hUPDYMBqhsKo9d2SKuX94owg4EV9i1UHpUfmwNOjL3sziLQzO+Mpz49dOLO9X0vLs/qh
 CjaB25VikL05q7iApxxzD/Tncnqyg80n20y+dUuOeNcgUkAVmjmhZC7bbTLPh5T/c4FJ qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yx8ac0jvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 11:03:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OApXjK110378;
        Tue, 24 Mar 2020 11:03:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yxw6mfp69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 11:03:24 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02OB3MdY025839;
        Tue, 24 Mar 2020 11:03:22 GMT
Received: from localhost.localdomain (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 04:03:22 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     dm-devel@redhat.com
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        Dmitry.Fomichev@wdc.com, hare@suse.de, Bob Liu <bob.liu@oracle.com>
Subject: [RFC PATCH v2 0/3] dm zoned: extend the way of exposing zoned block device
Date:   Tue, 24 Mar 2020 19:02:52 +0800
Message-Id: <20200324110255.8385-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=765 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=1 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=839
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240059
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Motivation:
dm-zoned exposes a zoned block device(ZBC) as a regular block device by storing
metadata and buffering random writes in its conventional zones.
This way is not flexible, there must be enough conventional zones and the
performance may be constrained.

This patchset split the metadata from zoned device to an extra regular device,
with aim to increase the flexibility and potential performance.
For example, now we can store metadata in a faster device like persistent memory.
Also random writes can go to the regular devices in this version.

Usage(will send user space patches later):
> dmzadm --format $zoned_dev --regular=$regu_dev --force
> echo "0 $size zoned $regu_dev $zoned_dev" | dmsetup create $dm-zoned-name

v2:
 * emulate regular device zone info
 * support write both metadata and random writes to regular dev

Bob Liu (3):
  dm zoned: rename dev name to zoned_dev
  dm zoned: introduce regular device to dm-zoned-target
  dm zoned: add regular device info to metadata

 drivers/md/dm-zoned-metadata.c | 205 +++++++++++++++++++++++++++--------------
 drivers/md/dm-zoned-target.c   | 205 +++++++++++++++++++++++------------------
 drivers/md/dm-zoned.h          |  53 ++++++++++-
 3 files changed, 299 insertions(+), 164 deletions(-)

-- 
2.9.5

