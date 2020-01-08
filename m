Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1065C33CA1
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16D620705
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgAHPEb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:04:31 -0500
Received: from verein.lst.de ([213.95.11.211]:49685 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgAHPEb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jan 2020 10:04:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4526468BFE; Wed,  8 Jan 2020 16:04:28 +0100 (CET)
Date:   Wed, 8 Jan 2020 16:04:28 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Singh, Balbir" <sblbir@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Message-ID: <20200108150428.GB10975@lst.de>
References: <20200102075315.22652-1-sblbir@amazon.com> <20200102075315.22652-2-sblbir@amazon.com> <yq1ftgs2b6g.fsf@oracle.com> <d1635bae908b59fb4fd7de7c90ffbd5b73de7542.camel@amazon.com> <yq17e221vvt.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17e221vvt.fsf@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 10:15:34PM -0500, Martin K. Petersen wrote:
> 
> Balbir,
> 
> > I did this to avoid having to enforce that set_capacity() implied a
> > notification. Largely to control the impact of the change by default.
> 
> What I thought. I'm OK with set_capacity_and_notify(), btw.

To some extent it might make sense to always notify from set_capacity
and have a set_capacity_nonotify if we don't want to notify, as in
general we probably should notify unless we have a good reason not to.
