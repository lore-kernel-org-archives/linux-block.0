Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC43C433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 21:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC382081A
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 21:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593035361;
	bh=VpmbtELydXZc3a6i1+KX2Op5vIZHkJl1heXqRXN7uqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sf1893mGtbyvLLMIRi8vp/s2laLM5koqD8B6EbGZ6OSxHV1IiQBfwM1fT28QQAJwF
	 KxAsCs4oo9gSX+A07k6BU4ZArtITZqSGaTR+WtECyYfx1KjlhtUAayNwiUs25XLEiH
	 21+feEsJrvwtH0dXX6bE4M0c2kvtu1X+fPfIAiRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404959AbgFXVtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404700AbgFXVtU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 17:49:20 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD864207E8;
        Wed, 24 Jun 2020 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593035359;
        bh=VpmbtELydXZc3a6i1+KX2Op5vIZHkJl1heXqRXN7uqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9wN7G5ZQIjHSGWgwgEeEHUa6Oi8nVzi1c4P81FHcBHtypR1ibmVqkrW86Xozpupq
         mz0eb7qX12xIPrNGLlG+o+wFdPl4q5y6E8WO3aqP84/5tjmJaqxCoRmQm5zgYpnlMX
         bDgk2eP6R66mXkZLVW7zpqq94096L/xgkuwyRS3E=
Date:   Wed, 24 Jun 2020 14:49:16 -0700
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
Message-ID: <20200624214916.GG1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
 <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
 <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 24, 2020 at 12:03:41PM -0700, Sagi Grimberg wrote:
> 
> > > > > If the controller does not support the CNS value, it may return Invalid
> > > > > Field with DNR set. That error currently gets propogated back to
> > > > > nvme_init_ns_head(), which then abandons the namespace. Just as the code
> > > > > coments say, we had been historically been clearing such errors because
> > > > > we have other ways to identify the namespace, but now we're not clearing
> > > > > that error.
> > > > 
> > > > I don't understand what you are saying Keith.
> > > > 
> > > > My comment was for this block:
> > > > -- 
> > > >       if (!status && nvme_multi_css(ctrl) && !csi_seen) {
> > > >           dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
> > > >                nsid);
> > > >           status = -EINVAL;
> > > >       }
> > > > -- 
> > > > 
> > > > I was saying that !status doesn't necessarily mean success, but it can
> > > > also mean that its an retry-able error status (due to transport or
> > > > controller). If we see a retry-able error we should still clear the
> > > > status so we don't abandon the namespace.
> > > > 
> > > > This for example would achieve that:
> > 
> > We're not talking about the same thing. I am only talking about what
> > introduced the DNR check, from commit 59c7c3caaaf87.
> > 
> > I know you added it because you want to abort comparing identifiers on a
> > rescan when retrieving the identifiers failed. That's fine, but I am
> > saying this fails namespace creation in the first place for some types
> > of devices that used to succeed.
> 
> OK, now I think I understand (thanks for clarifying that the discussion
> is not on patch 3/5, but rather on 59c7c3caaaf87).
> 
> So the original proposal was to check NVME_SC_HOST_PATH_ERROR (and now
> we have NVME_SC_HOST_ABORTED_CMD) but with the review Christoph gave
> it seemed to make more sense that we generalize and check the DNR bit.

Okay, I didn't question this approach when it first went through, so
sorry about this digression, but I really don't get how this DNR check
helps at all.

The code currently returns an error if DNR is set. Based on the commit
messages, it sounds like you need that error to skip comparing
identifiers through nvme's scan_work calling revalidate_disk():
suppressing the error has revalidate_disk() fail with -ENODEV when
comparing identifiers fails.

Since we do return the error when DNR is set, we skip comparing
identifiers and return blk_status_to_errno(nvme_error_status(ret))
instead. How is that errno an improvement?

And then if DNR is not set, we suppress the error and proceed with
comparing identifiers??
