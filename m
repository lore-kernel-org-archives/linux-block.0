Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E09C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 02:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D495216FD
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 02:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+Mxzef/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfD3CvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:51:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49744 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfD3CvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 22:51:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U2iHwO091128;
        Tue, 30 Apr 2019 02:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=EtJQIydI4TPLP0rJodfKGeaDXbBiYSZ0YPs/KP7B6wE=;
 b=O+Mxzef/Mq3fzVGDLZPxBN4tKPZ+hw1xsnJJLTZBkEKlD6BgRt2SO1B5Ot4I/cj8fT6j
 pgHvUaDqCKr6Doi57X03uFaqepjL3DD/iQeFV5Z64FGUfDZpSkbAvzUACAjbYflBDRhH
 De1XwamOr4NSIpsAGBTZ3gzWtWhMyIjbU6Qy5v/NFQ94sfsZHIT/HBThu7c9lKeU5iVr
 0eU6Hd6NJrHgQ0xfgeYvr/XGwdAXpB7Y2aHKNpU+FhGaUq+ijB6po4Zh/OaT3uAHLseZ
 3OVEVgVLYfD7Bxk9CutbI4Hv9eKYbtzWpELLT5QSsNeuIzCAfS+/4XIL5U8gcHgAUmxm 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2s5j5txg6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 02:50:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U2mxaf080729;
        Tue, 30 Apr 2019 02:50:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2s5u50qu10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 02:50:41 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3U2oav9019485;
        Tue, 30 Apr 2019 02:50:39 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 19:50:36 -0700
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Edwards <gedwards@ddn.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 1/2] blkdev.h: Introduce size_to_sectors hlper function
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190430013205.1561708-1-marcos.souza.org@gmail.com>
        <20190430013205.1561708-2-marcos.souza.org@gmail.com>
Date:   Mon, 29 Apr 2019 22:50:32 -0400
In-Reply-To: <20190430013205.1561708-2-marcos.souza.org@gmail.com> (Marcos
        Paulo de Souza's message of "Mon, 29 Apr 2019 22:32:04 -0300")
Message-ID: <yq1bm0ow6iv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=578
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300017
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=610 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300017
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Marco,

> +static inline sector_t size_to_sectors(long long size)
> +{
> +	return size >> SECTOR_SHIFT;
> +}
> +

FWIW, in SCSI we have:

	logical_to_sectors()
        logical_to_bytes()
        bytes_to_logical()
        sectors_to_logical()

I'm not attached to "bytes" in any way but it would be nice to be
consistent.

-- 
Martin K. Petersen	Oracle Linux Engineering
