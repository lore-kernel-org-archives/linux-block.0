Return-Path: <SRS0=l7do=2G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31AEC43603
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 09:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B19206D7
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 09:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Fmv5Gjd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLPJjN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:39:13 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:37141 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLPJjM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Dec 2019 04:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576489153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QkaNQUEvNjVoj86NuEuMWLVK1Qk2Y/JAnX/tpWVYRIA=;
  b=Fmv5Gjd0QZjXXpimLdMgifS+F7UKwmk8PUm62WPt1F+uMmiPA0N4s2Ss
   M4ArcDGvRtQul91CSiXJT2mUmRB3xZUY/rolwMqXywDys99g3hQX/KIdd
   yBkXbBVNYJv1KzTcU9ZqyS+Aqjts0WhORNsI2AqrVBGqRFip8NSAhEkD7
   4=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: kJsyp14n5T01Spt0gsOV4V8Qsvd87+oiEYc9EJWVso7/QkfuIQ58/qoqiom+5+u1NdQscpkMTj
 4dYVDR3qUcLXqTiDi7O+1zjxSKY0kjkvgutIUWNFs/RQlnzbhN7y66+3IXd5oIcnSWMdxMbMR5
 A1aGIzgOWH95RYg0fw/oq2yUpZ1YWYlbToPaJBcSvFBiEwIFwn/Viw73cJWKq2KzVjSs+LDYi8
 pzVNLi3kTJLwKR08w6yNDQCfN7beojWboAq8MMkANxOORonbMXrzx5aBGWwa2gqxE7mhzolmez
 QEA=
X-SBRS: 2.7
X-MesageID: 9720752
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,321,1571716800"; 
   d="scan'208";a="9720752"
Date:   Mon, 16 Dec 2019 10:38:59 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        "SeongJae Park" <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 4/4] xen/blkback: Consistently insert one empty line
 between functions
Message-ID: <20191216093859.GK11756@Air-de-Roger>
References: <20191213153546.17425-1-sjpark@amazon.de>
 <20191213153546.17425-5-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191213153546.17425-5-sjpark@amazon.de>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 13, 2019 at 03:35:46PM +0000, SeongJae Park wrote:
> The number of empty lines between functions in the xenbus.c is
> inconsistent.  This trivial style cleanup commit fixes the file to
> consistently place only one empty line.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Thanks!

Acked-by: Roger Pau Monné <roger.pau@citrix.com>
