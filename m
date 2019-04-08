Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12481C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 11:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8F220880
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 11:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZFSwn4+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfDHLhM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:37:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54912 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHLhM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 07:37:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38BT5i5126300;
        Mon, 8 Apr 2019 11:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=qq3D3diVxA3pGGNFraFuDmpOfxDU2goQ7+Y69KnRSt4=;
 b=ZFSwn4+i6TN5tsKbcoMjrUm32uO7+yYh4aQXPnr+H7hFYRkQPd7INyvzdAhjo4r/WCT2
 LR/ymO2up/qRwrousBy3Bsu8FaH9Dar+SEVcCgY0DL3iDpi/0cfD1kwfW2EKSKtxZc0R
 dumJFlakROVgeOBf4gGX1muKnKQ539FdW1c6ROqt/Tt014SW8HEGBXEtYJ3RfZL91hN9
 t8rLXpLpHdPU3DPyxm6Ooymegvm14X/0AVZ/+w94HlNS9R0yIWZ69HT0NZSTCSkLeD4P
 gZiNEXGpYe7G9oAhXN6sSI6gHvhL2dqthWcAFq2MEoHBK59P2fgfWrvUJED11J3fa321 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2rpmrpwkwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 11:36:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38BZXDE191953;
        Mon, 8 Apr 2019 11:36:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2rpytayyug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 11:36:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x38BalGM016696;
        Mon, 8 Apr 2019 11:36:48 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 04:36:47 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Read-only Mapping of Program Text using Large THP Pages
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190220171905.GJ12668@bombadil.infradead.org>
Date:   Mon, 8 Apr 2019 05:36:46 -0600
Cc:     Keith Busch <keith.busch@intel.com>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B53C9F2D-966C-4DFD-8151-0A7255ACA9AD@oracle.com>
References: <379F21DD-006F-4E33-9BD5-F81F9BA75C10@oracle.com>
 <20190220134454.GF12668@bombadil.infradead.org>
 <07B3B085-C844-4A13-96B1-3DB0F1AF26F5@oracle.com>
 <20190220144345.GG12668@bombadil.infradead.org>
 <20190220163921.GA4451@localhost.localdomain>
 <20190220171905.GJ12668@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080100
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Feb 20, 2019, at 10:19 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> Yes, on reflection, NVMe is probably an example where we'd want to =
send
> three commands (one for the critical page, one for the part before and =
one
> for the part after); it has low per-command overhead so it should be =
fine.
>=20
> Thinking about William's example of a 1GB page, with a x4 link running
> at 8Gbps, a 1GB transfer would take approximately a quarter of a =
second.
> If we do end up wanting to support 1GB pages, I think we'll want that
> low-priority queue support ... and to qualify drives which actually =
have
> the ability to handle multiple commands in parallel.

I just got my denial for LSF/MM, so I was hopeful someone who will
be attending can talk to the filesystem folks in an effort to determine =
what
the best approach may be going forward for filling a PMD sized page to =
satisfy
a page fault.

The two obvious solutions are to either read the full content of the PMD
sized page before the fault can be satisfied, or as Matthew suggested
perhaps satisfy the fault temporarily with a single PAGESIZE page and =
use a
readahead to populate the other 511 pages. The next page fault would =
then
be satisfied by replacing the PAGESIZE page already mapped with a =
mapping for
the full PMD page.=20

The latter approach seems like it could be a performance win at the sake =
of some
complexity. However, with the advent of faster storage arrays and more =
SSD, let
alone NVMe, just reading the full contents of a PMD sized page may =
ultimately be
the cleanest way to go as slow physical media becomes less of a concern =
in the
future.

Thanks in advance to anyone who wants to take this issue up.=
