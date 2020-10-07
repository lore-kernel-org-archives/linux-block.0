Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89207C4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 13:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AA820870
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 13:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgJGNyO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:54:14 -0400
Received: from verein.lst.de ([213.95.11.211]:37437 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgJGNyO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Oct 2020 09:54:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8724E6736F; Wed,  7 Oct 2020 15:54:11 +0200 (CEST)
Date:   Wed, 7 Oct 2020 15:54:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        sth@linux.ibm.com, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
Message-ID: <20201007135411.GA1000@lst.de>
References: <20201007124009.1438269-1-hch@lst.de> <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 07, 2020 at 07:53:27AM -0600, Jens Axboe wrote:
> On 10/7/20 6:40 AM, Christoph Hellwig wrote:
> > Don't error out if the dasd_biodasdinfo symbol is not available.
> 
> Should this be marked for 5.8-stable?

The Fixes tag should automatically take care of that.
