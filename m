Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7907AC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B3B206A3
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 14:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hnHyzpcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfBUOXc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:23:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42156 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUOXc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 09:23:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LEMNFP163259;
        Thu, 21 Feb 2019 14:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ZXEYwL/cAr+pg4/ukqZGjKKrEInTL18kBsIPjQ9qZA8=;
 b=hnHyzpcK26DFaewxeIah+RDDGgJHFa8DNvuCCJ0i8jlVhwxThZednZWJZN3ozQSP62eu
 sYYKo/ErPWN3johV+wpywEW6Xfki2n0gGN7xbXEormv0X5lWvDkxREyxpsKCkVLGEwWw
 JXKiw+OdVSu+uo5nAMb6SAYJ1AZ/f0++EJF5P3TBSphk9+/oewpLedHPHLkHR85mB6m0
 DmkwAZCyWsou5IBSpn2GWMbYszE8QLh9YhDkEVBgxvB53QuPJiRlORfLfYMdSs8hkLKO
 4EruFe1l+i53c3GyK0DNUV4/rFPH0F2R/gNIWrKliqM51UNeB2ptZJNdiKxBLb43WiV9 Jw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qp81ege88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 14:23:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1LEN0J9005465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 14:23:00 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LEMwUV017637;
        Thu, 21 Feb 2019 14:22:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 06:22:58 -0800
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme\@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190220031122.GA17298@ming.t460p>
        <20190220141701.GA26537@lst.de>
        <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
        <yq1tvgyhxyv.fsf@oracle.com>
        <722BE5B7-B32B-4B2F-9AC2-E6F5AB5E12D4@wdc.com>
        <20190221133700.GA20189@lst.de>
Date:   Thu, 21 Feb 2019 09:22:52 -0500
In-Reply-To: <20190221133700.GA20189@lst.de> (Christoph Hellwig's message of
        "Thu, 21 Feb 2019 14:37:00 +0100")
Message-ID: <yq1k1hti5kz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=677 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210105
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

>> 1. We are using RQF_SPECIAL_PAYLOAD for only discard commands and not
>> for write-zeroes because it does not have any payload. Using this in
>> the code will trigger more code changes to handle in the completion
>> path.
>
> Yes.  And that is the big difference to SCSI where REQ_OP_WRITE_ZEROES
> turns into a WRITE SAME command that has a payload.  So for SCSI
> RQF_SPECIAL_PAYLOAD for REQ_OP_WRITE_ZEROES makes a lot of sense, for
> NVMe it does not.

I don't actually care about using RQF_SPECIAL, it just seemed like a
quick workaround to set it and make bv_len 0.

My concern is purely rooted in all the grief we've had throughout the
block I/O stack distinguishing between the bytes acted upon on media and
the DMA transfer length. And consequently, I don't particularly like
that blk_rq_payload_bytes() doesn't handle the NVMe WRITE ZEROES
command. That seems like something that will cause us headaches in the
future...

-- 
Martin K. Petersen	Oracle Linux Engineering
