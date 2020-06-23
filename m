Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF7AC433DF
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 22:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07329208C9
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592950217;
	bh=zmKL1sjxL6w9xqVyEnstEuOeJaEEQeG/0MzpssNKxKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2XAmO83sQHk39gbZyfFp2+IuxbZ8/RPbj/pPGvMR4PQ06UK+EHVdw3AmvoNcbFCnn
	 QH2XZlLiSFPDy/xOKGx67BKO53LacawQvt5hZsrLVTAchUv3FVChZROlBiw4UAG1wz
	 lYopGQn0fIXi1mnVtSz3ZYYnFHcCejFXc3PiEO5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbgFWWKQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387840AbgFWWKQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 18:10:16 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE1420724;
        Tue, 23 Jun 2020 22:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592950215;
        bh=zmKL1sjxL6w9xqVyEnstEuOeJaEEQeG/0MzpssNKxKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1i5VqjUObKdWggQ5UPbobcahz/U8OwwaX9IA3aUeoax52//HJpaFGaqB6azcQQiq
         qjjpG3IEhFMjUIyaDXjPa8qkA2W/7V55h7ED3kPN3Zm3NYey6QTy8iFHF654Tf16gE
         C/ecVNccfzh2VYPuF0I+cRSXgGAR46T4Veraza8Y=
Date:   Tue, 23 Jun 2020 15:10:12 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
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
Message-ID: <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623112551.GB117742@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 11:25:53AM +0000, Niklas Cassel wrote:
> On Tue, Jun 23, 2020 at 01:53:47AM -0700, Sagi Grimberg wrote:
> > On 6/22/20 9:25 AM, Keith Busch wrote:
> > > -		len = nvme_process_ns_desc(ctrl, ids, cur);
> > > +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
> > >   		if (len < 0)
> > >   			goto free_data;
> > >   		len += sizeof(*cur);
> > >   	}
> > >   free_data:
> > > +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
> > 
> > We will clear the status if we detect a path error, that is to
> > avoid needlessly removing the ns for path failures, so you should
> > check at the goto site.
> 
> The problem is that this check has to be done after checking all the ns descs,
> so this check to be done as the final thing, at least after processing all the
> ns descs. No matter if nvme_process_ns_desc() returned an error, or if
> simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached the
> end without error.
> 
> Even if the nvme command failed and the status was cleared:
> 
>                 if (status > 0 && !(status & NVME_SC_DNR))
>                         status = 0;

This check is so weird. What has DNR got to do with whether or not we
want to continue with this namespace? The commit that adds this says
it's to check for a host failed IO, but a controller can just as validly
set DNR in its error status, in which case we'd still want clear the
status.
