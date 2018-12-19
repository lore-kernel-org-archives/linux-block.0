Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD7C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 04:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5E721871
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 04:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kpIjhmih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeLSEXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:23:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57952 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLSEXu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 23:23:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBJ4K7CA026657;
        Wed, 19 Dec 2018 04:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=oDGDo93zk5BAsAjKF7gp1AKAnNmZrQs2CtDnc9jJHio=;
 b=kpIjhmihK5ZcdZwgMaToX81PmomovitwhKb0aEBDlYXWub3yev2TkWvEwlMFg3O9yk1h
 yxZUfwFHoTsignuooD1yHYcX2Mu5b1gt5bXaUVmQ0/1gZ2o+9CZh7kMJaTRD70haACVG
 YTGtJcGKfnckadyNI/fzTCT5rY4zJRuQPDM7bGTI3G/2O9DlB/HLd9es+kh1KSbAe4Xr
 9hBhiXFvcFyssl7zeHmVF9Um9oAAzMpyaQa1MBjUIUoJbXWBqzkgVGtx1LwlS3Zo7THD
 C1S6B/i86oB6aovrSAZGk8NJ/RWdU1kOli9e0wdNtAOmY7RS4BVMfksznaoHQlt5SWhS cQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pct8qxxqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 04:23:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBJ4NbtZ000629
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 04:23:38 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBJ4NaTo008454;
        Wed, 19 Dec 2018 04:23:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 20:23:36 -0800
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: remove the "clustering" flag V2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181213151710.30036-1-hch@lst.de> <20181218070826.GA1787@lst.de>
Date:   Tue, 18 Dec 2018 23:23:32 -0500
In-Reply-To: <20181218070826.GA1787@lst.de> (Christoph Hellwig's message of
        "Tue, 18 Dec 2018 08:08:26 +0100")
Message-ID: <yq136qui1q3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=581
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812190035
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

> can we get this reviewed and merge before the end of the merge window?
> That gets the clustering put of the way for the multipage-biovec work
> from Ming which we want to land in the block tree early in the next
> merge window.

I have been somewhat hesitant to apply this just before the merge
window.  However, I did go through it fairly carefully and since it's a
mostly mechanical change, I did apply it.

There were a few things I needed to tweak by hand and patch 9 forgot to
update myrs and myrb.

I left patch 10 for Jens to merge later (unless he acks it for me to
pull in).

-- 
Martin K. Petersen	Oracle Linux Engineering
