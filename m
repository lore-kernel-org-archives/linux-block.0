Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AB2C00A89
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FAA223AB
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604331894;
	bh=8rEKR7fOW5uabQi7uw+C2UTt4Ld+cqI5rwCfQynFMcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eu/NlTvM8XXYuYaGUQcI9kyTzeDDQHsBZwjXYdolWjgc26Ph6budWvg1o61oLGQqO
	 Fj+wYmMadXNYjDx6cOcfsI9/350QoOroKX5RF+yo/ugsbVjSPq1ZjyyEiAVquKpzum
	 aLOfCrKsNxGbxsc3ioRkhWN3GFPtYiM44k2XqMFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKBPoy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 10:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgKBPoy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Nov 2020 10:44:54 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DADE722275;
        Mon,  2 Nov 2020 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604331893;
        bh=8rEKR7fOW5uabQi7uw+C2UTt4Ld+cqI5rwCfQynFMcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpQoxJwm73vouKoP45vBD1VStPAi+CyeCPU0dL4RqxXspZoBq9V3cBuZqj5uhZn4j
         gSrfjs96iqxoj2rTtuaP6MuOVDHWJ9CeAQ5R0MQYm95fy1O0KVJNPh9TdV9I88LsoS
         CxswXKUhKWC0bWsndwHNCvWVcBmBIzPlUuRU9CwA=
Date:   Mon, 2 Nov 2020 07:44:50 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102154450.GA1970293@dhcp-10-100-145-180.wdc.com>
References: <20201102132214.22164-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102132214.22164-1-javier.gonz@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 02, 2020 at 02:22:14PM +0100, Javier González wrote:
> Changes since V1:
>    - Apply feedback from Niklas:
> 	- Use IS_ENABLED() for checking config option

Your v1 was correct. Using IS_ENBALED() attempts to use an undefined
symbol when the CONFIG is not enabled:

  drivers/nvme/host/core.c: In function ‘nvme_update_disk_info’:
  drivers/nvme/host/core.c:2056:45: error: ‘struct nvme_ns’ has no member named ‘zoned_ns_supp’
   2056 |  if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && !ns->zoned_ns_supp)
        |                                             ^~

That said, I don't mind the concept, though I recall Christoph had
concerns about the existing 0-capacity namespace used for invalid
formats, so I'd like to hear more on that if he has some spare time to
comment.
