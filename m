Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB071C282DB
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B2120855
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rFJFR6TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfAUIdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:33:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfAUIdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 03:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gP7wJ8nSlSHrDVViGZ8Ks8dTjbucTfa5sCCflP06yRQ=; b=rFJFR6TQrqOH1n27TzHnfBBF+
        uQIn8krTBUKDnjOQLlsCUuVkk1GUi2PLC7W32nCXpT1qX/OwGz0Dfv6Hm7v+Lrv3S2blVhTyBjqfr
        6Khc3tLJPxO7rBFd0j4mgnnupd6oIe6EPTK4MenY9XV20HNNLIPmgSu4gH3x3aiHiLa9NTtvZEkYf
        oqxEDxEChlhTdwv2PBdLYHZBamiyGyclbtLzSmb/m4jeaGV8mQoulEBrwA5qIF9DCiJgjIjQWz6V9
        SbWO/m7M1ss2agOA+RZCZZbXVdR8XAIbC8I7TT9uU8Wty8VBTvCj5e9hJ241RYRYzZrNr0XCMCLy4
        evMU5mERQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glV1W-0007Xp-9k; Mon, 21 Jan 2019 08:33:38 +0000
Date:   Mon, 21 Jan 2019 00:33:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: dd hangs when reading large partitions
Message-ID: <20190121083338.GB20900@infradead.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 19, 2019 at 08:47:13PM +0100, Marc Gonzalez wrote:
> On 19/01/2019 10:56, Christoph Hellwig wrote:
> 
> > On Jan 18, 2019 at 10:48:15AM -0700, Jens Axboe wrote:
> >
> >> It's UFS that totally buggy, if you look at its queuecommand, it does:
> >>
> >>         if (!down_read_trylock(&hba->clk_scaling_lock))                         
> >>                 return SCSI_MLQUEUE_HOST_BUSY;
> >>
> >> UFS either needs to get fixed up, or we'll want a way to do something like
> >> the below.
> > 
> > I think the right answer is to just revert the offending patch instead
> > of papering over it in the SCSI code.
> 
> [ Adjusting recipients list ]
> 
> Full thread, for new recipients:
> https://www.spinics.net/lists/linux-fsdevel/msg138601.html
> 
> Christoph, do you mean a3cd5ec55f6c7 ?

Yes.
