Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67869C4320E
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 09:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51398610FE
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 09:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHSJRP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 05:17:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230269AbhHSJRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 05:17:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J9G38n086820;
        Thu, 19 Aug 2021 05:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=8IN6lSWWffCQbrpHcOX4kb02ZR8/WNpDmfk8Tn4xGZQ=;
 b=qyKusNK/92jM5VxTiGALJwSNCvzCd0YPIiOpli7rMi1HdQZBU+cYTSlEBrkH/7/pUnw8
 H/duQeSRWFid2X9VDgiGtLwCVUq8gmrxSwy5cKDKeD+K2BHn0xXoIocr3/4cz47rEFDj
 KWs6+B4UTJpdNa94/jmGQQn3nQJ2utQN202WRkL3TGY0bfruWzl1un971CBE2LrLLbeC
 YX61U8x88f4ZxgUaWso7lbtDgwT016Gj3GL3Gkw09K6PHNoeuVZXkkQkTm5nWJ2t9mb6
 3otOfYjpCe0Njxj3Aharp1HGHX8r5YyfHwYWocSdZVqd+x2t4pZvi4eIifg8LQWaD0jc DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agc2hf2sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 05:16:28 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17J9GSU7088707;
        Thu, 19 Aug 2021 05:16:28 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agc2hf1uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 05:16:28 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17J98nXU017145;
        Thu, 19 Aug 2021 09:10:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3ae5f8evc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 09:10:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17J9ALKX49086902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 09:10:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E90FAE04D;
        Thu, 19 Aug 2021 09:10:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 305B3AE045;
        Thu, 19 Aug 2021 09:10:21 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Aug 2021 09:10:21 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in wb_timer_fn
References: <00000000000072e53a05c983ab22@google.com>
        <20210816091041.3313-1-hdanton@sina.com>
        <20210816093336.GA3950@lst.de> <yt9dim01iz69.fsf@linux.ibm.com>
        <20210819090510.GA12194@lst.de>
Date:   Thu, 19 Aug 2021 11:10:20 +0200
In-Reply-To: <20210819090510.GA12194@lst.de> (Christoph Hellwig's message of
        "Thu, 19 Aug 2021 11:05:10 +0200")
Message-ID: <yt9deeapiyv7.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SBsEKb3w6CsLfsGqF7qHxccj8tF7Yty2
X-Proofpoint-GUID: mgYHgL2t8rGgpNjYINeoPOoPg9i1qTq_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_03:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=702 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190051
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Aug 19, 2021 at 11:03:42AM +0200, Sven Schnelle wrote:
>> I'm seeing a similar crash in our CI:
>
> This series:
>
> https://lore.kernel.org/linux-block/20210816131910.615153-1-hch@lst.de/T/#t
>
> should fi it.  Can you give it a spin?

Yes. I'll try to reproduce it outside of CI and test the patch set. Thanks!
