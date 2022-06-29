Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CE4C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 08:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiF2Ii3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 04:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiF2IiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 04:38:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185C1900F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 01:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656491902; x=1688027902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ij5AL27wI8bKMh8Kf3hQV7RXQq6ecvhknayKs23l9GE=;
  b=Nzzo8HsmgT0TmD1PA4BMIITlBG2J3GLpvNieNX0SW9wM4TNZ5YOrJ4GB
   kn2f9MGFVWJR414xR+Fg8j/iO2LYH6r5sA8JFRm1dFA735lJN5TkbRRFe
   ESKv/rd7dT8oXp3z6lVHagTs/dbQ2oJtH1jHeCASZezfEGvz9hNCTz7t4
   VyX9SEi5SHNZMn7GRsGd3SV8r9SRN9wfM/gnoGfNPS0SvvV5mMFJje7WE
   ChJ7z0z+goY16uO8ZKtTrNxkFLa62/l1sLv7GDsxgWoH5SNs2xsY3WTMt
   6WMs8o7QDZfvfKLBcV/LBV8zefxolWV4+8o1/jdsBlPXruOubs43onmV4
   w==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="205097202"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 16:38:21 +0800
IronPort-SDR: DxeJbtKe0QVpgnDwwzlaXeuQ3ievMy2JG3NxZROOOYt6z5DyDKWu3PwigTHpfTD/Qh5/2s88X8
 qDtjyApp+4tiao31EnZk5fO5wZWXG5SPcEuYjIvDr+okzPvJ36BGU/DFP5+wcFQclg/P9apFek
 bBOjtxhz7srUfoq36Nh8zSvxu9viORl6MDi9yaggiaap9Lg2f5CcEKzt3b0loQPRG7JK36s/zX
 /Tz/nvnTJTMwIYHYa8czCyvMnSzpxKz/wOnmDa3V1SYsFiAnlf6yE+71x2uJdO91N3ZcolpKBF
 snHspP8aMntz73mmojIYbUAk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 00:56:00 -0700
IronPort-SDR: Zuah2bcmkwp0fF8NkoV6W1FadrVO0FQ1KF+bpqj8TJeo0Mq79bAZTQvWlwFEbMTJ8el76xz1Dd
 /kX94aEB59YL3kqHK0gW7Jk/BxyICTjnxewwhpxK3PnZtsAaq3Jc9jORP3jfwpgKl6WRSGXNEX
 Ao2ICuE3eULfKBktwkFXWaztLFeWPP0rogxpjIFmzuW87VBW93tJxmjtyCUVGkM9zjPv+5QXHp
 4MqHb1Bo+60nMenJu1NPlIlai3nIq61el2cJ87aT2uuqTnJEvInAJ0xt7d0wkCZOztJyMRcA7c
 eU0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 01:38:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXvxT2K1qz1Rwnm
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 01:38:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656491901; x=1659083902; bh=ij5AL27wI8bKMh8Kf3hQV7RXQq6ecvhknay
        Ks23l9GE=; b=ta7mzUYzxGlUUUC5rHl7LAl6B1szMziTLcVaOXhKfGFZdmXsgVD
        fb0/ldeUOqsMUtmsECQTuSkGRAWtRzXpZIuodE32lQoeVtjtFR1Ce6yzO/eWp1Kn
        SX4lsgwTsiaJVBN7nkibSz/4xQAmIkAF71s53H7kpm5I4iFWmfMlVblS9LSODw8x
        emWjz7XMEMtKdsEDddgOCXL4IOxkXwa5f1N5DxlmVXAFq2HtPZFqwNasiJ9nWJam
        BaQ/rkGUpQwIdJbHxILGiLzIxrsL+/2cxS7YNnFGwuyblIFJMQ9v6jbHsmsPDKiG
        c3NqYISlHUylOVCOTgkH5QGB4jSzt8Cfwpw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n8alQIrAZw4r for <linux-block@vger.kernel.org>;
        Wed, 29 Jun 2022 01:38:21 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXvxS3krHz1RtVk;
        Wed, 29 Jun 2022 01:38:20 -0700 (PDT)
Message-ID: <273045b5-9b95-8017-2e8c-b096f16e38e5@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 17:38:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: clean up the blk-ia-ranges.c code a bit
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220629062013.1331068-1-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629062013.1331068-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 15:20, Christoph Hellwig wrote:
> Hi Jens, hi Damien,
> 
> this is a little drive by cleanup for the ia-ranges code, including
> moving the data structure to the gendisk as it is only used for
> non-passthrough access.
> 
> I don't have hardware to test this on, so it would be good to make this
> go through Damien's rig.
> 
> Diffstat:
>  block/blk-ia-ranges.c  |   65 +++++++++++++++----------------------------------
>  block/blk-sysfs.c      |    2 -
>  block/blk.h            |    3 --
>  include/linux/blkdev.h |   12 ++++-----
>  4 files changed, 28 insertions(+), 54 deletions(-)

For the series:

Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
