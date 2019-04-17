Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E9FC282DC
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518B22054F
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 08:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfDQIC2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:02:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbfDQIC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 04:02:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3H7tf2n071022
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 04:02:27 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rwy4t36wy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 04:02:27 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <stewart@linux.ibm.com>;
        Wed, 17 Apr 2019 09:02:26 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Apr 2019 09:02:21 +0100
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3H82Kue28966936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 08:02:20 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F51F6A04D;
        Wed, 17 Apr 2019 08:02:20 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52F516A054;
        Wed, 17 Apr 2019 08:02:17 +0000 (GMT)
Received: from birb.localdomain (unknown [9.81.203.39])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with SMTP;
        Wed, 17 Apr 2019 08:02:17 +0000 (GMT)
Received: by birb.localdomain (Postfix, from userid 1000)
        id B171A507BC1; Wed, 17 Apr 2019 18:02:13 +1000 (AEST)
From:   Stewart Smith <stewart@linux.ibm.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly() changes
In-Reply-To: <300563e5-ebf4-ed62-bbaf-207d3ab5d067@oracle.com>
References: <20190404170843.83517-1-bvanassche@acm.org> <87y34jwykf.fsf@linux.vnet.ibm.com> <300563e5-ebf4-ed62-bbaf-207d3ab5d067@oracle.com>
Date:   Wed, 17 Apr 2019 18:02:13 +1000
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19041708-0004-0000-0000-000014FE8309
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010942; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190270; UDB=6.00623710; IPR=6.00971068;
 MB=3.00026479; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 08:02:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041708-0005-0000-0000-00008B4A640A
Message-Id: <87zhoprrei.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170054
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

"jianchao.wang" <jianchao.w.wang@oracle.com> writes:
> On 4/9/19 1:13 PM, Stewart Smith wrote:
>> cpu 0x4a: Vector: 400 (Instruction Access) at [c000203ff398b100]
>>     pc: c0000000021fe700
>>     lr: c0000000002001d8: blk_mq_complete_request+0x34/0x138
>
> Would you please figure out what is the source code here with gdb ?
>
> From the backtrace, it seems not the same issue, because no dm-mpath
> is involved here.

It turns out it's not the same issue, we just managed to hit it at the
same time as the original issue.

It's actually a bug in the STRICT_KERNEL_RWX=y code on ppc64le with
CONFIG_HUGETLB_PAGE=n that manifests as corrupting random kernel memory
and we just happen to hit it in this codepath and only once we brought
in "Revert v5.0 blk_mq_request_issue_directly".

More details over at https://github.com/linuxppc/issues/issues/237 and
there should be a fix for STRICT_KERNEL_RWX coming at some point.

-- 
Stewart Smith
OPAL Architect, IBM.

