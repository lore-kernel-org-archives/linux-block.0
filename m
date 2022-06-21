Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A09C43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 13:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiFUNEF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349509AbiFUNEA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 09:04:00 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC80D2314C
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655816638; x=1687352638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/6aa2iziZmv9EL7SoMoSsd/a3ONplO3u6x6Y9iTD7m8=;
  b=Tf1zRmvEHFDkGLWXhvXTRrz0cnZfLanfhJQxy88gLZOCBpAPkOpxxUtg
   JV9iXTgg44FQQOuNkpyt89Dwe+D/ZedZRy697x1mzOqqoJge9mRO6S27v
   juoyM9ULUIQIL6pD++QF5Uv4mzHbg4YXgrm1VMqAYmfhW0ALS1a81K52k
   GB3c7GeLdyTaaWuTajK4eoWmhjK+2/drCEnp2UH4W23y1G3MydJERh0Xf
   xre7rj+ttRG7//3xLgsgkGADahZaKtyn2efSOIfoxiSwC7eqW7iUzO25q
   HqqwtV6qXESw93OvtyKB+G4S5dAL7zXS9PZta82jEUzJou/SKdpLEZl83
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650902400"; 
   d="scan'208";a="315819110"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 21:03:58 +0800
IronPort-SDR: IRONr7Ow4nw77TMakHzPzhfKTJwdk6g1UR6UmvzqRhSvrXalIwy5yAG8MveFyParHQ3nNZhT6q
 APE9hSJ2mkWbLCgmjnQERjUG2pP16jQF8wRt37FUTesc1C9hSqLYNC4Deogqth0Vao3qsefNi1
 z4ynd2HS3Uo/+H4LYZc9o4SXleyIOWYz6mXk+aX/PeeLcfa2uVhUDd1DEm+rg7/wGlMQdzCZ/o
 m4GUFwbJH9a85MZjftaa5JvubozZBIIAaoYAX45p9sJnBxFpSk1P1F4pKWTVm+zES23RF/0UOn
 6MjLof+RKnUarfRiEfMiB6Y4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 05:26:28 -0700
IronPort-SDR: rY6ujkw7PzvoDfxpT15NW7HVVsGedj4pN5rQSFThQO8Tf0p9gW4dFE0yMM3oi0oFRlCn7gG4oV
 DGJvTD/2uWV3dzxKyRz+2Im76DmN3XZd4rgLlKN+7f34UTil4kJdxmtW65qtHpnEX8pZE1723A
 QQDi6ad0DqTupo5lAygVA/q702bpBa9fXVOvciAXBKdUKz5KBLxgN3XZi9Rnpou7HL/DYrxOIc
 1kiDubXzXVFFF9dJEtsgzFJzK+Z7oec9lcnmuh6aCoanxY/K8M4/95+YSrW7+proFdomB0EGCH
 Dps=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2022 06:03:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LS6Cd2CTZz1Rwnl
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 06:03:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655816636; x=1658408637; bh=/6aa2iziZmv9EL7SoMoSsd/a3ONplO3u6x6
        Y9iTD7m8=; b=rkevmnGKLy/rztrFOI08c/geUMXZsJOfTEP2Jfaa42J08c2vBpP
        fjv7IvG4tDqrhbGRm8F/53ntSrp0NhUibUGLebvAadRSAsuaE2U/dcUbQubmjFsx
        ZqLG671VmjcGjyBDgEsARPsPkNMMijZOZ1O6or6lJk5Y6tQ/1r/ynNetzJIkv6//
        XcjIlcKuF2kqj6LzrY5H85YSJHn2/ESEhOXyzBojBFjiEphqXDkxbQUkFhpeg/Hn
        bVB+zV6tK8oNoJPT89QOVjYWybXuwcQk8ZqhvhcIdaMlGP5ieooNfVpbx0qSnr5i
        50gJ+29p7UpMEvo3NiNUBzAEHyhogxvvj5A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H-Wm37UBj0yd for <linux-block@vger.kernel.org>;
        Tue, 21 Jun 2022 06:03:56 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LS6Cb6YKhz1RtVk;
        Tue, 21 Jun 2022 06:03:55 -0700 (PDT)
Message-ID: <d00ef1fa-9f6e-28f9-0b98-ad018837f924@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 22:03:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/9 v4] block: Fix IO priority mess
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220621102201.26337-1-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220621102201.26337-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 19:24, Jan Kara wrote:
> Hello,
> 
> This is the fourth revision of my patches fixing IO priority handling in the
> block layer.

Thanks for this. I reviewed and this all looks good to me.
Nevertheless, I will give this a spin tomorrow (with ATA drives that have
NCQ priority).

> 
> Changes since v3:
> * Added Reviewed-by tags from Damien
> * Fixed build failure without CONFIG_BLOCK
> * Separated refactoring of get_current_ioprio() into a separate patch
> 
> Changes since v2:
> * added some comments to better explain things
> * changed handling of ioprio_get(2)
> * a few small tweaks based on Damien's feedback
> 
> Original cover letter:
> Recently, I've been looking into 10% regression reported by our performance
> measurement infrastructure in reaim benchmark that was bisected down to
> 5a9d041ba2f6 ("block: move io_context creation into where it's needed"). This
> didn't really make much sense and it took me a while to understand this but the
> culprit is actually in even older commit e70344c05995 ("block: fix default IO
> priority handling") and 5a9d041ba2f6 just made the breakage visible.
> Essentially the problem was that after these commits some IO was queued with IO
> priority class IOPRIO_CLASS_BE while other IO was queued with IOPRIO_CLASS_NONE
> and as a result they could not be merged together resulting in performance
> regression. I think what commit e70344c05995 ("block: fix default IO priority
> handling") did is actually broken not only because of this performance
> regression but because of other reasons as well (see changelog of patch 3/8 for
> details). Besides this problem, there are multiple other inconsistencies in the
> IO priority handling throughout the block stack we have identified when
> discussing this with Damien Le Moal. So this patch set aims at fixing all these
> various issues.
> 
> Note that there are a few choices I've made I'm not 100% sold on. In particular
> the conversion of blk-ioprio from rqos is somewhat disputable since it now
> incurs a cost similar to blk-throttle in the bio submission fast path (need to
> load bio->bi_blkg->pd[ioprio_policy.plid]).  If people think the removed
> boilerplate code is not worth the cost, I can certainly go via the "additional
> rqos hook" path.
> 
> 								Honza
> Previous versions:
> Link: http://lore.kernel.org/r/20220601132347.13543-1-jack@suse.cz # v1
> Link: http://lore.kernel.org/r/20220615160437.5478-1-jack@suse.cz # v2
> Link: http://lore.kernel.org/r/20220620160726.19798-1-jack@suse.cz # v3


-- 
Damien Le Moal
Western Digital Research
