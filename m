Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0333C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD4B214D8
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q/J7MT/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfCKT72 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:59:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37028 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbfCKT71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BJsgUG071520;
        Mon, 11 Mar 2019 19:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=v3T96fQw/1kGi/nUNmiuAoLk3zasgBIVrXdRRAPde1k=;
 b=q/J7MT/eBpFKIZS7kMgL9i+wnYSvQzNgVZmaEI/YO7atb9JpMwXw+Gfb5SNmSoKjsJrc
 4SssVdk/bBQ44F6QtbZA5KPPyZhrvuU/2I3Gs1SlQHHUyROEZ42MkiW+jicrIPJh6hen
 /QrTQOv3aXuscNCQcIrZbWMaZ/v0knIf5K3pRJzmG10UIUXy646jP0TkY3dP5IJ8dhkY
 g2miIQWedjVmOo3kYiDc6txhNk88aqp6+pQoiZqGTIrO784ufOntCOsU9zrp2IQTomUp
 SOXUKKwsNC/Pj/oXKbibIUSHfMY5RVvvixTUpS6ZG3yv8bMMNat9f+RTjOYAe4X9yIAh Ww== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2r464r8kun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 19:59:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2BJx81M009112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 19:59:08 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2BJx8rF029610;
        Mon, 11 Mar 2019 19:59:08 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 19:59:07 +0000
Date:   Mon, 11 Mar 2019 15:58:55 -0400
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] block: don't merge adjacent bvecs to one segment in
 bio blk_queue_split
Message-ID: <20190311195855.GB17160@dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com>
References: <20190309013737.27741-1-ming.lei@redhat.com>
 <20190309013737.27741-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309013737.27741-3-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110138
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 09, 2019 at 09:37:33AM +0800, Ming Lei wrote:
> For normal filesystem IO, each page is added via blk_add_page(),
> in which bvec(page) merge has been handled already, and basically
> not possible to merge two adjacent bvecs in one bio.
> 
> So not try to merge two adjacent bvecs in blk_queue_split(), also add
> check if one page is mergeable to current bvec in bio_add_page() for
> avoiding to break XEN.
> 
> Cc: ris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bio.c       |  2 ++
>  block/blk-merge.c | 17 -----------------
>  2 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 71a78d9fb8b7..d8f48188937c 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -776,6 +776,8 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>  
>  		if (vec_end_addr + 1 != page_addr + off)
>  			return false;
> +		if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
> +			return false;
>  		if (same_page && (vec_end_addr & PAGE_MASK) != page_addr)
>  			return false;
>  

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

