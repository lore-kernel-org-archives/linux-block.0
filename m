Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C504EC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948B120659
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948B120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLDPDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:03:38 -0500
Received: from foss.arm.com ([217.140.101.70]:34428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbeLDPDh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 10:03:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 725BD80D;
        Tue,  4 Dec 2018 07:03:37 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41DC83F614;
        Tue,  4 Dec 2018 07:03:37 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9A9951AE0A07; Tue,  4 Dec 2018 15:03:57 +0000 (GMT)
Date:   Tue, 4 Dec 2018 15:03:57 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jackie Liu <liuyun01@kylinos.cn>, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v6 0/2] arm64: provide a NEON-accelerated XOR algorithm
 extension
Message-ID: <20181204150357.GA6308@arm.com>
References: <20181204014323.1438-1-liuyun01@kylinos.cn>
 <20181204150124.GA23762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204150124.GA23762@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 07:01:24AM -0800, Christoph Hellwig wrote:
> Why does this go to linux-block?

FWIW, I'll take this via arm64 so feel free to ignore.

Will
