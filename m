Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DFFC33CB1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 15:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135B12072E
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 15:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PsMSRXeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAQPNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:13:35 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:19426 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQPNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 10:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1579274014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tR8JPZbHUxcZYXs3lZBKPNz8XTBMiBMdbSOleTglRB8=;
  b=PsMSRXeEGo/JtnRfZ0Wr2+7+X/OBrUWLAHjSAy0lT4OGrPzVTldbCO1c
   6JsdTFBB3RUYt8ZVNZOfjaDlolFXsMF0Wlu9XjjT865qkvxqM5RfHWg2d
   EtUNhHTk8pjFhv87vliSUQ/AosmSnFQ2ueVxRG7tC56Gcj/0kXrFiXAmr
   Q=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: MsqHqo/exLDBnrLIXYxKtkRAkIRd8DjhZPa9DS0cCXIi5VRV8F/SHzhPUKSaKvvctb3jOKo46/
 Nm6wmJ0zJxkLagzwnNszZjvEsnU/lFq3kluQOaxXk6fMMUQxOwxdelpkuM21DBBOcpGjBW4dv/
 kc9WUZeUnFl0Eq41vtfo8XYJD6Kl6jTuxkCBU6XSjgsGcLrks6RH+Bie/lbsWRu3sfbcI2st6q
 dVrqNu9WhdtryEZERBHTNHTECnHKBii+dEVWkczpONl4H4/1u7OR2f1p0PPyhXCHTCMFA4qFn1
 0OY=
X-SBRS: 2.7
X-MesageID: 11445514
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,330,1574139600"; 
   d="scan'208";a="11445514"
Date:   Fri, 17 Jan 2020 16:13:24 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] xen/blkfront: limit allocated memory size to actual use
 case
Message-ID: <20200117151324.GS11756@Air-de-Roger>
References: <20200117143955.18892-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117143955.18892-1-jgross@suse.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 17, 2020 at 03:39:55PM +0100, Juergen Gross wrote:
> Today the Xen blkfront driver allocates memory for one struct
> blkfront_ring_info for each communication ring. This structure is
> statically sized for the maximum supported configuration resulting
> in a size of more than 90 kB.
> 
> As the main size contributor is one array inside the struct, the
> memory allocation can easily be limited by moving this array to be
> the last structure element and to allocate only the memory for the
> actually needed array size.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks! It would be nice to backport this, but I'm not sure it would
qualify as a bug fix.

Roger.
