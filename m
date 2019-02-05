Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC73C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 03:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D302145D
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 03:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V6mcOV9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBEDsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:48:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49208 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBEDsQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 22:48:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x153iJDr095947;
        Tue, 5 Feb 2019 03:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=rMiJJ/+Y3WNE7JwpUp+06B0OxyPyhKNOkN8CLcoVuEA=;
 b=V6mcOV9/wiRe7OPYq3724z6m4r1NA5JyDyOXxMvU+QrGU+IBC/a/i3mM9mTjqMk+iMjt
 LZMhm2AtVF9WzPEhe//U+oUet0FrqVNFzUXKNJmuRfyf+8asdzxkRhtPxiS3srstdvH5
 KdImcYJ/26dztL4T2qHXOKrUQyqv8ubpufGwdIaF7Kvr16dlCwm2LnWPjbFcp/eKBrva
 Ef009jcDglwaeVOlPhwxzJXLcVOF8s7L1LPe5XRH3/iRxW+6ebdB7UOMjNc8ENZfXh9p
 i4G96o7W+dPbe1DfcKJfo8QGN9N0Frs0uYgQCni14d9p5fMvbqG79ekJ4FjPE8UDCKW1 HA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qd97erqvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Feb 2019 03:48:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x153m3Wq005037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Feb 2019 03:48:03 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x153m2dT004624;
        Tue, 5 Feb 2019 03:48:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Feb 2019 03:48:01 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V4
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190201075557.9249-1-hch@lst.de>
Date:   Mon, 04 Feb 2019 22:47:59 -0500
In-Reply-To: <20190201075557.9249-1-hch@lst.de> (Christoph Hellwig's message
        of "Fri, 1 Feb 2019 08:55:49 +0100")
Message-ID: <yq1wome28wg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9157 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=654 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902050027
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

> The only real user of the T10 OSD protocol, the pNFS object layout
> driver never went to the point of having shipping products, and we
> removed it 1.5 years ago.  Exofs is just a simple example without real
> life users.
>
> The code has been mostly unmaintained for years and is getting in the
> way of block / SCSI changes, and does not even work properly currently,
> so I think it's finally time to drop it.

Applied to 5.1/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
