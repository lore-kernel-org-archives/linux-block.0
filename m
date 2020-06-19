Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09886C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E1021527
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592590936;
	bh=sO1tNhh3e+H0Mph8Xj5gmDOr9peS5JMM3LsxxuGWdHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YyMH5TG0Rms4QvBmA5WD0PlhXYP5a5MJwXHgjgszYM4jQYQVYMwv9It8RrgLCZ2U1
	 uqmdlFk84iLCnc+sYfP2hQERhXLg8K/FboqwsuG6HEtZmMGaSi2Bz9VQhXjNskXHZH
	 jJLWf/h+vv26q2cI/9+nhyCQu0b33gK94LkgCuHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgFSSWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731031AbgFSSWQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 14:22:16 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 445772100A;
        Fri, 19 Jun 2020 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592590935;
        bh=sO1tNhh3e+H0Mph8Xj5gmDOr9peS5JMM3LsxxuGWdHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OhwZqNrXmVPcl9l3tUlzhvoTPOGuE6xy/V6Kv+l93pn4bhcykz5y8z89z2wn4XPj4
         EADVGAlGvMEMTASS2c3tU+h91Y9HN2Qh9beiUOB2owj875nPHW3GmkdaW3w6F+NZbz
         rFOfXzHRRfPlo8PfcwwlxxKIu8s3eT11TYAOpiZ4=
Date:   Fri, 19 Jun 2020 11:22:12 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200619182212.GA1284056@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
 <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 19, 2020 at 11:17:02AM -0700, Heiner Litz wrote:
> > On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
> > > Hi Matias,
> > > no, I am rather saying that the Linux kernel has a deficit or at least
> > > is not a good fit for ZNS because it cannot enforce in-order delivery.
> >
> > FYI, the nvme protocol can't even enforce in-order delivery, so calling
> > out linux for this is a moot point.
> 
> How does it work in SPDK then? I had understood that SPDK supported
> QD>1 for ZNS devices.
> I am not saying that Linux is the only problem. The fact remains that
> out of order delivery is not a good fit for an interface that requires
> sequential writes.

The nvme protocol is absoltely clear that multiple commands outstanding
simultaneosly can be executed in any order. This is further made
difficult if you're dispatching these commands across multiple queues.
If SPDK is dispatching multiple commands and expecting them to execute
in order, then they're doing it wrong.

Further, you're not even guranteed the first write in a sequence will be
successful. If you've already dispatched a subsequent write, and the
first one fails, the second one may also fail when it's not at the wrong
write pointer.
