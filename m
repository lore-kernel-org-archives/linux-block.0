Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D69C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB1720675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fJxhTiZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405803AbfAPQdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:33:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405717AbfAPQdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 11:33:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0GGTGLe165658;
        Wed, 16 Jan 2019 16:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=e5clcxMbHPA2lXWClRHnU06+keMu9ROnT0xU62I9Jcg=;
 b=fJxhTiZjKS4yEoP26TvSGDrABJf5fnLpKWh+5Qt2MOEwEQv/NUmPKIapfyZUYgT1ebvS
 o5x5iCS7oJnALgQyAq1RFe5cN54P35vzvUgWQgO3rsruw2MPAXVuTYFM2r20AwRjWRCe
 PE9D3A8PZA7Uqh6oP7PyBHePQHz8yvxQkq+dQflBaaFvRv7DWCRbKFpgvP3M+dcC7kOf
 kSnLGIjOLA70UAZrp2U4ecXeJGK5c4DYgOrZ6c1BXpHephutWzfGttc6P6leOGXdam/y
 vTenF+VK5BbJ566uCNuk62fdXaozV4P25PA4i0/0Nvlr+/zoegDkKH1n6KCLn2JQ8cGH /w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pybkck0be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 16:32:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0GGWSsp023473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 16:32:29 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0GGWSm2029923;
        Wed, 16 Jan 2019 16:32:28 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 08:32:28 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 24D4C6A0112; Wed, 16 Jan 2019 11:32:27 -0500 (EST)
Date:   Wed, 16 Jan 2019 11:32:27 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        roger.pau@citrix.com, paul.durrant@citrix.com
Subject: Re: [Xen-devel] [PATCH v5 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
Message-ID: <20190116163227.GC7892@char.us.oracle.com>
References: <1546935350-20957-1-git-send-email-dongli.zhang@oracle.com>
 <1546935350-20957-2-git-send-email-dongli.zhang@oracle.com>
 <5c3760a1-4f45-a67b-3b70-80fa68ee4358@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3760a1-4f45-a67b-3b70-80fa68ee4358@oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=863
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901160133
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 08, 2019 at 04:24:32PM +0800, Dongli Zhang wrote:
> oops. Please ignore this v5 patch.
> 
> I just realized Linus suggested in an old email not use BUG()/BUG_ON() in the code.
> 
> I will switch to the WARN() solution and resend again.

OK. Did I miss it?
