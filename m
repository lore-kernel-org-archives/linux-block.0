Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C828C3F2CD
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 19:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DB92072D
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 19:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="EUrv5Fzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCWTRy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:17:54 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:37239 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgCWTRy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 15:17:54 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48mPKW0XfjzWS;
        Mon, 23 Mar 2020 20:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584991071; bh=XQ3m3+vQyM1VoUnzBx+7RSvsto1Yo997gskRv6Y8sNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUrv5FztMtosPKGE+IXzco8ePvvAoseoWikMkCmMNukTiH8+xrbqOHtRvbyB1nWiU
         GaWXoAqpOJ/wr2QLc2P6VXOcd+YPtnl1sjbLY5Xcqi76HEkCoi/p/qVbuZw05wECy9
         yfIsM51B2DdOta7zwUsRZdOHCpdhlsvCtBUbe/0NewH0+mo+Eeqmh6St9BEGMayBmN
         KS43CYpOlgggJCu/R18F0sINmLul+wU5NUN24bVpxnvSopb4SjJ1rmrXJ8TacdQSB1
         dxQS9jXSwgbQiLHnktvCk1tJZqHBzgJStDTVCTxqG1NP3hNut8gcc8b9FgtBNRAMkz
         w2Y46EOBgTUSg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 23 Mar 2020 20:17:48 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>, linux-tegra@vger.kernel.org,
        linux-block@vger.kernel.org, Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] partitions: Introduce NVIDIA Tegra Partition
 Table
Message-ID: <20200323191748.GB30585@qmqm.qmqm.pl>
References: <20200323163431.7678-1-digetx@gmail.com>
 <20200323163431.7678-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323163431.7678-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 23, 2020 at 07:34:24PM +0300, Dmitry Osipenko wrote:
> All NVIDIA Tegra devices use a special partition table format for the
> internal storage partitioning. Most of Tegra devices have GPT partition
> in addition to TegraPT, but some older Android consumer-grade devices do
> not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
> in order to support these devices properly in the upstream kernel. This
> patch adds support for NVIDIA Tegra Partition Table format that is used
> at least by all NVIDIA Tegra20 and Tegra30 devices.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/tegra.c   |  54 ++++
[...]

Please split off this part and make the information available to
userspace (pt_addr + pt_size) if found. This would make it easier
to support use the partition table later in initrd instead.

Best Regards
Micha³ Miros³aw
