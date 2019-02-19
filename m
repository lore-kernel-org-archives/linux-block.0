Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E7FC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294E021736
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3DAo/zAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfBSXLC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:11:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42128 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBSXLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 18:11:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1JN8vkT043845;
        Tue, 19 Feb 2019 23:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=/9fAbTLttRIQ7PTF4wqM6mQdvzIpKANjbhtgQnOwjWs=;
 b=3DAo/zAzqlaF/z5Sv7vC1WkZkR1V5WGjU0ApqeTYvsApUpZjVI/yk6BYlSsfJskSSj86
 qB5soPBaeHTjk3SCxGbAbCJlT9fkdkiUpop6YEjlvIILcNLn5y1p4/Tr6UpBL/Rmwei2
 DJdJBZb13lEKvcTiT/sQIwhaP3pxjq3E68SYsLT/mgI74UteOAaUxvVINIGrKKmc8EiP
 jU1LuBsA+GC/dTmF4FCnnKbPsok1M03sq2KS1Jpuk7B2vtkofkp3tgtNk8sDI/Y5wXgN
 penUhCmgeU5kLQ4pnrDD3J0l10xYHtwustzcrIDlq13QI3QCEC2DGJwLkYxo5ZNCcZhT oA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qpb5re7py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 23:10:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1JNAhSS029585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 23:10:43 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1JNAgHY021477;
        Tue, 19 Feb 2019 23:10:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Feb 2019 15:10:42 -0800
To:     "zhangxiaoxu \(A\)" <zhangxiaoxu5@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        John Dorminy <jdorminy@redhat.com>, <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: [dm-devel] block: Fix a WRITE SAME BUG_ON
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
        <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
        <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
        <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
        <20190131103924.GA22503@infradead.org>
        <CAMeeMh-uxiee7rKutnr3jrMjzkc8=R2Y3DPPBLvLYjqSwjfi_w@mail.gmail.com>
        <20190201073527.GA14758@infradead.org>
        <CAMeeMh-wAZ8377sMrnyQZUt2HT1hB02DHSROJURLmPsaZPkeQQ@mail.gmail.com>
        <f7b05928-316c-4c73-b04b-bba38ea60b27@redhat.com>
        <20190201161803.GA21124@infradead.org>
        <d693e299-3c7d-b3cb-e8c7-a1f94bba4697@huawei.com>
        <yq1lg2jqex7.fsf@oracle.com>
        <6a00e005-656e-7b3c-6b86-1430f3e7e623@huawei.com>
        <22afb417-1bc6-d638-def7-aa3dcc9bcd31@huawei.com>
Date:   Tue, 19 Feb 2019 18:10:39 -0500
In-Reply-To: <22afb417-1bc6-d638-def7-aa3dcc9bcd31@huawei.com> (zhangxiaoxu's
        message of "Mon, 18 Feb 2019 22:10:51 +0800")
Message-ID: <yq1tvgzl6hc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=593 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902190157
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Zhang,

> ping.
>
> Anyone can help merge this patch? or any other solutions?

+	/* If the logical block size is different, forbid write same */
+	if (t->logical_block_size != b->logical_block_size &&
+	    t->max_write_same_sectors != UINT_MAX)
+		t->max_write_same_sectors = 0;
+	else
+		t->max_write_same_sectors = min(t->max_write_same_sectors,
+						b->max_write_same_sectors);
+

I am not particularly keen on this UINT_MAX magic. I would prefer to
have the stacking driver default for lbs be set to 0 so the stacking
function could avoid special-casing the first iteration. But I am not
sure whether that would break any assumptions in DM/MD wrt. the logical
block size being non-zero prior to calling the stacking function.

Mike? Any comments?

If we stick with the UINT_MAX check, the comment should at least point
out why it's there.

-- 
Martin K. Petersen	Oracle Linux Engineering
