Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE53C10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 12:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB75E2084B
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 12:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h44Q9GKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfDYMEP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:04:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34964 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYMEP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 08:04:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3PBxF7t071723;
        Thu, 25 Apr 2019 12:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=OaQXF2xxVWVnUHUhb2JG+w385O56qSOrtvzv3Jg//pg=;
 b=h44Q9GKCE9DpIDwyNlDyxU+KU19sLHa6VO1D4lCcWzv+h3G41sUuivZ35l+LZU68EvXz
 iIhk6iGarH454XZQLpTzBVVHhKi0vOZIRR90/w5owa9zp/E0QiFlqZ9lb5ny4H8tFVmj
 ILCMQglLlBKgskiRSIcH/lwStZgpRgeUc+KbTtRmGtrUFYuCZacVVZPtfUahoBHHO8O0
 cJhN+ldTaD4I/H/QzTwvlPY2PBjqZkN/gv61Old8RqgZpHyoJVpH/ykcpfXDlgEe9P+I
 cXQxIkc25DqEjBzP1V4kzO52i+VbcMfG+l30DKqP8cYvVPTh0JvnmPm/kptb+sTiw/Y1 kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2ryrxd83hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 12:03:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3PC1MUA187819;
        Thu, 25 Apr 2019 12:03:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ryrht5vh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 12:03:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3PC3AfS025228;
        Thu, 25 Apr 2019 12:03:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Apr 2019 05:03:10 -0700
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        lsf-pc@lists.linux-foundation.org,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM TOPIC] guarantee natural alignment for kmalloc()?
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <790b68b7-3689-0ff6-08ae-936728bc6458@suse.cz>
        <20190411132819.GB22763@bombadil.infradead.org>
        <20190425113358.GI19031@bombadil.infradead.org>
Date:   Thu, 25 Apr 2019 08:03:06 -0400
In-Reply-To: <20190425113358.GI19031@bombadil.infradead.org> (Matthew Wilcox's
        message of "Thu, 25 Apr 2019 04:33:59 -0700")
Message-ID: <yq1zhoe70n9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=824
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904250077
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=846 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904250077
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Matthew,

> Do we have an lsf-discuss mailing list this year?  Might be good to
> coordinate arrivals / departures for taxi sharing purposes.

lsf@lists.linux-foundation.org

-- 
Martin K. Petersen	Oracle Linux Engineering
