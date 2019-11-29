Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0CCC432C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 15:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814DC2176D
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 15:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="HolJ9iGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK2PIG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:08:06 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:48227 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfK2PIF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 10:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575040085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ho3w6fMZjQMUAdMfY9OmFcWJIQUD8dpZ768y2Og+acw=;
  b=HolJ9iGS7WZs4rN6xLzGGsZHqvPPITgZEuxp4PE7hgdIc40SN2YpUh9/
   NTFqtA3yRl6lCF8ODeZ17a0UBBYEMsl6ZwA8+7e26N+jdkoD/8th+/hRa
   oDhPoiJmYfmBDbjgacFWCatKBDv+mjhDiwaNkporQCsKkMlSCAk1bx6Yl
   Y=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: uo7ZQ6Lhm9qvElxVUxtjDCKkJouk31rqD+rniiFpA7qeDLbFelo86ONL8Ao+T2vpe7Q5KKvu3N
 MHj2KGcYc+pYAmemTK88J6d6U4NiRU6LiCvGxnuArztHn/OZSyMyTF1YrFr2EFWNKkB2KaUZ52
 xqsDgt3eZArNqBtFUy/LH7j+kTQUevajZMOxXOrQSTm2XtIv6G74/ANKHwA3IHWHnwlYCptasq
 AjOT0aicg377FQ4uVE0v6D+5FeLxp1D+lWSyJZypSwTwpCRMouYa/Nk3wMA5KFlcFrThzFKuxE
 6Sk=
X-SBRS: 2.7
X-MesageID: 9402212
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,257,1571716800"; 
   d="scan'208";a="9402212"
Date:   Fri, 29 Nov 2019 16:07:57 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     "Durrant, Paul" <pdurrant@amazon.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Juergen Gross <jgross@suse.com>,
        <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 2/2] block/xen-blkback: allow module to be cleanly
 unloaded
Message-ID: <20191129150757.GA980@Air-de-Roger>
References: <20191129134306.2738-1-pdurrant@amazon.com>
 <20191129134306.2738-3-pdurrant@amazon.com>
 <20191129150006.GZ980@Air-de-Roger>
 <f06bf1967bdf43ca9b218f9b5c5202a6@EX13D32EUC003.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f06bf1967bdf43ca9b218f9b5c5202a6@EX13D32EUC003.ant.amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 29, 2019 at 03:02:37PM +0000, Durrant, Paul wrote:
> > -----Original Message-----
> > From: Roger Pau Monné <roger.pau@citrix.com>
> > Sent: 29 November 2019 15:00
> > To: Durrant, Paul <pdurrant@amazon.com>
> > Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; xen-
> > devel@lists.xenproject.org; Konrad Rzeszutek Wilk
> > <konrad.wilk@oracle.com>; Jens Axboe <axboe@kernel.dk>
> > Subject: Re: [PATCH v2 2/2] block/xen-blkback: allow module to be cleanly
> > unloaded
> > 
> > On Fri, Nov 29, 2019 at 01:43:06PM +0000, Paul Durrant wrote:
> > > Add a module_exit() to perform the necessary clean-up.
> > >
> > > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> > 
> > LGTM:
> > 
> > Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> > 
> 
> Thanks.
> 
> > AFAICT we should make sure this is not committed before patch 1, or
> > else you could unload a blkback module that's still in use?
> > 
> 
> Yes, that's correct.

Given this is a very small change, and not really block related I
think it would be better for both patches to be committed from the Xen
tree, if Jens, Juergen and Boris agree.

Thanks, Roger.
