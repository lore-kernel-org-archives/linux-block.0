Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86E4C433DB
	for <linux-block@archiver.kernel.org>; Sat, 20 Feb 2021 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6EB64E54
	for <linux-block@archiver.kernel.org>; Sat, 20 Feb 2021 19:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBTTUN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Feb 2021 14:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhBTTUI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Feb 2021 14:20:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BF2264E51;
        Sat, 20 Feb 2021 19:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613848768;
        bh=opkZV9+iiOg5i7CeRhciYmBMWsz/qz9Xmo/qIEL+++w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAzR3vLqQJN7zA0sj+1l2vnXCMVW4WzYcT/7zoi2XEkR75dxEfZxsr9ZZXs0vfoPA
         MIIgjdK8Bfi/OCFnVUkAXbnH1QuOe78GE9Zog3tA5xLd9ntizTOGRftkJ5DbbTpQLW
         omYiai3857LXH2o97xCBrMSxBqmNpxN940EtlMYI230TK91985WJW6trAwt3FkdY/L
         VqIe5cfn3Bm95NdASEstDvnzMUXt7VhCJVGdKAJfJ58WvX9DqAgAts08MiZ6GAolne
         0nuR0yF2z+6rnQQ4z7QrJaZEUfQQrwShmPsQQ1TDKXSeEoktfn9AzBO1+I/LSxew2+
         2ipaElzzXH/Mw==
Date:   Sun, 21 Feb 2021 04:19:21 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'SelvaKumar S' <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <20210220191921.GA7968@redsun51.ssa.fujisawa.hgst.com>
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <146c47907c2446d4a896830de400dd81@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146c47907c2446d4a896830de400dd81@AcuMS.aculab.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 20, 2021 at 06:01:56PM +0000, David Laight wrote:
> From: SelvaKumar S
> > Sent: 19 February 2021 12:45
> > 
> > This patchset tries to add support for TP4065a ("Simple Copy Command"),
> > v2020.05.04 ("Ratified")
> > 
> > The Specification can be found in following link.
> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> > 
> > Simple copy command is a copy offloading operation and is  used to copy
> > multiple contiguous ranges (source_ranges) of LBA's to a single destination
> > LBA within the device reducing traffic between host and device.
> 
> Sounds to me like the real reason is that the copy just ends up changing
> some indirect block pointers rather than having to actually copy the data.

I guess an implementation could do that, but I think that's missing the
point of the command. The intention is to copy the data to a new
location on the media for host managed garbage collection. 
