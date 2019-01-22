Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC2C282C5
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 16:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D817821726
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548174170;
	bh=XJvHs6X0ydJ0puugVMlXnKJKSP2V9W8H397zcm1Fhk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D3Rk5LQ62pq+MQBrAp80+5s31ly/YxImt838bzdjNybTkAOML/+XK/8DwxsOPyEE9
	 +TrXFQLLXOeeh26zFbdInaPdzid2N6W5aLDnhMjZ9YKeuH8leiWG05eqGvY3qltvOM
	 3ixaNdQDJ7ui+pKLbu/G+nqGy480oQpQAhMYbelc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfAVQWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbfAVQWt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 11:22:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B4320870;
        Tue, 22 Jan 2019 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548174168;
        bh=XJvHs6X0ydJ0puugVMlXnKJKSP2V9W8H397zcm1Fhk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5fXr4MT9XENi1tJiGfrRWW2BwuBYHjZQ5O1sAvnUuJXuAauyO5p5loWzvbKgOujw
         4yeetmIMuMR2QdkCfqYomH2GdyNQvHukVh6L8eKgR0e8zWO5GvYcJyaHQLAW/nsC9u
         MuXOsnoiglm8csljK17HKUWR3dWbxvracdzUFEuk=
Date:   Tue, 22 Jan 2019 17:22:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20190122162246.GA22548@kroah.com>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
 <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
 <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
 <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
 <fdfe4600-9bf5-0b6e-cd45-4ca836a477fe@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdfe4600-9bf5-0b6e-cd45-4ca836a477fe@free.fr>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 22, 2019 at 05:17:56PM +0100, Marc Gonzalez wrote:
> + Greg
> 
> On 22/01/2019 11:59, Marc Gonzalez wrote:
> 
> > FULL SESSION LOG: https://pastebin.ubuntu.com/p/YSm82GxhNW/
> 
> I finally got the hung_task detector to fire:
> https://pastebin.ubuntu.com/p/XDDJjf7PTb/
> 
> Had a chat with GKH, who said that drivers/scsi/ufs is known to be not 100% functional,
> and requires some cherry-picking from downstream to handle all corner cases.

Note, we know it needs that for your controller, maybe not for others.
So you can't make that kind of generalization :(

thanks,

greg k-h
