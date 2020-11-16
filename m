Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161E5C61DD8
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 04:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C101C20773
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 04:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SVyMZhuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKPD6C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Nov 2020 22:58:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgKPD6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Nov 2020 22:58:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AG3ohdG063656;
        Mon, 16 Nov 2020 03:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=1/ZcOLHpYBSkWwqi4Q3cA0tNOhEviNVW1rpuzjWsg5Y=;
 b=SVyMZhuXcxCo53XMMDfPquQDOmv0xQ8Dpc0VoEjVcdcuEJIIXj9Vp1+FhdRVLli6ry8p
 TNHFBkqrQyz+PdvYYVdBxX+j7hQuuG7I791qwaTOwUYRFgJF+7fUF9yOR9nPLWaKEn06
 j5FjSfkmhEr6lJskTQDsDKl2PYysM1ous2+2IKRbqsaTf0qZVZ4YlBlHvvVfc82/3ZJy
 zRgzfIrBuMCwH1AxHrAu/jkoSn0D3UTMNFLTLZnbO8gEqomKhLGi9hp0eFH7hrFhuEC0
 Upi7BL7IWCyvwbcKYDcWIHxhU92Jqj8rJwVPv6wTrahagkeoIsuRCFX4N2Olsm/lrQei Hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34t76kk7mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 03:57:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AG3nUsM110787;
        Mon, 16 Nov 2020 03:55:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34trtk5bk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 03:55:54 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AG3tdF5012629;
        Mon, 16 Nov 2020 03:55:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 15 Nov 2020 19:55:38 -0800
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Fix read-only block device setting after
 revalidate
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tutq6mbb.fsf@ca-mkp.ca.oracle.com>
References: <20201113084702.4164912-1-hch@lst.de>
        <20201113084702.4164912-2-hch@lst.de>
Date:   Sun, 15 Nov 2020 22:55:36 -0500
In-Reply-To: <20201113084702.4164912-2-hch@lst.de> (Christoph Hellwig's
        message of "Fri, 13 Nov 2020 09:47:00 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160023
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Christoph!

> [hch: rebased.  don't mirror the compound read-only flag into a field,

My original patch separated "should-write-bios-be-rejected?" state from
"did-the-user-set-this-partition-ro?". In the rebased version a
full-device state transition in update_all_part_ro_state() blows away
any policy the user has set on a given partition.

The blktests that fail are due to something like:

# modprobe scsi_debug num_parts=2
# blockdev --setro /dev/sda2
# grep . /sys/block/sda/sda2/ro
1
# echo 1 > /sys/module/scsi_debug/parameters/wp
# echo 1 > /sys/block/sda/device/rescan
# echo 0 > /sys/module/scsi_debug/parameters/wp
# echo 1 > /sys/block/sda/device/rescan
# grep . /sys/block/sda/sda2/ro
0

The user expectation is that since they set partition 2 readonly it
should remain that way until they either clear the flag or issue
BLKRRPART to cause the partition table to be reread.

-- 
Martin K. Petersen	Oracle Linux Engineering
