Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04CDC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1AF2075E
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qYnnWPgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDCDYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:24:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56874 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfDCDYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 23:24:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x332dMa2066628;
        Wed, 3 Apr 2019 02:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=m3NaFWS6AYYc4Uql+ayZ8krf2N/o689cnvlBUb7ByDI=;
 b=qYnnWPgLRya5CKt3Nwr1cmp6N/60bUC9njPIeF54PuNLWSbQdvlEFcvgE4LFjhqGY+pA
 9WKWoSYoDAJnOG3LJNb31WYmYqs2I++91b0XD5b7aNF2scJpci/6M5Ki8re+CsylaHUE
 yNoeDgcvdsR9q1iThPBx070wFKfeyCRcRu/jYh6olSw3xk+lc9dBC7fba7xmPVaxcLT3
 38gRmS44jRHy1cvn5uHf5Nk1Xll4NK6/0YuUCP2JtaesKYXjFQSF2Uy5F64wIzzgn+9T
 lk+fPazhl/Q010pyubsZGOmL1UMcd14zI7bYFTZKya9GfdJFcOvrVgDDXwznYhm/V8Ko 7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2rj0dnndxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 02:45:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x332hJkb010130;
        Wed, 3 Apr 2019 02:45:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2rm9mhsvvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 02:45:08 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x332j6vR019019;
        Wed, 3 Apr 2019 02:45:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 19:45:06 -0700
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Bob Liu <bob.liu@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shirley.ma@oracle.com,
        allison.henderson@oracle.com, darrick.wong@oracle.com,
        hch@infradead.org, adilger@dilger.ca, tytso@mit.edu
Subject: Re: [PATCH v3 2/3] block: verify data when endio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk>
        <yq1bm1trb4y.fsf@oracle.com>
        <feefa611-b744-326c-29d5-c64bcda45d9f@kernel.dk>
        <yq17echrax1.fsf@oracle.com>
        <1b638dc2-56fd-6ab4-dcca-ad2adb9931bb@kernel.dk>
        <c9adb48c-7b6e-2017-9480-aa2342b3523b@oracle.com>
        <7599b239-46f4-9799-a87a-3ca3891d4a08@kernel.dk>
        <yq1imw1p0lp.fsf@oracle.com> <20190331220001.GM23020@dastard>
        <yq1ef6lq0sk.fsf@oracle.com> <20190401212115.GQ26298@dastard>
Date:   Tue, 02 Apr 2019 22:45:03 -0400
In-Reply-To: <20190401212115.GQ26298@dastard> (Dave Chinner's message of "Tue,
        2 Apr 2019 08:21:15 +1100")
Message-ID: <yq1d0m3olhs.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030014
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030014
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Dave,

> Not sure what you mean by "capped to the size you care about". The
> verifier attached to a bio will exactly match the size of the bio
> being issued. AFAICT, coalescing with other bios in the request
> queues should not affect how the completion of that bio is
> handled by things like the RAID layers...

Just wanted to make sure that you wanted an interface that worked on a
bio containing a single logical entity. As opposed to an interface that
permitted you to submit 10 logical entities in one bio and have the
verify function iterate over them at completion time.

> As far as I'm concerned, correcting bad copies is the responisbility
> of the layer that manages the copies. It has nothing to do with the
> filesystem.

Good.

> There is so many varied storage algorithms and recovery options
> (rewrite, partial rewrite, recalc parity/erasure codes and rewrite,
> full stripe rewrite, rebuild onto hot spare due to too many errors,
> etc) it doesn't make sense to only allow repair to be done by
> completely error context-free rewriting from a higher layer. The
> layer that owns the redundancy can make much better decisions aout
> repair

I agree.

> If the storage fails (and it will) and the filesystem cannot recover
> the lost metadata, then it will let the user know and potentially
> shut down the filesystem to protect the rest of the filesystem from
> further damage. That is the current status quo, and the presence or
> absence of automatic block layer retry and repair does not change
> this at all.

No. But hopefully the retry logic will significantly reduce the cases
where shutdown and recovery is required. Availability is super
important.

Also, at least some storage technologies are trending towards becoming
less reliable, not more. So the reality is that recovering from block
errors could become, if not hot path, then at least relatively common
path.

> IOWs, the filesystem doesn't expect hard "always correct" guarantees
> from the storage layers - we always have to assume IO failures will
> occur because they do, even with T10 PI. Hence it makes no sense to
> for an automatic retry-and-recovery infrastructure for filesystems to
> require hard guarantees that the block device will always return good
> data.

I am not expecting hard guarantees wrt. always delivering good data. But
I want predictable behavior of the retry infrastructure.

That's no different from RAID drive failures. Things keep running, I/Os
don't fail until we run out of good copies. But we notify the user that
redundancy is lost so they can decide how to deal with the situation.
Setting the expectation that an I/O failure on the remaining drive would
potentially lead to a filesystem or database shutdown. RAID1 isn't
branded as "we sometimes mirror your data". Substantial effort has gone
into making sure that the mirrors are in sync.

For the retry stuff we should have a similar expectation. It doesn't
have to be fancy. I'm perfectly happy with a check at mkfs/growfs time
that complains if the resulting configuration violates whichever
alignment and other assumptions we end up baking into this.

-- 
Martin K. Petersen	Oracle Linux Engineering
