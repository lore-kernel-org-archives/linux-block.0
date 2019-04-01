Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA0C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 14:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E62214AF
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 14:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JlrScw85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDAOFK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:05:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45782 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfDAOFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 10:05:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x31DwqYK151890;
        Mon, 1 Apr 2019 14:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ZIuTcT3YxAn2V8WHN2im9MO7KNlk3OqiwzWFHQZa2FQ=;
 b=JlrScw85yPFz7rjxJPrMGv+hy+fodIcBHJVfqehgwAqfxNpz9j0VVLeOMnwa7C4zTmuM
 ZbLJ678ENVTDv7SWA6JkgwG9CWGY/gPtVK3macfMZzHbJVI9Fa6ju9yUhPuwz7zpRcgg
 AFTl93qjsxp/ayJrKhQ8pEoBX24RoN8pcqdd7th9QoGtR+7oy5mj7WzQI5B507iXPJ9L
 3Gwy8M9tmtRHLh/kL+6f3y8FJH9lTTuo1fmMgJ67Bh/y5KWjSHimxW/kaeJN+qfKAwHm
 HyhEUyswqSnHdVJtcS8cZzJtRXDcpyI2n9Xw/2f1tjewoKh1zxE/WKYWeT/m9FxY0RB/ bg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2rhwycyc3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 14:04:49 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x31E4mdC030193
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 14:04:48 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x31E4lh8029430;
        Mon, 1 Apr 2019 14:04:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 07:04:46 -0700
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
References: <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk>
        <yq1ftr5rbq1.fsf@oracle.com>
        <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk>
        <yq1bm1trb4y.fsf@oracle.com>
        <feefa611-b744-326c-29d5-c64bcda45d9f@kernel.dk>
        <yq17echrax1.fsf@oracle.com>
        <1b638dc2-56fd-6ab4-dcca-ad2adb9931bb@kernel.dk>
        <c9adb48c-7b6e-2017-9480-aa2342b3523b@oracle.com>
        <7599b239-46f4-9799-a87a-3ca3891d4a08@kernel.dk>
        <yq1imw1p0lp.fsf@oracle.com> <20190331220001.GM23020@dastard>
Date:   Mon, 01 Apr 2019 10:04:43 -0400
In-Reply-To: <20190331220001.GM23020@dastard> (Dave Chinner's message of "Mon,
        1 Apr 2019 09:00:01 +1100")
Message-ID: <yq1ef6lq0sk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010096
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Dave!

>> However, that suffers from another headache in that the I/O can get
>> arbitrarily sliced and diced in units of 512 bytes.
>
> Right, but we don't need support that insane case. Indeed, if
> it wasn't already obvious, we _can't support it_ because the
> filesystem verifiers can't do partial verification. i.e.  part of
> the verification is CRC validation of the whole bio, not to mention
> that filesystem structure fragments cannot be safely parsed,
> interpretted and/or verified without the whole structure first being
> read in.

What I thought. There are some things I can verify by masking but it's
limited.

What about journal entries? Would they be validated with 512-byte
granularity or in bundles thereof? Only a problem during recovery, but
potentially a case where we care deeply about trying another copy if it
exists.

What I'm asking is if we should have a block size argument for the
verification? Or would you want to submit bios capped to the size you
care about and let the block layer take care of coalescing?

Validation of units bigger than the logical block size is an area which
our older Oracle HARD technology handles gracefully but which T10 PI has
been unable to address. So this is an area of particular interest to me,
although it's somewhat orthogonal to Bob's retry plumbing.

Another question for you wrt. retries: Once a copy has been identified
as bad and a good copy read from media, who does the rewrite? Does the
filesystem send a new I/O (which would overwrite all copies) or does the
retry plumbing own the responsibility of writing the good bio to the bad
location?

> IOWs, we need to look at this problem from a "whole stack" point of
> view, not just cry about how "bios are too flexible and so make this
> too hard!". The filesystem greatly constrains the alignment and
> slicing/dicing problem to the point where it should be non-existent,
> we have a clearly defined hard stop where verifier propagation
> terminates, and if all else fails we can still detect corruption at
> the filesystem level just like we do now. The worst thing that
> happens here is we give up the capability for automatic block device
> recovery and repair of damaged copies, which we can't do right now,
> so it's essentially status quo...

Having gone down the path of the one-to-many relationship when I did the
original heterogeneous I/O topology attempt, it's pure hell. Also dealt
with similar conundrums for the integrity stuff. So I don't like the
breadcrumb approach. Perfect is the enemy of good and all that.

And I am 100% in agreement on the careful alignment and not making
things complex for crazy use cases (although occasional straddling I/Os
are not as uncommon as we'd like to think). However, I do have concerns
about this particular feature when it comes to your status quo comment.

In order for us to build highly reliable systems, we have to have a
better building block than "this redundancy retry feature works most of
the time". So to me it is imperative that we provide hard guarantees
once a particular configuration has been set up and stacked. And if the
retry guarantee is somehow invalidated, then we really need to let the
user know about it.

-- 
Martin K. Petersen	Oracle Linux Engineering
