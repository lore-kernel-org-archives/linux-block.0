Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D4C33CAA
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 06:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A45221734
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 06:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JTYYbWWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgAUGOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:14:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50870 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUGOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 01:14:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L69BAe157535;
        Tue, 21 Jan 2020 06:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=/qzG8cVh/rpF6yH6YERpeOBRx7eeia2tnSf+GgPT6IE=;
 b=JTYYbWWDhenZG8I7zkVpSLKsqWXMPSyCtgd68u1DQeXaCd6J5DdPizjWY4Ecw7ppmoOP
 z0FiquchfcL94QlsAVI/PTlN6fpdgULf2puepSFD2Cokdtjs5kDg1wBAgKR6bKtmhiTz
 c7dxj66aif2jOgZksQdkeS5qUqCy9+MZhv7T6ZSYn8bci7Q0AwR8KwcJ1tfvHSIoiwSY
 XS/mwFJqrdnb0m4xVCY8sJnevAJ0SRIB9QHeEQtN39hyp5BVdLs+0XNQiJqQw4AN2/Jb
 iLEUbinOB0VBRbsTNsbl5jsy08qPimfYDBJL2Ac98TWoGmCp73jpQHfDuO2TjQr0c+YS +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xkseuawe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:14:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L699lq079053;
        Tue, 21 Jan 2020 06:14:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xnsa7y05k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:14:11 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00L6E9rS026928;
        Tue, 21 Jan 2020 06:14:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jan 2020 22:14:09 -0800
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        darrick.wong@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH block v2 2/3] block: Add support for REQ_NOZERO flag
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <157917805422.88675.6477661554332322975.stgit@localhost.localdomain>
        <157917816325.88675.16481772163916741596.stgit@localhost.localdomain>
Date:   Tue, 21 Jan 2020 01:14:05 -0500
In-Reply-To: <157917816325.88675.16481772163916741596.stgit@localhost.localdomain>
        (Kirill Tkhai's message of "Thu, 16 Jan 2020 15:36:03 +0300")
Message-ID: <yq14kwpibf6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=997
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210054
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Kirill,

> +	if (flags & BLKDEV_ZERO_NOUNMAP)
> +		req_flags |= REQ_NOUNMAP;
> +	if (flags & BLKDEV_ZERO_ALLOCATE)
> +		req_flags |= REQ_NOZERO|REQ_NOUNMAP;

I find there is some dissonance between using BLKDEV_ZERO_ALLOCATE to
describe this operation in one case and REQ_NOZERO in the other.

I understand why not zeroing is important in your case. However, I think
the allocation aspect is semantically more important. Also, in the case
of SCSI, the allocated blocks will typically appear zeroed. So from that
perspective REQ_NOZERO doesn't really make sense. I would really prefer
to use REQ_ALLOCATE to describe this operation. I agree that "do not
write every block" is important too. I just don't have a good suggestion
for how to express that as an additional qualifier to REQ_ALLOCATE_?.

Also, adding to the confusion: In the context of SCSI, ANCHOR requires
UNMAP. So my head hurts a bit when I read REQ_NOZERO|REQ_NOUNMAP and
have to translate that into ANCHOR|UNMAP.

Longer term, I think we should consider introducing REQ_OP_SINGLE_RANGE
or something like that as an umbrella operation that can be used to
describe zeroing, allocating, and other things that operate on a single
LBA range with no payload. Thus removing both the writiness and the
zeroness from the existing REQ_OP_WRITE_ZEROES conduit.

Naming issues aside, your patch looks fine. I'll try to rebase my SCSI
patches on top of your series to see how things fit.

-- 
Martin K. Petersen	Oracle Linux Engineering
