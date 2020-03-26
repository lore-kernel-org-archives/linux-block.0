Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E70C43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680E52073E
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 14:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oOVvjG/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgCZOhh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:37:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56242 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZOhh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 10:37:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QEX7M4009867;
        Thu, 26 Mar 2020 14:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=7ms8FwymQmddGHgatxkaCEwofDmjeI0drCKbrY3vE+A=;
 b=oOVvjG/31vXbRMOzNpZ/LF+hTmcD6PEEc8JMgwIKf+ywhGB14RZdvG/5EhRCLmmJNYox
 P58kYdfDT7YLAotxz+eQ3JMyXl2oBrX1tb5i50OeGWQtYK6IFO58ALlNV13aXsApdcC9
 ta6kx8O4O0k9Fug82JJd2EvdzrkmLbzKRFD5z/6M+Uoq0u/ze2M2uDkEuCa0YnWmFY/L
 NiAIwUiFxqdOA76OtqxPjoqBvbwO5MqbmL+LUAHzklChNqmzYd6XBX6qY8/1Kc0hGd3y
 xfWMSna09dPrI/8NeeHvvKncNNvRrh01++6zorBh6r+cu8LfIe4neKQ+yqSX3oNIBQeF FQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ywavmg5am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:36:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QEWpDq129855;
        Thu, 26 Mar 2020 14:34:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2yxw4trtk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 14:34:55 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02QEYmJI025407;
        Thu, 26 Mar 2020 14:34:48 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 07:34:47 -0700
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
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
        <20200325163223.GA27156@infradead.org> <yq1d090jqlm.fsf@oracle.com>
        <20200326092935.GA6478@infradead.org>
Date:   Thu, 26 Mar 2020 10:34:42 -0400
In-Reply-To: <20200326092935.GA6478@infradead.org> (Christoph Hellwig's
        message of "Thu, 26 Mar 2020 02:29:35 -0700")
Message-ID: <yq1lfnngp6l.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=923 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=965 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260113
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

> That's why I don't like the whole flags game very much.  I'd rather
> have REQ_OP_WRITE_ZEROES as the integrity operation that gurantees
> zeroing, and a REQ_ALLOCATE that doesn't guarantee zeroing, just some
> deterministic state of the blocks.

I just worry about the proliferation of identical merging and splitting
code throughout the block stack as we add additional single-range, no
payload operations (Verify, etc.). I prefer to enforce the semantics in
the LLD and not in the plumbing. But I won't object to a separate
REQ_OP_ALLOCATE if you find the resulting code duplication acceptable.

-- 
Martin K. Petersen	Oracle Linux Engineering
