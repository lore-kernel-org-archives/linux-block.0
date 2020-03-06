Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A333C3F2D1
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE68208C3
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0oAMcVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCFCXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:23:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgCFCXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=/CIgYajBKknuMLW9NBcFKUQWEEw0BZ+RsGQceuTeaO4=; b=T0oAMcVnL9BF6e7VLpfRYZ0dgF
        W7oIt+siugL+6R6ANlvga4l51coRl/oWX5qPLHHB/h0K6okezYz8nZSIItroKDvrI/MhwBXCR21pK
        m36LvDdkuyx472mxgaXhA5dON+hGd5zjvhcTCJFldBf7S51/OXpPvSUzLtskb97xQ632O/mgok0fh
        q1GQvrxqD8kPuiqe/TAhdLl1/iGavjaF2MlN8qBLL435MgC/AO0n+7JeJA3398yGMire3px/vrAuW
        ivWGO/D1jtwBhiUj42dP5U2SPBN+zI4fMJfnHwaQFSbf8vyY4OowbnTGXsOkEpdkLHEQ+rgjkOECU
        q4krqvRg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jA2db-0001TR-23; Fri, 06 Mar 2020 02:22:55 +0000
Subject: Re: [PATCH v2 3/8] partitions: Introduce NVIDIA Tegra Partition Table
To:     Dmitry Osipenko <digetx@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200306021220.22097-1-digetx@gmail.com>
 <20200306021220.22097-4-digetx@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <14ebbc7f-91f3-16dd-b998-ddd71385c772@infradead.org>
Date:   Thu, 5 Mar 2020 18:22:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306021220.22097-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/20 6:12 PM, Dmitry Osipenko wrote:
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
>  block/partitions/Kconfig      |   9 +
>  block/partitions/Makefile     |   1 +
>  block/partitions/check.c      |   4 +
>  block/partitions/tegra.c      | 510 ++++++++++++++++++++++++++++++++++
>  block/partitions/tegra.h      |  83 ++++++
>  include/soc/tegra/bootdata.h  |  46 +++
>  include/soc/tegra/common.h    |   9 +
>  include/soc/tegra/partition.h |  18 ++
>  9 files changed, 734 insertions(+)
>  create mode 100644 block/partitions/tegra.c
>  create mode 100644 block/partitions/tegra.h
>  create mode 100644 include/soc/tegra/bootdata.h
>  create mode 100644 include/soc/tegra/partition.h

Hi Dmitry,


> diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
> index 702689a628f0..d3c5c6ad6d58 100644
> --- a/block/partitions/Kconfig
> +++ b/block/partitions/Kconfig
> @@ -268,3 +268,12 @@ config CMDLINE_PARTITION
>  	help
>  	  Say Y here if you want to read the partition table from bootargs.
>  	  The format for the command line is just like mtdparts.
> +
> +config TEGRA_PARTITION
> +	bool "NVIDIA Tegra Partition support" if PARTITION_ADVANCED
> +	default y if ARCH_TEGRA
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	select MMC_BLOCK

You shouldn't select MMC_BLOCK unless MMC is already enabled,
so this entire config should depend on MMC also.
As is, without MMC set/enabled, it should give you a kconfig warning.

(no, you should not also select MMC here.)

(This is just based on reading the patch--I haven't tested it
with CONFIG_MMC not set/enabled.  Have you?)


> +	help
> +	  Say Y here if you would like to be able to read the hard disk
> +	  partition table format used by NVIDIA Tegra machines.

Thanks.
-- 
~Randy

