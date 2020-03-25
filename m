Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86379C54FCF
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E16A20772
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 17:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SsLqtwNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCYRYg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:24:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55392 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgCYRYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 13:24:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PHIUu9063725;
        Wed, 25 Mar 2020 17:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=BVLD2DnNfc3hv/pKnHW3xvm86ovl8foR84Cu3jjRluI=;
 b=SsLqtwNsiMxQfXKTjwpsTimV5kVfZurxza6rlE6nubcGWAuwfTQLsLzfoqG0Stq9ih08
 JPc3GVkauUN9Cml8EKZvjx69mZwbc+VFBo0XITYoEyIu99jyzN2TJm/F2sx57xWqNmOh
 zf792px6wXY0CY6mrHRCF2ct3trMMgap/0VufstShpXG/ZafG3BTY0QKhfGEra51fy1s
 bVcRlQFVCNRwWWIGQ8CXRaRPqg/kGM6NAgfMca09okEe2kHd280CipW0AqoOSFCv+deO
 6GesVjacIeNC6T/w8+zLlG+Fz5PlAFNc1I53QbM4qMrLiNxiF65nF5uiIX0kBdvOmngY gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3005kva3e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 17:23:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PHMVh7021581;
        Wed, 25 Mar 2020 17:23:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yxw4rvfvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 17:23:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02PHNepp026829;
        Wed, 25 Mar 2020 17:23:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 10:23:40 -0700
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, axboe@kernel.dk,
        bob.liu@oracle.com, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, song@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] block: Introduce REQ_ALLOCATE flag for REQ_OP_WRITE_ZEROES
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
        <e2b7cbab-d91f-fd7b-de6f-a671caa6f5eb@virtuozzo.com>
        <69c0b8a4-656f-98c4-eb55-2fd1184f5fc9@virtuozzo.com>
        <67d63190-c16f-cd26-6b67-641c8943dc3d@virtuozzo.com>
        <20200319102819.GA26418@infradead.org> <yq1tv2k8pjn.fsf@oracle.com>
        <20200325162656.GJ29351@magnolia>
        <20200325163223.GA27156@infradead.org>
Date:   Wed, 25 Mar 2020 13:23:33 -0400
In-Reply-To: <20200325163223.GA27156@infradead.org> (Christoph Hellwig's
        message of "Wed, 25 Mar 2020 09:32:23 -0700")
Message-ID: <yq1d090jqlm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=786 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=841 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250139
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

> I am very much against that for the following reason:
>
>  - the current REQ_OP_DISCARD is purely a hint, and implementations can
>    (and do) choose to ignore it
>
>  - REQ_OP_WRITE_ZEROES is an actual data integrity operation with
>    everything that entails

If you want to keep emphasis on the "integrity operation" instead of the
provisioning aspect, would you expect REQ_ALLOCATE (which may or may not
zero blocks) to be considered a deterministic operation or a
non-deterministic one? Should this depend on whether the device
guarantees zeroing when provisioning blocks or not?

-- 
Martin K. Petersen	Oracle Linux Engineering
