Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5408C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 22:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiDMWsh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbiDMWsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 18:48:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7CC58387
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8OGnS3T0Cv+xWZes2eh2ViVEuwR0H4P4nc2ZauARo0k=; b=pX4H3RYFk5/7R/ugGB5GURiAEA
        PWyGz3rYC8WzItIwFJPkXblHn1/ZXTimZ99lpUtKUWUhRVCVKuyAaGrarueHVrAXB0jooUcpc5DNf
        aS31BWIrrzWC3pgQT6eFXN7qkm5DNVE6f1yRTkfpfdm+WmGnjvJFjQGoSQJ3gYlDWmIZM+5t+zidk
        fsyw+3y56OsX3dWRsNzvbgGPV5cLSRrExRW4p/u9xA/c/CinIzb70FNCD9od8vxzEnUWKBhN7dp+q
        nF08k6BX+Op17ABRrsyXVUNjWIcfwa9mByZt+4432LVm+H5ZoNZVQ+1wHXrHGOb9Ta/tEukvadre1
        03i0wx6g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nelkZ-002zsN-Q2; Wed, 13 Apr 2022 22:46:11 +0000
Date:   Wed, 13 Apr 2022 15:46:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     dwagner@suse.de, osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Message-ID: <YldSs+GkkYTZCvP4@bombadil.infradead.org>
References: <20211116172926.587062-1-mcgrof@kernel.org>
 <caa2ba82-b3e8-6d5a-d411-241eb147f697@acm.org>
 <YgLe2GXJW2vqFZc5@bombadil.infradead.org>
 <d32088fb-2423-b7c7-9184-ebb184ec95e8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32088fb-2423-b7c7-9184-ebb184ec95e8@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 08, 2022 at 02:26:38PM -0800, Bart Van Assche wrote:
> On 2/8/22 13:21, Luis Chamberlain wrote:
> > And the return value shoudl be $? not $1. I couldn't test srp so wanted
> > someone who would to help review, but sure, I should have caught this.
> 
> Hmm ... the SRP tests can be run inside a virtual machine so it is not clear
> to me what prevents to run these tests?

OK I've managed to get time to run SRP tests on a virtual environement
but I'm a bit surprised as to the failures found. I need this baseline
to ensure the change does not regress anything. I'll report the failures
next..

  Luis
