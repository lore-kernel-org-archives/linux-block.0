Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A47C433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FDF206FA
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593021807;
	bh=AZTKZ6KSw+bbD8axJCFHiGmvOaj3nYdk5ra1ah7MLRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jpDqvb/NaOHpLXuHRgU+IwgP1VuZV/vKxhuCqGN/05/svxcvzHnvtgcDVfuel3yO3
	 HqCrOMIETCAPgb6oFOhHyGPgyERNODt5zkXemFZb3TJRnv5pKArC1PwckrfNkuvuUN
	 cUt2N6fq8B58d/23zE8e0WsLYEgRpBQB26+L59zQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404995AbgFXSD1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404941AbgFXSD0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 14:03:26 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72EBA206EB;
        Wed, 24 Jun 2020 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593021806;
        bh=AZTKZ6KSw+bbD8axJCFHiGmvOaj3nYdk5ra1ah7MLRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlAbWsBuT4Qp5F94aXzp7trcbqtBjsvmO5qnC7sa3dp6aFwxRFeEv1yVhFMjuKzGd
         FNKdrTgSuCV9/uiGmB/sFdzpJrDWFFkU7DRn2OxAaYM1HlUkKpQ24u+6xhC4Ua3N3v
         u1ddVcATWGHsy4DeKuHPW5dDjcsy5y3L6nAc14Ho=
Date:   Wed, 24 Jun 2020 11:03:23 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
Message-ID: <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 24, 2020 at 10:46:03AM -0700, Sagi Grimberg wrote:
> On 6/24/20 10:25 AM, Keith Busch wrote:
> > On Tue, Jun 23, 2020 at 04:17:30PM -0700, Sagi Grimberg wrote:
> > And what if it is a DNR error? For example, the controller simply
> > doesn't support this CNS value. While the controller should support it,
> > we definitely don't need it for NVM command set namespaces.
> 
> Maybe I mis-undersatnd the comment, but if you see a DNR error, it means
> that the controller replied an error and its final, so then you can have
> extra checks.

If the controller does not support the CNS value, it may return Invalid
Field with DNR set. That error currently gets propogated back to
nvme_init_ns_head(), which then abandons the namespace. Just as the code
coments say, we had been historically been clearing such errors because
we have other ways to identify the namespace, but now we're not clearing
that error.
