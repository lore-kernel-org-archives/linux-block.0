Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E9AC54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602032075A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sf0XsuXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgDXQM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:12:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38336 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgDXQM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 12:12:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OG8l29007799;
        Fri, 24 Apr 2020 16:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=WLGvAKEz5uK5PqqHuRks70LJcb5Vcdm9fv4erfpGvjA=;
 b=sf0XsuXvmlElEREBNAsQGuhk0uK/UmurH8KGPuejurv5KN+KxxiHHE2XXU22u+Vi9KqZ
 ixU7ZHZFjNVqQ6FyOk6O8xfVg7e8WTPLDdiC28gTuu+V6OxcOaNj4fGDZRZqeNGnhdMx
 CsvKREiggAVFyBxcyqgdspf245Dy/StaxRos9t20TS4+fIciPBew4tUyOavwHEjw7SXY
 PbnvA11Ya+0Nbn55+j6P4InR7TVS5YghhNZ43/MjyLyTpQRUGMzM7lY6qw98wwirfa6U
 8ghkNXp6RIEwAET0w3oRPiiETpHbOc0fageZ0JQYU0pbqh3h9OWxFvePdxR3ivcqHiCS 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30jvq520ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 16:12:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OG80UM097904;
        Fri, 24 Apr 2020 16:12:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30k7qxebdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 16:12:29 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03OGCSfa031602;
        Fri, 24 Apr 2020 16:12:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 09:12:27 -0700
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH V8 02/11] block: add helper for copying request
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200424102351.475641-1-ming.lei@redhat.com>
        <20200424102351.475641-3-ming.lei@redhat.com>
Date:   Fri, 24 Apr 2020 12:12:25 -0400
In-Reply-To: <20200424102351.475641-3-ming.lei@redhat.com> (Ming Lei's message
        of "Fri, 24 Apr 2020 18:23:42 +0800")
Message-ID: <yq1v9loeuc6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=653
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=712 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240125
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming,

> Add one new helper of blk_rq_copy_request() to copy request, and the
> helper will be used in this patch for re-submitting request, so make
> it as a block layer internal helper.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
