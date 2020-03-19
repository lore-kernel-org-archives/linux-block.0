Return-Path: <SRS0=6FHI=5E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA22BC4332D
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 13:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3B920739
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 13:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sRM7oLvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgCSNEe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:04:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51954 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSNEe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 09:04:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JCm67j104557;
        Thu, 19 Mar 2020 13:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=eDCn48rp2SyuINnEnWSJhbWLS5pcJCnUMKz117As80E=;
 b=sRM7oLvMdOz6FXLMOfiyu2MaOGxcUX+K2BpTbblN0jUCqpqTam90e2wWTY0kIK0dvPls
 BnUHHr7Ugtjvd6v0dH3vYlDa2o6EAqGGx3curiG+tZ6Yv9c/EVX2RTFHj0ejmvEKaprQ
 EUVioEoGVNd64BJBgzYu/LI0+QEfPqfbsSKBy2BBUs0VA7KvgtKSq9FRQlXHi6yokNlG
 0NW78RY4czQVRvkz5efvlDNSLj+ZqHdPjOpiXr4jXufR54gxl0b25FuS1knIxUx8U8tY
 XCocrA1gY40a7cq9Noi7l0TfFmaaca1chfTfc4bfM3o0ohx/JT08WC7E3u9fC6LU/O31 tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yub278093-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 13:03:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JCohiE179280;
        Thu, 19 Mar 2020 13:03:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ys9040cm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 13:03:50 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02JD3kap006935;
        Thu, 19 Mar 2020 13:03:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 06:03:45 -0700
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, axboe@kernel.dk,
        martin.petersen@oracle.com, bob.liu@oracle.com,
        darrick.wong@oracle.com, agk@redhat.com, snitzer@redhat.com,
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
        <20200319102819.GA26418@infradead.org>
Date:   Thu, 19 Mar 2020 09:03:40 -0400
In-Reply-To: <20200319102819.GA26418@infradead.org> (Christoph Hellwig's
        message of "Thu, 19 Mar 2020 03:28:19 -0700")
Message-ID: <yq1tv2k8pjn.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=835 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=896 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190058
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

>> Some comments? Some requests for reworking? Some personal reasons to
>> ignore my patches?
>
> I'm still completely opposed to the magic overloading using a flag.
> That is just a bad design waiting for trouble to happen.

The observation was that Kirill's original patch set was a line-for-line
carbon copy of the write zeroes handling throughout the stack. The only
difference between the two was at the bottom. Instead of duplicating all
that code it seemed cleaner to use shared plumbing since these
operations need to be split and merged exactly the same way in the block
layer.

Also, we already have REQ_NOUNMAP, not sure why an additional handling
flag would lead to trouble? Note that I suggested renaming
REQ_OP_WRITE_ZEROES to something else to separate the semantics from the
plumbing.

We need to be able to express:

 - zero & allocate block range (REQ_OP_WRITE_ZEROES, REQ_NOUNMAP)
 - zero & deallocate block range (REQ_OP_WRITE_ZEROES, !REQ_NOUNMAP)
 - allocate block range (?, don't care about zeroing)
 - deallocate block range (REQ_OP_DISCARD, don't care about zeroing)

It just seems like a full-fledged REQ_OP_ALLOCATE is an overkill to fill
that gap.

That said, I do think that we have traditionally put emphasis on the
wrong part of these operations. All we ever talk about wrt. discard and
friends is the zeroing aspect. But I actually think that, semantically,
the act of allocating and deallocating blocks is more important. And
that zeroing is an optional second order effect of those operations. So
if we could go back in time and nuke multi-range DSM TRIM/UNMAP, I would
like to have REQ_OP_ALLOCATE/REQ_OP_DEALLOCATE with an optional REQ_ZERO
flag. I think that would be cleaner. I have a much easier time wrapping
my head around "allocate this block and zero it if you can" than "zero
this block and do not deallocate it". But maybe that's just me.

-- 
Martin K. Petersen	Oracle Linux Engineering
