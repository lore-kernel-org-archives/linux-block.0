Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A184C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FBE20656
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j5bohni8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfANUta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:49:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60744 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANUt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 15:49:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0EKhovE050365;
        Mon, 14 Jan 2019 20:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=M7yTvV85CXKlk2OQTXaB03OCKthpB5GDQoYEHcoraG0=;
 b=j5bohni8Q0Xa1NmHjjlYA4wRqu0Er/bDNoOVX3uECdyXSzrWLmjXZ8SySrzFbzYl2ZEX
 7ieAb1y43AjCnTS/TxBd19dF9dg7EhnoSOPB4qnN//F82cLXBXz00euHcpgfOC0o+LcH
 wfyvT9TUENpmeG5cFPhDHr7asPjm1+NR82xdqV189/uTC8d11qE9h5XkpOMGzxfxFO+u
 M6mqyPWqIeoK6BE5Mped2nTRo5aBNfvqnqmLSjYUoWG0dv+ZgGcH7GyYZzGDY3ERz/Uf
 XHDEm33HI5ll3kxNUO2UvnYE/Zw+hqxpB3nRWiIR6HYcr4HG1tc5xeKinj5zxceDfZqp Lw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pybjs0491-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 20:49:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0EKnA0d027940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 20:49:10 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0EKn9Bo026097;
        Mon, 14 Jan 2019 20:49:09 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jan 2019 12:49:09 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 6C1356A0128; Mon, 14 Jan 2019 15:49:07 -0500 (EST)
Date:   Mon, 14 Jan 2019 15:49:07 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] swiotlb: Export maximum allocation size
Message-ID: <20190114204907.GH32038@char.us.oracle.com>
References: <20190110134433.15672-1-joro@8bytes.org>
 <20190110134433.15672-2-joro@8bytes.org>
 <20190110170205.GB27546@char.us.oracle.com>
 <20190111091231.GB5825@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111091231.GB5825@8bytes.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9136 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901140160
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 11, 2019 at 10:12:31AM +0100, Joerg Roedel wrote:
> On Thu, Jan 10, 2019 at 12:02:05PM -0500, Konrad Rzeszutek Wilk wrote:
> > Why not use swiotlb_nr_tbl ? That is how drivers/gpu/drm use to figure if they
> > need to limit the size of pages.
> 
> That function just exports the overall size of the swiotlb aperture, no?
> What I need here is the maximum size for a single mapping.

Yes. The other drivers just assumed that if there is SWIOTLB they would use
the smaller size by default (as in they knew the limitation).

But I agree it would be better to have something smarter - and also convert the
DRM drivers to piggy back on this.

Or alternatively we could make SWIOTLB handle bigger sizes..
> 
> Regards,
> 
> 	Joerg
