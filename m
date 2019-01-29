Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A589C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 04:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197F620989
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 04:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IhteJPAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfA2Ey1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:54:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33512 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfA2Ey1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 23:54:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T4s6sV035836;
        Tue, 29 Jan 2019 04:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=1YFb7JfqyM0gtdYD8W6RYPWW81ydpyhpUkxBxlxzDec=;
 b=IhteJPAAJKbEjULxcWP8MVTVWOlmQySZGGMvqV9uPcbW1ZBNdVAHEz58yADod4CV+PN3
 mjeteGDsDNOz9B8z7SEvvG4HOs7RLyUzCahg7Sc3Ti5hnI7j39eQ0iz7KIVET90VugIO
 Ck1omabfQDLD9PayRmnwmmCQtFBict2dPLO8xLlibX2MOv3/97gksGGdc/lKcizmS+8N
 bOfUsXnHtov26IM/9E7eXExBLXagxrH9FmXA7w5VrdF4/2sjPBIYCVDuTosS2LfrptVk
 4nhGfQP2wPxCcLmW2hlTR2XTLlp05JZ0OzTa6WevpwpAwkchom8h0SjO85YLn3pg9GIN tQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2q8g6r1ywk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 04:54:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0T4sBUA024026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 04:54:11 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0T4sAOD014064;
        Tue, 29 Jan 2019 04:54:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 20:54:10 -0800
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     John Dorminy <jdorminy@redhat.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: block: Fix a WRITE SAME BUG_ON
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
        <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
        <20190128221441.GA24102@redhat.com>
Date:   Mon, 28 Jan 2019 23:54:08 -0500
In-Reply-To: <20190128221441.GA24102@redhat.com> (Mike Snitzer's message of
        "Mon, 28 Jan 2019 17:14:42 -0500")
Message-ID: <yq1lg34f4i7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=936
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290035
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Mike,

>> In the first place, if it's an LVM-only issue, we should fix it only
>> for device-mapper devices. If this is the right way to fix it,
>> possibly the way to do that would be to change DM calls to
>> blk_queue_max_write_same_sectors() to only set the max sectors to
>> more than 0 if and only if the logical block sizes match.
>
> There is no way this is specific to lvm (or DM).  It may _seem_ that way
> because lvm/dm are in the business of creating stacked devices --
> whereby exposing users to blk_stack_limits().
>
> I'll have a closer look at this issue, hopefully tomorrow, but Zhang
> Xiaoxu's proposed fix looks bogus to me.  Not disputing there is an
> issue, just feels like a different fix is needed.

It's caused by a remnant of the old bio payload hack in sd.c:

	BUG_ON(bio_offset(bio) || bio_iovec(bio).bv_len != sdp->sector_size);

We rounded up LBS when we created the DM device. And therefore the
bv_len coming down is 4K. But one of the component devices has a LBS of
512 and fails this check.

At first glance one could argue we should just nuke the BUG_ON since the
sd code no longer relies on bv_len. However, the semantics for WRITE
SAME are particularly challenging in this scenario. Say the filesystem
wants to WRITE SAME a 4K PAGE consisting of 512 bytes of zeroes,
followed by 512 bytes of ones, followed by 512 bytes of twos, etc. If a
component device only has a 512-byte LBS, we would end up writing zeroes
to the entire 4K block on that component device instead of the correct
pattern. Not good.

So disallowing WRITE SAME unless all component devices have the same LBS
is the correct fix.

That said, now that we have REQ_OP_WRITE_ZEROES (where the LBS is
irrelevant due to the payload being the ZERO_PAGE), it may be worthwhile
to remove REQ_OP_WRITE_SAME. I think drbd is the only user relying on a
non-zero payload. The target code ends up manually iterating, if I
remember correctly...

-- 
Martin K. Petersen	Oracle Linux Engineering
