Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC3C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 22:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BA22087B
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 22:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ft3W0+Nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfBTWzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:55:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42978 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTWzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 17:55:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KMrZ3u024028;
        Wed, 20 Feb 2019 22:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=XDVOiH/Hes3loBZNIbuudG/oGTZyuT5N8tNWjVjQ/sY=;
 b=Ft3W0+Nw2pbl6telQTtlxY8Xa3acygSbMbHtj75CYq0y9ysbe2+pJRsygz3gYS3q6DDm
 aTOw1Mo/Koah2xjZ3/1CMbqe3GZ0Yj6YzErOUJ6k7/V95C8luNNLnzseuxzOWNvqWFCL
 QSALzxg1vYwLWwlqK6iWwi8jrLHCMG1NUUNmi5CbCvT/Hn7iPVnh3ts96jv0zZNW9til
 sUIOAQ9E4A1IU6qtikfNareDeZFq/fFlBOff5cmDXP/QOwun+utgGxjOXd15oUyElXu3
 7NRRVEmJyPjMapM3l++V3nNVIB7Xx/mMYBTtiTtwJmR9KcZ22oNwNZ1+g0vErbVK0C14 /A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qp9xu4p9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 22:55:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KMt7Cb022100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 22:55:07 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KMt6vo027258;
        Wed, 20 Feb 2019 22:55:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 14:55:06 -0800
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme\@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190220031122.GA17298@ming.t460p>
        <20190220141701.GA26537@lst.de>
        <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
Date:   Wed, 20 Feb 2019 17:55:04 -0500
In-Reply-To: <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
        (Chaitanya Kulkarni's message of "Wed, 20 Feb 2019 18:16:27 +0000")
Message-ID: <yq1tvgyhxyv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=656 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200154
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Chaitanya,

> -	if (!blk_rq_payload_bytes(rq))
> +	if (!blk_rq_nr_phys_segments(rq))

Wouldn't it be better to set RQF_SPECIAL_PAYLOAD and friends in
nvme_setup_write_zeroes() like it's done for discard?

-- 
Martin K. Petersen	Oracle Linux Engineering
