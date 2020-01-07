Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6E6C3F68F
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 04:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B112075A
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 04:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXF17GSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgAGEjy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:39:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50356 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgAGEjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 23:39:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0074dSia088622;
        Tue, 7 Jan 2020 04:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=Ut4HfjsleA5SVSMZ/IcSbSv3IYy2cHSpvO/X4+oPjeU=;
 b=EXF17GSlVh5i6vXJiSRt/n8Bu0aBoDDIf6+UwUKjkjbEbwVxR98Y/Mfo/tFNFG/NpEMa
 wtt9DuKSzEVCgw9uuAAoaxZIPpiELCgvaB7r4615rv95+tBOlD0Yz7DpH9980dugJjrG
 ZTWTTpfK15v+ykRTFqqbrPqaTQwCjCP6sU/QTVVZc2hbXIW471+/0cFQmQzxjrufZOWb
 UykUo/M5Tc83KNeiH9EH3diV5G0rOR6ds0oBikOq9NeNUsw6X+u+oLxBX2Utzhcys3uD
 R2twC+4j8SEbMz5pqa/nnN9WaJjNe9WMTSZIjJA0gVnR/x5bmCarGCcFR955oyuR0Hqr 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbqjvx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 04:39:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0074YEpR115118;
        Tue, 7 Jan 2020 04:39:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xcjvc8p7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 04:39:29 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0074dSCw020340;
        Tue, 7 Jan 2020 04:39:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 20:39:27 -0800
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, ssomesh@amazon.com, hch@lst.de, mst@redhat.com,
        Chaitanya.Kulkarni@wdc.com
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use disk_set_capacity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200102075315.22652-1-sblbir@amazon.com>
        <20200102075315.22652-6-sblbir@amazon.com>
        <yq1blrg2agh.fsf@oracle.com> <1578369479.3251.31.camel@linux.ibm.com>
Date:   Mon, 06 Jan 2020 23:39:25 -0500
In-Reply-To: <1578369479.3251.31.camel@linux.ibm.com> (James Bottomley's
        message of "Mon, 06 Jan 2020 19:57:59 -0800")
Message-ID: <yq1y2uj283m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=875
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=939 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070037
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


James,

>> We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
>> capacity changes. However, this event does not automatically cause
>> revalidation.
>
> Which I seem to remember was a deliberate choice: some change
> capacities occur because the path goes passive and default values get
> installed.

Yep, it's very tricky territory.

-- 
Martin K. Petersen	Oracle Linux Engineering
