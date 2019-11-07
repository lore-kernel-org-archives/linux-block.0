Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA673C5DF61
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850EA2178F
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 13:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfKGN1n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:27:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730958AbfKGN1n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Nov 2019 08:27:43 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7DOhph130544
        for <linux-block@vger.kernel.org>; Thu, 7 Nov 2019 08:27:42 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w4kkd1uw7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 08:27:42 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 7 Nov 2019 13:27:38 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 13:27:35 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7DRYd027066500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 13:27:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA3B65204E;
        Thu,  7 Nov 2019 13:27:34 +0000 (GMT)
Received: from [9.152.212.95] (unknown [9.152.212.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8694352050;
        Thu,  7 Nov 2019 13:27:34 +0000 (GMT)
Subject: Re: [PATCH 5/5] block: remove (__)blkdev_reread_part as an exported
 API
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-6-hch@lst.de>
From:   Stefan Haberland <sth@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sth@linux.ibm.com; keydata=
 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
 cH4TNHyhiR0KAbxE8qKx3Jc=
Date:   Thu, 7 Nov 2019 14:27:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106151439.30056-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110713-0020-0000-0000-000003836BD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110713-0021-0000-0000-000021D9A026
Message-Id: <64b9c358-1815-520b-04ed-3844e2c53c36@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=826 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070135
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06.11.19 16:14, Christoph Hellwig wrote:
> In general drivers should never mess with partition tables directly.
> Unfortunately s390 and loop do for somewhat historic reasons, but they
> can use bdev_disk_changed directly instead when we export it as they
> satisfy the sanity checks we have in __blkdev_reread_part.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hi,

tested (the whole patchset) with DASD on s390 and for the DASD part:

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>

