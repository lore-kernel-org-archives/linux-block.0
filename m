Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D2C2D0BF
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 11:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705E620663
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 11:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Yx7lpr0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLJL1X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:27:23 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:49366 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfLJL1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 06:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575977242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tUC4eA5Nyboawm85fT747hHsr0DL/gSfovcFMbk7+pE=;
  b=Yx7lpr0TmsveSmYLdoffvjZkQO5il2JxqvcZW22c+MAr56T+IpnxaN8t
   YMRSb+3rTZQXplzlgJE4dKOeYGSr2oipnUSLezbIxXy8H0ZCRMeWRSoUg
   3wqpQsODTEv/NeETQHXPdwuyVGNcagpOxzDfc4DthVN7GRy/DwS3iOG5q
   8=;
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
IronPort-SDR: nXOcsY0Pt+xf/qTuGVWNFNsbaqaEwdl4FNa1UmNjQiZPJPNQ+9rjkuFmNla+vXxbcWAGKepql8
 c8bHGkoYm2zn/1XwINWxljwPUkfL+VS17uRdYc+GRJJDNw5BD0TEpb1EllXJW74c2gUmL5EKqU
 MicjIW3cxXWeMEXgdy+Iytiez1hVGck06p7bWVqhxyDohPZ3eOn5aOKcAvr+04oC+A5PNj8KGX
 skek1oJ3rDyBq0Nlu6BVyQjB81FOyrztBfIM78TlTkcIAqQsjPBWV1RBPtGDl5jVWAZGTp+bHh
 qr8=
X-SBRS: 2.7
X-MesageID: 9805719
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,299,1571716800"; 
   d="scan'208";a="9805719"
Date:   Tue, 10 Dec 2019 12:27:14 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk
Message-ID: <20191210112714.GH980@Air-de-Roger>
References: <20191209201444.33243-1-natechancellor@gmail.com>
 <bf13410c-b62e-d82f-6351-ee49d7964fe7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf13410c-b62e-d82f-6351-ee49d7964fe7@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 10, 2019 at 08:15:22AM +0100, Jürgen Groß wrote:
> On 09.12.19 21:14, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > ../drivers/block/xen-blkfront.c:1117:4: warning: misleading indentation;
> > statement is not part of the previous 'if' [-Wmisleading-indentation]
> >                  nr_parts = PARTS_PER_DISK;
> >                  ^
> > ../drivers/block/xen-blkfront.c:1115:3: note: previous statement is here
> >                  if (err)
> >                  ^
> > 
> > This is because there is a space at the beginning of this line; remove
> > it so that the indentation is consistent according to the Linux kernel
> > coding style and clang no longer warns.
> > 
> > While we are here, the previous line has some trailing whitespace; clean
> > that up as well.
> > 
> > Fixes: c80a420995e7 ("xen-blkfront: handle Xen major numbers other than XENVBD")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/791
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks.
