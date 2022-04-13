Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD9EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 18:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiDMSOx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiDMSOw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 14:14:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0636E0C
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ECPVHGfqiriK51+axTOgvFPf4LHLt1sw8aFQdGNu5Dw=; b=J7wKOJfWGJo9WmL9a7rQhEzOs1
        P38rY9yO9l2jkaXblaty9So9Bitz0CilXTC1MohVG7mD7qiy8rXHoZM8OG1bQfg2EsQfNgtmsWyno
        e1dowklMofvyy1swGfKGFU72S2rxMmwVaazG/gCtaiCy7arZiFPRqrOpddmIvOMufzraINSSIrjti
        s6ivBkhS0Czzpz01jz/p4jRXWn7hmgCNfIBmDGbenr1KyBY8is8tNGuQD5MiYPmrijc6A9Oe5GTWh
        tiJh58PqP9AsNDx8CCWpOkd/vDzlRvTka7T/qpUNuirlbYd+CCoQoIxJIDkwH0r3LWy/TXpIHeAhY
        Pg7BAG9g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nehTe-0022Mm-Nz; Wed, 13 Apr 2022 18:12:26 +0000
Date:   Wed, 13 Apr 2022 11:12:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bvanassche@acm.org, yi.zhang@redhat.com, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlcSiszuNqVZMsb5@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlcLOM49JsdlBqTW@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 10:41:12AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 13, 2022 at 10:38:50AM -0700, Luis Chamberlain wrote:
> > On Tue, Apr 12, 2022 at 09:53:12PM -0700, Christoph Hellwig wrote:
> > > On Tue, Apr 12, 2022 at 05:24:04PM -0700, Luis Chamberlain wrote:
> > > > I do have CONFIG_NVME_MULTIPATH=y but I also have:
> > > 
> > > I'd suggest to ignore broken tests that require a deprecated option
> > > that will eventually be removed.
> > 
> > CONFIG_NVME_MULTIPATH will eventually be nuked?
> 
> You'll only get a single namespace without it once the phaseout is
> complete, yes.

OK so CONFIG_NVME_MULTIPATH will be nuked, but the module parameter
will remain, and if the module parameter is used with multipath=N you'll
end up with a single namespace once the phase out of
CONFIG_NVME_MULTIPATH is complete.

> If you want nvme multipathing you'll need it, which
> is the story since day one.

Sounds good.

> If Bart wants to test dm-multipath I think his earlier srp_tests are
> the much better choice.

OK thanks for the heads up.

  Luis
