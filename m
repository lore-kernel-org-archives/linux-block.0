Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F071DC432C3
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 09:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33DA2070B
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 09:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="EPFRTqu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfK0JU1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:20:27 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:57339 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfK0JU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 04:20:27 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Nov 2019 04:20:26 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1574846426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9uuURIb8lrZNL/OMu7igvzdkxlazHa9ULxcdZfdQEJk=;
  b=EPFRTqu7qGE0PnTMBM61BMPiR89NpZMOBWQJBOI3Uk05xGnj7AVYD/oo
   kayMYYzU2Z7psgmhd5VaFrE+TxWSn5leyp9LMO3uWvHReSGlpFG9bhK5S
   hai5aVgeD3A1fwi0zz7DQbOUeJqyR2f5+Qvi9OSeSdBKjttJmXop4TOKO
   A=;
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
IronPort-SDR: 3w5d59L52Mn1fIy3qlLg2l1iAGFHhwnFM+YxEHAiihny2aU1k/iXW9X2fzLiyzswN46YEeyy82
 MLt3NJLzRsx9IenYw0lON3SkfoO7Rl4dtAjrcoReZBPDbYWosP5elBiuth7JAsxXx7N1hOogoa
 jpZQ/nVMnSfxXiMEF9T2J1hEjRrA6zjwKijqesLels9WAo+D9IGxa6G5jMou7W8ZJ2Tmm9cv6h
 zHQFdo2MGJoFlqg0Mts+7CAI6B4pOEvFe6V8OzDi2yz9tcCcDnh9TGgZadpIwwi6p2q1fap1vA
 d8o=
X-SBRS: 2.7
X-MesageID: 9306850
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,248,1571716800"; 
   d="scan'208";a="9306850"
Date:   Wed, 27 Nov 2019 10:13:14 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <konrad.wilk@oracle.com>, <axboe@kernel.dk>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] xen/blkback: Avoid unmapping unmapped grant pages
Message-ID: <20191127091314.GK980@Air-de-Roger>
References: <20191126153605.27564-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126153605.27564-1-sjpark@amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 26, 2019 at 04:36:05PM +0100, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> For each I/O request, blkback first maps the foreign pages for the
> request to its local pages.  If an allocation of a local page for the
> mapping fails, it should unmap every mapping already made for the
> request.
> 
> However, blkback's handling mechanism for the allocation failure does
> not mark the remaining foreign pages as unmapped.  Therefore, the unmap
> function merely tries to unmap every valid grant page for the request,
> including the pages not mapped due to the allocation failure.  On a
> system that fails the allocation frequently, this problem leads to
> following kernel crash.
> 
>   [  372.012538] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
>   [  372.012546] IP: [<ffffffff814071ac>] gnttab_unmap_refs.part.7+0x1c/0x40
>   [  372.012557] PGD 16f3e9067 PUD 16426e067 PMD 0
>   [  372.012562] Oops: 0002 [#1] SMP
>   [  372.012566] Modules linked in: act_police sch_ingress cls_u32
>   ...
>   [  372.012746] Call Trace:
>   [  372.012752]  [<ffffffff81407204>] gnttab_unmap_refs+0x34/0x40
>   [  372.012759]  [<ffffffffa0335ae3>] xen_blkbk_unmap+0x83/0x150 [xen_blkback]
>   ...
>   [  372.012802]  [<ffffffffa0336c50>] dispatch_rw_block_io+0x970/0x980 [xen_blkback]
>   ...
>   Decompressing Linux... Parsing ELF... done.
>   Booting the kernel.
>   [    0.000000] Initializing cgroup subsys cpuset
> 
> This commit fixes this problem by marking the grant pages of the given
> request that didn't mapped due to the allocation failure as invalid.
> 
> Fixes: c6cc142dac52 ("xen-blkback: use balloon pages for all mappings")
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: David Woodhouse <dwmw@amazon.de>
> Reviewed-by: Maximilian Heyne <mheyne@amazon.de>
> Reviewed-by: Paul Durrant <pdurrant@amazon.co.uk>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
