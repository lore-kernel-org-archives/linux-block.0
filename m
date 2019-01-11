Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8767EC43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 18:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA122184A
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 18:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="caJKE3jP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfAKSTs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:19:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36478 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfAKSTs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 13:19:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0BI9bqT147138;
        Fri, 11 Jan 2019 18:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=rDHptoK6ruzQkKoLu4moRY+mcxzk6gaCs+qYnTYfEEI=;
 b=caJKE3jPayo+uHEYJGTiis4V0p3Cqot0V/9dwpUIJ4ut9fSU/XPyye/e4G5QzQ50SeOk
 sAMiAnoiTzos8RYTZF85J6ny5raWktOQBn3oHEbwPUkhQYf0urEb39cKqYlYjKc30YiU
 5coO1zdcS4Uv2Ai4COaPXNT0B2e67rDjpTjUYejmG1+mw/4QCqSAv80MM/FB5Xsx2OLQ
 aZ2Sq6lHT07qmqob8TqfHmPxMQ3dlTN3ggw7uFwNweO3AQcHUlTIy+Vu+eMdGwrgOFUy
 xTgbsKV9Jgr6ZpkAyta0XqQaiM80Fht8yogmkskoDL+8Z8LKM9gkxmM8rEityVzZTebY kQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ptj3eemgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 18:19:39 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0BIJcFn029145
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 18:19:39 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0BIJcM4025113;
        Fri, 11 Jan 2019 18:19:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 10:19:38 -0800
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 05/15] Add io_uring IO interface
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190110024404.25372-1-axboe@kernel.dk>
        <20190110024404.25372-6-axboe@kernel.dk>
Date:   Fri, 11 Jan 2019 13:19:35 -0500
In-Reply-To: <20190110024404.25372-6-axboe@kernel.dk> (Jens Axboe's message of
        "Wed, 9 Jan 2019 19:43:54 -0700")
Message-ID: <yq1sgxzys3s.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=623
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901110146
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

> +struct io_uring_sqe {
> +	__u8	opcode;
> +	__u8	flags;
> +	__u16	ioprio;
> +	__s32	fd;
> +	__u64	off;
> +	union {
> +		void	*addr;
> +		__u64	__pad;
> +	};
> +	__u32	len;
> +	union {
> +		__kernel_rwf_t	rw_flags;
> +		__u32		__resv;
> +	};
> +};

A bit tongue in cheek and yet somewhat serious: While I'm super excited
about the 4 x 64 bitness of the sqe, where does the integrity buffer go?
Or the 128-bit KV store key. How do we extend this interface beyond the
flags?

-- 
Martin K. Petersen	Oracle Linux Engineering
