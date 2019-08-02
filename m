Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F0C32750
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F3720B7C
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 14:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yYdbINzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392299AbfHBOWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:22:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60894 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfHBOWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 10:22:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72EDZ5L185566;
        Fri, 2 Aug 2019 14:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cOzSNxNUB+TDQp7fSOC6QxwOITKsSIdP8J8u1NwBL7E=;
 b=yYdbINzcaXpYo6neUDjG9xaj0Ee8mUdSYcKYNNFInnHKRRykl/yLtATEy4hOjYbC0QIQ
 QNW7OwbULesy2q+00BO03PK0Z36ryskXBBGFK+FDUiy0Rk9K3Vm6fCUpAzEiXoN6TFyM
 MwG5gO6YkhXW6J1Xd/PbEwHTRDiS8rWWfky9sZkQ0gTH9dxfSzq+6aq3mCt0TdQlXMUx
 RijWPScEE0/rlAEG7KKFDY9MhQDe2GGeMvC2qDXk5tI2f1seYaIi2ca0nmdEggNBDSxN
 p88rb+QBQ2yZFoLD6Z0Iw69OVCSAh2CrwZIn1di0Tke/1HwBl8V9lPNY9WMOeZuoAtqY fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u0ejq2g8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 14:16:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72EDQ0D117467;
        Fri, 2 Aug 2019 14:16:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u349f1mnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 14:16:13 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x72EGCMt015445;
        Fri, 2 Aug 2019 14:16:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 07:16:12 -0700
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, dennis@kernel.org, hare@suse.com,
        damien.lemoal@wdc.com, sagi@grimberg.me, dennisszhou@gmail.com,
        jthumshirn@suse.de, osandov@fb.com, ming.lei@redhat.com,
        tj@kernel.org, bvanassche@acm.org, martin.petersen@oracle.com
Subject: Re: [PATCH V2 0/4] block: introduce REQ_OP_ZONE_RESET_ALL
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
        <0c30519f-2829-ec2c-8fb4-ccddd2580321@kernel.dk>
Date:   Fri, 02 Aug 2019 10:16:09 -0400
In-Reply-To: <0c30519f-2829-ec2c-8fb4-ccddd2580321@kernel.dk> (Jens Axboe's
        message of "Fri, 2 Aug 2019 07:41:47 -0600")
Message-ID: <yq1r263irfa.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=954
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020148
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

> Martin, I'd like someone to vet/review the SCSI side of it before I
> apply it.

Looks good to me.

-- 
Martin K. Petersen	Oracle Linux Engineering
