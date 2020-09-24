Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED51C4363D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 10:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2482396E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 10:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="iNq7w93b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIXKrc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:47:32 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:2314 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgIXKrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 06:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1600944451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L8xE/00A85vyhQuQ/6lgUNXwsSSmV95Xl/TUzk3RuH8=;
  b=iNq7w93bELpIkcnJgq9SOfXSICZq2z1cER9w8Hy/xVBLq8WfBhY073Vn
   4Q/If64zQ4AKJ/RLcBZwi4dNnvs7h6k+gRAmIwK1B6+vfi2exy+z2m6LO
   f9p9R4GsYk3WVG+bP4xL/2vjvtMtI2S+ez0Xc7bnssLp7KPuJ3PiKJlg5
   A=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: opxQhHwtNFjKFi2WaTku1pymlx+LjDFtbAFzcvc/PQkiHp2uYJ0KdGnHs+Nkz+k99b4l26y18v
 2ZScdqi2Bhx77+V9dTrc6KhF+rQq4xUf4vgW+o3/31mphJBRc+MW1sNtW+Cs7MSUh6ePbrfxGE
 i854802MMt9WN30p7+1I2VLdqaEbxmZH07axiKBL7m/buMcYHQ0VKyNtF7/remPTjbdFDu433s
 5aIpn5KtbkEv0erRKGCeeMh01bjqMM6bE5OlPUdJjfTMoh/mdp2CqkljKuBK/YSISXRCbo8JRS
 buY=
X-SBRS: None
X-MesageID: 27746696
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,297,1596513600"; 
   d="scan'208";a="27746696"
Date:   Thu, 24 Sep 2020 12:47:20 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkback: add a parameter for disabling of persistent
 grants
Message-ID: <20200924104720.GO19254@Air-de-Roger>
References: <20200924101344.GN19254@Air-de-Roger>
 <20200924102714.28141-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924102714.28141-1-sjpark@amazon.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 24, 2020 at 12:27:14PM +0200, SeongJae Park wrote:
> On Thu, 24 Sep 2020 12:13:44 +0200 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> 
> > On Wed, Sep 23, 2020 at 04:09:30PM -0400, Konrad Rzeszutek Wilk wrote:
> > > On Tue, Sep 22, 2020 at 09:01:25AM +0200, SeongJae Park wrote:
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > > 
> > > > Persistent grants feature provides high scalability.  On some small
> > > > systems, however, it could incur data copy overhead[1] and thus it is
> > > > required to be disabled.  But, there is no option to disable it.  For
> > > > the reason, this commit adds a module parameter for disabling of the
> > > > feature.
> > > 
> > > Would it be better suited to have it per guest?
> > 
> > I think having a per-backend policy that could be specified at the
> > toolstack level would be nice, but I see that as a further
> > improvement.
> 
> Agreed.
> 
> > 
> > Having a global backend domain policy of whether persistent grants are
> > enabled or not seems desirable, and if someone wants even more fine
> > grained control this change is AFAICT not incompatible with a
> > per-backend option anyway.
> 
> I think we could extend this design by receiving list of exceptional domains.
> For example, if 'feature_persistent' is True and exceptions list has '123,
> 456', domains of domid 123 and 456 will not use persistent grants, and vice
> versa.

I think that would be quite fragile IMO, I wouldn't recommend relying
on domain IDs.

What I would do instead is add a new attribute to
xl-disk-configuration [0] that allows setting the persistent grants
usage on a per-disk basis, and that should be passed to blkback in a
xenstore node.

> I could implement this, but... to be honest, I don't really understand the
> needs of the fine-grained control.  AFAIU, the problem is 'scalability' vs
> 'data copy overhead'.  So, only small systems would want to turn persistent
> grants off.  In such a small system, why would we need fine-grained control?
> I'm worrying if I would implement and maintain a feature without real use case.
> 
> For the reason, I'd like to suggest to keep this as is for now and expand it
> with the 'exceptions list' idea or something better, if a real use case comes
> out later.

I agree. I'm happy to take patches to implement more fine grained
control, but that shouldn't prevent us from having a global policy if
that's useful to users.

Roger.

[0] https://xenbits.xen.org/docs/unstable/man/xl-disk-configuration.5.html
