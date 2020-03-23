Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17468C54FD1
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 18:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5682072D
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 18:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="fa/awnkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgCWSH5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:07:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:4783 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCWSH4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 14:07:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48mMmn02cmzWS;
        Mon, 23 Mar 2020 19:07:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584986874; bh=OwWDAGoWwLX+Rux5D8wCOzLmonUfFV+DbmjbSKwPNpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fa/awnkcwxuhGfvOJTNp4L4IIqzMwI8izTOjMi+FcjTGDtWbxlp1hEi1tvwVBaRE0
         ExFnWDfzv0bBXgAdY0m+7hNDvsrTwN40V0EmHoDgcve2vxVoJ/OWt5BADJ5rSEHwQo
         FQa5cZFS/YRVRECcW/S710bSSNdVEhhVHYe5s0kDxl1QbRDiQ1bSP3W053lI1kfAQm
         FTKtNGE/ZyAWGymF802OCPJTBjaK055+R5HI6BrtypBq8+UkIprxscvTBKz+3Hoc5p
         QdbVuQVVUSNX93TUQebeS7aiUQsAWVYTo95mbpIX+/Tc6gK3Aj8erYPK5hT3wOcZDb
         G8WaUrpBwO2Sw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 23 Mar 2020 19:07:50 +0100
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
Subject: Re: [PATCH v3 00/10] Introduce NVIDIA Tegra Partition Table
Message-ID: <20200323180750.GA30585@qmqm.qmqm.pl>
References: <20200323163431.7678-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 23, 2020 at 07:34:21PM +0300, Dmitry Osipenko wrote:
> Some NVIDIA Tegra devices have GPT entry at a wrong location and others may
> even not have it at all. So either a custom workaround for GPT parsing or
> TegraPT support is needed for those devices if we want to support them in
> upstream kernel. The former solution was already rejected [1], let's try
> the latter.
[...]

Hi Dmitry,

This amusing use of whole-device offsets in the TegraPT makes it take
a lot of hacks to support it. Have you considered to first join the MMC
hardware partitions using DM and its linear target and only then processing
the partition table dividing just the merged device?

Best Regards,
Micha³ Miros³aw
