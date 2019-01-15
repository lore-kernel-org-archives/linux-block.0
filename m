Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C474C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5859A20859
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAOIUn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:20:43 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:2019 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfAOIUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 03:20:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,481,1539648000"; 
   d="scan'208";a="84595790"
Date:   Tue, 15 Jan 2019 09:20:36 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <axboe@kernel.dk>,
        <Paul.Durrant@citrix.com>, <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH v6 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
Message-ID: <20190115082036.y7svi3xz3dkqd4w4@mac>
References: <1547484104-20625-1-git-send-email-dongli.zhang@oracle.com>
 <1547484104-20625-2-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547484104-20625-2-git-send-email-dongli.zhang@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 12:41:44AM +0800, Dongli Zhang wrote:
> The xenstore 'ring-page-order' is used globally for each blkback queue and
> therefore should be read from xenstore only once. However, it is obtained
> in read_per_ring_refs() which might be called multiple times during the
> initialization of each blkback queue.
> 
> If the blkfront is malicious and the 'ring-page-order' is set in different
> value by blkfront every time before blkback reads it, this may end up at
> the "WARN_ON(i != (XEN_BLKIF_REQS_PER_PAGE * blkif->nr_ring_pages));" in
> xen_blkif_disconnect() when frontend is destroyed.
> 
> This patch reworks connect_ring() to read xenstore 'ring-page-order' only
> once.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

LGTM:

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks!
