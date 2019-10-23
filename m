Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617ACCA9EB6
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 13:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9D421872
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 13:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WI8R13my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390775AbfJWNGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:06:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40350 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390642AbfJWNGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 09:06:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9NCx0Kh136480;
        Wed, 23 Oct 2019 13:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=Uufi+F2i4iGe/1EsLuYEJ9D1mRissFr8zk+NN/1AJLo=;
 b=WI8R13myYVtm4SFmekeuR8F2HvwirQD5q4BZ+w8cQ9PGwvbkQOxczZQUL404lENBj37p
 z8UCqsiFXePLAgBGeob/J6tnWCEgOpjtYfQdaapBNxRafk5FrA+Wu1vFjuz57/ovHsLl
 42Qr/W4PeD5NMmV+u43nHGwtGlaVwjWqx6tZJlVVoKMBypiC1QinKdU8Ac6846Ege4Nb
 nrDwP/6p+k62OjO5Ks7tc8zOf+qhdHbBjEncnAKptZE6TAMiz6AInn2Wo+YTdnJLpoLp
 wADf8ST6IW0eRoSc03GEEWBZQYBYLYcVVy5m7ELgdPb+UuuLmQErL7/jvfIjBlF+gAxl dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4qw181-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 13:06:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ND4KAR126704;
        Wed, 23 Oct 2019 13:06:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vtjkfqqyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 13:06:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9ND6aql028538;
        Wed, 23 Oct 2019 13:06:37 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Oct 2019 06:06:36 -0700
Date:   Wed, 23 Oct 2019 16:06:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ajay.joshi@wdc.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] null_blk: return fixed zoned reads > write pointer
Message-ID: <20191023130623.GA3196@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230134
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ajay Joshi,

The patch dd85b4922de1: "null_blk: return fixed zoned reads > write
pointer" from Oct 17, 2019, leads to the following static checker
warning:

	drivers/block/null_blk_zoned.c:91 null_zone_valid_read_len()
	warn: uncapped user index 'dev->zones[null_zone_no(dev, sector)]'

drivers/block/null_blk_zoned.c
    87  size_t null_zone_valid_read_len(struct nullb *nullb,
    88                                  sector_t sector, unsigned int len)
    89  {
    90          struct nullb_device *dev = nullb->dev;
    91          struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    92          unsigned int nr_sectors = len >> SECTOR_SHIFT;
    93  
    94          /* Read must be below the write pointer position */
    95          if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    96              sector + nr_sectors <= zone->wp)
    97                  return len;
    98  
    99          if (sector > zone->wp)
                    ^^^^^^^^^^^^^^^^^

Smatch complains about "sector" being from the untrusted all the time
and I kind of just ignore it these days.  But here it looks like we're
checking "sector" after we already used it so that seems very suspicious.
It feels like "sector > zone->wp" should come at the very start of the
function.

   100                  return 0;
   101  
   102          return (zone->wp - sector) << SECTOR_SHIFT;
   103  }

regards,
dan carpenter
