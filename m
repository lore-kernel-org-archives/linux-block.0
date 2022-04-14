Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F4BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 01:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiDNBNm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiDNBNm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 21:13:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F0931533
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 18:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kWVt3LbLbiaBHv3y8iuVbE2sHlShlDViJZHOzv6cmdQ=; b=SU79pIfENM8SLmsvfiakyyAPBT
        lTZgjTld0lLSFE9NyTycAaLeeNvGECd6IvHOhDoU50ovFJbbjvBQtU8UGZZ6QUMJJMuxNKGVxJ61o
        Q7OltNYEB687JH2+KNqs5vSc6bwMT5+BiDVxVYRvrnK3CFlhhCzdi+pWuqKRIkFx+NSA9JzgTknMZ
        GfmGIL7rk+AC2NNMIXN8V3X8TvJ/GowrWydrGiq3kRAIYiwygMK4HzKh20NayKyU63nMCWGNUzUf3
        /a3IDMl2FGb2ylXa8YogSp7Uwh6RlMmTYFpbG2jWZOiLkzt66VIym4P5Shrfv37MfKm40moBU/zQo
        p2DQFTkA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neo11-003FCj-Fm; Thu, 14 Apr 2022 01:11:19 +0000
Date:   Wed, 13 Apr 2022 18:11:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
Subject: Re: blktests srp failures with a guest with kdevops on v5.17-rc7
 removal
Message-ID: <Yld0t1DeZdNBzMR+@bombadil.infradead.org>
References: <YldoSh6o5sbifsJf@bombadil.infradead.org>
 <8db9ded3-ae12-3c56-5ac6-35ee9b9117bc@acm.org>
 <Yldyy3ZSEbaTxwSj@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yldyy3ZSEbaTxwSj@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 06:03:07PM -0700, Luis Chamberlain wrote:
> On Wed, Apr 13, 2022 at 05:50:38PM -0700, Bart Van Assche wrote:
> > On 4/13/22 17:18, Luis Chamberlain wrote:
> > > I've started to work on expanding coverage of testing with blktests
> > > on kdevops [0] to other test groups. srp was one of them. But the amount
> > > of failures I'm seeing seems to tell me I'm probably doing something
> > > really stupid, so please help me review the setup. The baseline for
> > > srp is listed below, each of these is a failure. I've used v5.17-rc7
> > > as a starting point.
> > 
> > Do the SRP tests pass when using the Soft-iWARP driver instead of rdma_rxe?
> 
> It looks *much* better.
> 
> > I'm asking this because there are known issues with the rdma_rxe driver in
> > kernel versions v5.17 and also in v5.18-rc1.
> 
> OK thanks.
> 
> > An example of how to select the
> > Soft-iWARP driver:
> > 
> > cd blktests && use_siw=1 ./check -q srp/001
> 
> I see failures on the first run:
> 
> srp/005

A couple of more failures on the 3rd run,

srp/006 (Direct I/O with large transfer sizes, cmd_sg_entries=255 and
bs=8M) [failed]
runtime  13.566s  ...  9.712s
--- tests/srp/006.out       2022-04-09 03:14:48.859579024 +0000
+++ /usr/local/blktests/results/nodev/srp/006.out.bad
2022-04-14 01:05:20.904694773 +0000
@@ -1,2 +1 @@
Configured SRP target driver
-Passed

srp/012 (dm-mpath on top of multiple I/O schedulers)         [failed]
runtime  5.601s  ...  9.256s
--- tests/srp/012.out       2022-04-09 03:14:48.859579024 +0000
+++ /usr/local/blktests/results/nodev/srp/012.out.bad
2022-04-14 01:06:46.136722414 +0000
@@ -1,2 +1 @@
Configured SRP target driver
-Passed

My exclusion list one-liner is getting longer, but hey, no crashes yet.

i=0; while true; do use_siw=1 ./check -q srp -x srp/001 -x srp/005 -x srp/006 -x srp/011 -x srp/012 -x srp/013 ; if [[ $? -ne 0 ]]; then echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=$i+1; done;

  Luis
