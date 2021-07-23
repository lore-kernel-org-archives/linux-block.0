Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ACDC4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD8760F02
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGWRLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhGWRLy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 13:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2ED860EFD;
        Fri, 23 Jul 2021 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627062747;
        bh=KTtPF7pVEjcGtNW9vxAs2/t0droJ1W/qrMvVOnKu3bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nycrF3qC2qe2/JDBW2O+py+deOvbOPME3QFfqlLaj5xNXKlAYzOmd4R9QWeDY+HOc
         MMWSltrM5P7mgdekszfuLRrnhBerJzf5Xvly2Xsee4DAOHe12aMgW+IT6c3kfI5h6O
         Oouygla1yL64jURFy08DKSrMAIH0TpAesHy9PZjLSF4KwWhor5J7IqcxWCSJgPSmDE
         2H5vmMGBmex25Ea0Vg78/hUYHV8pOzTP01Wx+zYk+usmyiQ8yEmUzUt8gztQGnHr38
         3+0W4yZxdjR1q3UVOXYwifD87Kd6B54VyZoWvkqG7ZSPwJNXqxP2urZT1A+vCrQHc/
         rXrDCIiwMUzwQ==
Date:   Fri, 23 Jul 2021 10:52:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/9] ensure bios aren't split in middle of crypto data
 unit
Message-ID: <YPsB2vsJPobULxO0@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <YPrzMI6P7MzO3V3K@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPrzMI6P7MzO3V3K@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 23, 2021 at 09:49:52AM -0700, Eric Biggers wrote:
> On Tue, Jul 06, 2021 at 10:29:34PM -0700, Satya Tangirala wrote:
> > 
> > Changes v3 => v4
> >  - Patch 4 in v3 has been removed (Eric points out it isn't required
> >    without some of the changes in the device mapper patchset at
> >    https://lore.kernel.org/linux-block/20210604210908.2105870-1-satyat@google.com/
> >   so I'll add this patch to that series instead.
> 
> Wouldn't it make more sense to have the blk-crypto-fallback change in this
> series?  My concern was just that it didn't make sense to have it split between
> the two patch series -- it seemed like one logical change.

This series also doesn't actually remove the data_unit_size bvec alignment
requirement from block/blk-crypto.c.  Isn't that the main goal here?  So I
expected that it would be included.

Unless there are special considerations here, I'd expect that all the block
layer changes needed for the fscrypt direct I/O support would be in one patch
series that could go in together, and then the patch series with the direct I/O
support would be only filesystem layer changes.

- Eric
