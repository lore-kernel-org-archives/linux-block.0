Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8034FC04A6B
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 02:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B741216C4
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 02:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I6hSZsKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEIC3l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 May 2019 22:29:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40054 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEIC3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 May 2019 22:29:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x492TOcc014506;
        Thu, 9 May 2019 02:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=amoBd9+kKibP5f0l9xbY+4adfmr/54YpP2HUFSA6MB8=;
 b=I6hSZsKxeCGVMFNLEmKVnd36I46xQKm15sJhn+HdjLIJrPc6jO7suQFgUOz5Q0+tt+Mh
 uB/9CCp7NWF2ZhnNptlypV/6NwDCDYIrkH5Ot2VCAQumAmC1tTM9sERQ0cQFKa92yOLM
 EH+4lBqri0lFGorHephFYUS/hQOwF8vZKvMjNKjlWUdTX31iE32/Idv5cyCX26nvM+v4
 3lwABtiv66Lfus+40lS2ETh/8uStb7DkzdyxDG1EcAZhGUSDaL8LCvZvSyvTtDe6JQlg
 7luWqoj2wSIvIt3fq7cPfPm4D1ofV6O99izifLEI6zjOLJ7P7FI1Z/MiAvJ/UXIncvWp fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s94b67x43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 02:29:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x492T3Ca143813;
        Thu, 9 May 2019 02:29:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2s94bagy0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 02:29:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x492TKsQ015494;
        Thu, 9 May 2019 02:29:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 May 2019 19:29:20 -0700
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ric Wheeler <ricwheeler@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
Subject: Re: Testing devices for discard support properly
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
        <20190507220449.GP1454@dread.disaster.area>
        <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
        <20190508011407.GQ1454@dread.disaster.area>
        <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com>
        <yq1a7fwlvzb.fsf@oracle.com>
        <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com>
        <20190508215832.GR1454@dread.disaster.area>
Date:   Wed, 08 May 2019 22:29:17 -0400
In-Reply-To: <20190508215832.GR1454@dread.disaster.area> (Dave Chinner's
        message of "Thu, 9 May 2019 07:58:32 +1000")
Message-ID: <yq1lfzgicn6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=881
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090013
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=911 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090013
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Dave,

>> > WRITE SAME also has an ANCHOR flag which provides a use case we
>> > currently don't have fallocate plumbing for: Allocating blocks without
>> > caring about their contents. I.e. the blocks described by the I/O are
>> > locked down to prevent ENOSPC for future writes.
>
> So WRITE_SAME (0) with an ANCHOR flag does not return zeroes on
> subsequent reads? i.e. it is effectively
> fallocate(FALLOC_FL_NO_HIDE_STALE) preallocation semantics?

The answer is that it depends. It can return zeroes or a device-specific
initialization pattern (oh joy).

> For many use cases cases we actually want zeroed space to be
> guaranteed so we don't expose stale data from previous device use into
> the new user's visibility - can that be done with WRITE_SAME and the
> ANCHOR flag?

That's just a regular zeroout.

We have:

   Allocate and zero:	FALLOC_FL_ZERO_RANGE
   Deallocate and zero:	FALLOC_FL_PUNCH_HOLE
   Deallocate:		FALLOC_FL_PUNCH_HOLE | FALLOC_FL_NO_HIDE_STALE

but are missing:

   Allocate:		FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE

The devices that implement anchor semantics are few and far between. I
have yet to see one.

-- 
Martin K. Petersen	Oracle Linux Engineering
