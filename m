Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F43C43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 01:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73B62077B
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 01:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e4tE4dHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfD0BZY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:25:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44690 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfD0BZY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 21:25:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3R1KO0n194095;
        Sat, 27 Apr 2019 01:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=DSdW+nLIZrvTORFBiT1vYJwiUM5c8ic+QdC9FYAW/y0=;
 b=e4tE4dHzm0sx0pePs/h+tP5zxp7H9sE25m5aI76U6WhaPK28EYtcXNyaEfpjkkfeDTil
 R1tyHrptX0Y0UVEC5ZVH+eJ6Bd5RwDheH6ZNpv6Ejwxy3pcVeBZYsHrRYDFfHFjBR5Wl
 Wf9FlHuoRuz5sej/kzBNhIsIiiCXDgiGP8MhVYuFe7YDZxyp7U5FJNpsqbt9/cLrgr9A
 N2iYmNaXegi2BQA3K9gVwZVGyDvyMXeZI08q5Rs/AnIVFKyUZCE3pXLKK5CTiWT7OYEx
 VrXh9n7BliWncNqdg4xLHYAX0AONELYVMBTi102FOsbGX6oXLKB8+s15lue/h6JrMg45 8A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s4ckd0322-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Apr 2019 01:25:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3R1NTN1119640;
        Sat, 27 Apr 2019 01:25:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2s4c6qrntv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Apr 2019 01:25:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3R1OnBN008423;
        Sat, 27 Apr 2019 01:24:49 GMT
Received: from localhost (/10.159.149.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Apr 2019 18:24:48 -0700
Date:   Fri, 26 Apr 2019 18:24:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block/028: check if T10 verification fails
Message-ID: <20190427012449.GC178347@magnolia>
References: <20190426023937.19584-1-ming.lei@redhat.com>
 <20190426145711.GA12338@infradead.org>
 <20190426221630.GB31470@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426221630.GB31470@ming.t460p>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9239 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=952
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904270008
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9239 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=975 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904270008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 27, 2019 at 06:16:32AM +0800, Ming Lei wrote:
> On Fri, Apr 26, 2019 at 07:57:11AM -0700, Christoph Hellwig wrote:
> > On Fri, Apr 26, 2019 at 10:39:37AM +0800, Ming Lei wrote:
> > > When T10 verification fails, the error code of BLK_STS_PROTECTION
> > > may not be propagated to user space, see mpage_end_io().
> > 
> > Well, we should probably fix that instead of papering over it..
> 
> That might be a big change, and not sure when they can be fixed
> completely.
> 
> This patch at least can expose the issue to user first.

I don't see a patch anywhere ... ?

--D

> Anyway, CC filesystem guys.
> 
> Thanks, 
> Ming
