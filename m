Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E46C43331
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 20:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3CA2074D
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 20:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HlMK8G4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCXUw2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:52:28 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:42151 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgCXUw2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 16:52:28 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48n3N83mvQz9v;
        Tue, 24 Mar 2020 21:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585083145; bh=OCoxojzJM6Pabr/wFUBTBOMM8dOe6TGTqrew7ilAA98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlMK8G4ka8B/sZc9aZaXPNLBXCApFZYP5phSWJWo4Gc+H8KVYd/tiLVvmZMKxer4x
         ZHJYv7jXToB219Y5sve5yURsqGSOWobp+AH8ABz7NRQkeByhypQrkFK4bKC9WwM3q3
         K1rh3ZyQM7fb1EtLertGje8Ecv1LhVfrAeoGQ6Lar8lW0as7yn2oDrgCxrafZIszVh
         c06ZQeWIR5E1q668Z/Mz9quu2kNY+F2eZaUnPGS16A0Z+V4nAuEr5/i/AfQ0jbVjK+
         XeHHE9kYQcP50hd2H8dQahMfgEprsOIvSUJfiQPhBQHbwKOwng//ADWeQ2kahsmhVy
         GKJO98WSDpqFQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Tue, 24 Mar 2020 21:52:21 +0100
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
Message-ID: <20200324205221.GA22063@qmqm.qmqm.pl>
References: <20200323163431.7678-1-digetx@gmail.com>
 <20200323163431.7678-4-digetx@gmail.com>
 <20200323191748.GB30585@qmqm.qmqm.pl>
 <67140755-c829-5c58-3fbf-efd496e225df@gmail.com>
 <20200323213520.GA16587@qmqm.qmqm.pl>
 <c31a0335-a174-0f45-af03-3267710a8205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c31a0335-a174-0f45-af03-3267710a8205@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 24, 2020 at 02:22:34AM +0300, Dmitry Osipenko wrote:
> 24.03.2020 00:35, Michał Mirosław пишет:
> > On Mon, Mar 23, 2020 at 10:59:52PM +0300, Dmitry Osipenko wrote:
> >> 23.03.2020 22:17, Michał Mirosław пишет:
> >>> On Mon, Mar 23, 2020 at 07:34:24PM +0300, Dmitry Osipenko wrote:
> >>>> All NVIDIA Tegra devices use a special partition table format for the
> >>>> internal storage partitioning. Most of Tegra devices have GPT partition
> >>>> in addition to TegraPT, but some older Android consumer-grade devices do
> >>>> not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
> >>>> in order to support these devices properly in the upstream kernel. This
> >>>> patch adds support for NVIDIA Tegra Partition Table format that is used
> >>>> at least by all NVIDIA Tegra20 and Tegra30 devices.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  arch/arm/mach-tegra/tegra.c   |  54 ++++
> >>> [...]
> >>>
> >>> Please split off this part and make the information available to
> >>> userspace (pt_addr + pt_size) if found. This would make it easier
> >>> to support use the partition table later in initrd instead.
> >>
> >> Please clarify what do you mean by "use the partition table later in
> >> initrd instead".
> > 
> > Configure device-mapper to span eMMC boot+data partitions and then ask
> > (modified) kpartx to partition the resulting device. All before rootfs
> > is mounted and switched to in initrd.
> 
> The whole point of this series is to make partition handling generic in
> the kernel, avoiding the need to customize anything.

Yes, but at least for diagnostic purposes, it would be nice to have the
values from BCT exposed somewhere in /sys.

Best Regards,
Michał Mirosław
