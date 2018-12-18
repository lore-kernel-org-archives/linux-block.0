Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51331C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 09:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28940214C6
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 09:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLRJsE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:48:04 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:42576 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLRJsE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 04:48:04 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539648000"; 
   d="scan'208";a="83480673"
Date:   Tue, 18 Dec 2018 10:47:54 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <paul.durrant@citrix.com>, <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v2 1/1] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
Message-ID: <20181218094754.dcja5rr7qlprscmp@mac>
References: <1545094538-31426-1-git-send-email-dongli.zhang@oracle.com>
 <20181218093300.qfslnloxooqnu2im@mac>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218093300.qfslnloxooqnu2im@mac>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 10:33:00AM +0100, Roger Pau Monné wrote:
> On Tue, Dec 18, 2018 at 08:55:38AM +0800, Dongli Zhang wrote:
> > +	for (i = 0; i < nr_grefs; i++) {
> > +		char ring_ref_name[RINGREF_NAME_LEN];
> > +
> > +		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
> > +		err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
> > +				   "%u", &ring_ref[i]);
> > +
> > +		if (err != 1 && (i || (!i && nr_grefs > 1))) {
> 
> AFAICT the above condition can be simplified as "err != 1 &&
> nr_grefs".

Sorry, this should be "err != 1 && nr_grefs > 1", since it's not order
but rather the number of grefs.

Roger.
