Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBDEC432C3
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7373B64EBB
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbhCCQic (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Mar 2021 11:38:32 -0500
Received: from verein.lst.de ([213.95.11.211]:36072 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241299AbhCCK1l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Mar 2021 05:27:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1513A68B02; Wed,  3 Mar 2021 10:10:23 +0100 (CET)
Date:   Wed, 3 Mar 2021 10:10:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        minwoo.im.dev@gmail.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210303091022.GA12784@lst.de>
References: <20210301192452.16770-1-javier.gonz@samsung.com> <20210301192452.16770-2-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301192452.16770-2-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 01, 2021 at 08:24:51PM +0100, javier@javigon.com wrote:
> From: Javier González <javier.gonz@samsung.com>
> 
> Create a char device per NVMe namespace. This char device is always
> initialized, independently of whether the features implemented by the
> device are supported by the kernel. User-space can therefore always
> issue IOCTLs to the NVMe driver using the char device.
> 
> The char device is presented as /dev/nvme-generic-XcYnZ. This naming
> scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> for multipath will follow.

So I'm a little worried about the "support for multipath will follow" as
this has implications for the naming scheme, and our policy of how we
allow access to a namespace.

Ignoring some of the deprecated historic mistakes I think the policy
should be:

 - admin commands that often are controller specific should usually
   go to a controller-specific device, the existing /dev/nvmeX
   devices
 - I/O commands and admin command that do specific a nsid should go
   through a per-namespace node that is multipath aware and not
   controller specific

Which also makes me wonder about patch 2 in the series that seems
somewhat dangerous.   Can we clearly state the policy implemented?
