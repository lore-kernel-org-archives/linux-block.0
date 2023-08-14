Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9975FC001B0
	for <linux-block@archiver.kernel.org>; Mon, 14 Aug 2023 19:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjHNT6c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Aug 2023 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjHNT6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2023 15:58:03 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 12:58:01 PDT
Received: from h2.cmg2.smtp.forpsi.com (h2.cmg2.smtp.forpsi.com [81.2.195.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD2610F
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 12:58:01 -0700 (PDT)
Received: from lenoch ([91.218.190.200])
        by cmgsmtp with ESMTPSA
        id VdgPqXSi5v5uIVdgRqjjXj; Mon, 14 Aug 2023 21:56:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1692043019; bh=hqcywpXG33t39GKBaqDEymvDYWc4Rare9gsMEyoIF60=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=L1VzsZ582id/QTEgAtw40ZdOaQ8n5Ak/TKhkDU8pWeZehllil30n6lKJoAEPTLTmu
         1S57w5iAb5vZNEZDelzYKZgjamZGza9qeyitx2pYIA0Z2C348//w1tUlysMTlAxUer
         rFe25g8PfckoAaZcBMsBGpk8TggHkxGnZD3jMDf78emDttGjLgGMzKiU7cYArWKcOM
         AFgDH91FfpEUkNNbDt0ozsCnzugZ/v7zQwn5H0vdF27DwBBXmW+6i6jdnBEB5JteTu
         TThOj09Ljdk8U2NpROjrMSV0dToF6Mt8JCoTZjLNE1w+zzAdw4xe4Qo4FTNpFUx/QL
         Y5PPrwZLWvG8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1692043019; bh=hqcywpXG33t39GKBaqDEymvDYWc4Rare9gsMEyoIF60=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=L1VzsZ582id/QTEgAtw40ZdOaQ8n5Ak/TKhkDU8pWeZehllil30n6lKJoAEPTLTmu
         1S57w5iAb5vZNEZDelzYKZgjamZGza9qeyitx2pYIA0Z2C348//w1tUlysMTlAxUer
         rFe25g8PfckoAaZcBMsBGpk8TggHkxGnZD3jMDf78emDttGjLgGMzKiU7cYArWKcOM
         AFgDH91FfpEUkNNbDt0ozsCnzugZ/v7zQwn5H0vdF27DwBBXmW+6i6jdnBEB5JteTu
         TThOj09Ljdk8U2NpROjrMSV0dToF6Mt8JCoTZjLNE1w+zzAdw4xe4Qo4FTNpFUx/QL
         Y5PPrwZLWvG8A==
Date:   Mon, 14 Aug 2023 21:56:57 +0200
From:   Ladislav Michl <oss-lists@triops.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: ratelimit warning in bio_check_ro
Message-ID: <ZNqHCUSqd9fA1Vfo@lenoch>
References: <ZIAjht591AEza3c4@lenoch>
 <20230607063002.GA21239@lst.de>
 <ZIA1nsJzEj/dAOYG@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIA1nsJzEj/dAOYG@lenoch>
X-CMAE-Envelope: MS4wfHFkm3EyHIpkTmshm26hS7Ffz7pz4hB30oeOU9rQc5R1AliWeJJxEXdfqVpil7krIM00hhDEMqTFdDGzapgxLasm0c387fbPSOQJHQGK9bdJTDxvUUGd
 uWAK6mf3Cx4aK948kreTrDCfkdmOVQU4vLyurrKQBXBnZ6EzycQ6JWcwioZ3HQZmgp8yK7MrJmbs4ek37H8CvoxLLPEpJEUsEcQ=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 07, 2023 at 09:45:35AM +0200, Ladislav Michl wrote:
> Hi Christoph,
> 
> On Wed, Jun 07, 2023 at 08:30:02AM +0200, Christoph Hellwig wrote:
> > On Wed, Jun 07, 2023 at 08:28:22AM +0200, Ladislav Michl wrote:
> > > From: Ladislav Michl <ladis@linux-mips.org>
> > > 
> > > Until 57e95e4670d1 ("block: fix and cleanup bio_check_ro")
> > > a WARN_ONCE was used to print a warning. Current pr_warn causes
> > > log flood, so use pr_warn_ratelimited instead.
> > > Once there adjust message to match the one used in bio_check_eod.
> > 
> > Do you have a case that hits this?  Beause we'd really need to fix it.
> 
> I hit that while working on customer's embedded board. There's eMMC
> where boot partitions are locked after upgrade by writing 1 into
> force_ro sysfs file. Pending writes are triggering this warnign.
> Of course update scripts was fixed meanwhile and knowing what
> process triggered warning was quite helpful. So there's nothing
> to fix, it is just improved diagnostic and returning to (almost)
> old behaviour.
> 
> > Otherwise this looks ok to me.

Any more thoughts on that? I do not push on it being mainlined, just sorting
patch stack for one of custom boards...

Thanks,
	l.
