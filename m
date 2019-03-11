Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5825C4360F
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773582087C
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="doma9Lvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfCKUFg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:05:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35396 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfCKT6A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BJs2kc070360;
        Mon, 11 Mar 2019 19:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8CeGFCYZlZs/sRrzjFPm1o6SowsctiMsBITTA09w1QI=;
 b=doma9LvliSaoFoVtqG7eEjx6PXbHhVk4Fjz5Y7dGg/ybL+OVttW69fimpIoOTG97hQ62
 1iRli3jv/1Q4FuCZmmu2bCmOZcQX4x3f8mjzBobif528PEZtDeUWOsLj7BhZYdu9hBtn
 o93aLJNbKsPbybl8dTfQkhxAAuvxkxfT5ZbN+TlVsJL6wgHiCFs8q6vZIRHNsqv31Dhy
 R+tNuvEbs4YrLP4sORQHxzLOHLlu5nmQkTw6kp1IGNZv1NcZsZoI64YJePFFvRtw5v4c
 hY3yyN1kUzmW01EAlCF+bD932UZk9SdOj7f+xBqyXYnloMebqCR9OsRlwiXjP4HLZ4IJ eA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2r464r8khj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 19:57:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2BJvISJ004559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 19:57:18 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2BJvHG8028745;
        Mon, 11 Mar 2019 19:57:17 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 12:57:17 -0700
Date:   Mon, 11 Mar 2019 15:57:00 -0400
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] block: pass page to xen_biovec_phys_mergeable
Message-ID: <20190311195700.GA17160@dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com>
References: <20190309013737.27741-1-ming.lei@redhat.com>
 <20190309013737.27741-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309013737.27741-2-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110138
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 09, 2019 at 09:37:32AM +0800, Ming Lei wrote:
> xen_biovec_phys_mergeable() only needs .bv_page of the 2nd bio bvec
> for checking if the two bvecs can be merged, so pass page to
> xen_biovec_phys_mergeable() directly.
> 
> No function change.
> 
> Cc: ris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
             ^^
