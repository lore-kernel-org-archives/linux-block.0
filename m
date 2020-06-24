Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB0C433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5043520836
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593019514;
	bh=HhO/sOQOOLLB8Ih6Q75GWOsi4UoMPxjoZ4C46ch4QRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fAHwHBLQ75/uCu7wYAZwe93aScAQ8Zed+6F/f1RKYbb8DbH2zDbtF7q9YVL8S9XXO
	 j3bhp7bM9imscnt1LYPEOhCfR79Ic+ISCkqo52ojt8NKt2MuJkWDJocGn2xFqtW/h2
	 B99OESZcFkFZ7KAsVbZxbrw781Ou3352njxRuaZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405444AbgFXRZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405318AbgFXRZN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 13:25:13 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69022078D;
        Wed, 24 Jun 2020 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593019512;
        bh=HhO/sOQOOLLB8Ih6Q75GWOsi4UoMPxjoZ4C46ch4QRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JrmwJ7Do1aY4hFozWLENjwf9W6i8yfDP71mPxKRPaI6w0QMYl8CRQTFXCuIfLoaeJ
         B3TPbMDgwnc+ANYi3ihXau8KiLP7UKojw6Y+RXUr+ik/+4mGFy7M/WIlnYAQw+Ci2V
         5zVSqMb9Lzj3snQaVFfRU2LI9GdaBtrbc+EvhE0M=
Date:   Wed, 24 Jun 2020 10:25:09 -0700
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
Message-ID: <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 04:17:30PM -0700, Sagi Grimberg wrote:
> 
> > > > > -		len = nvme_process_ns_desc(ctrl, ids, cur);
> > > > > +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
> > > > >    		if (len < 0)
> > > > >    			goto free_data;
> > > > >    		len += sizeof(*cur);
> > > > >    	}
> > > > >    free_data:
> > > > > +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
> > > > 
> > > > We will clear the status if we detect a path error, that is to
> > > > avoid needlessly removing the ns for path failures, so you should
> > > > check at the goto site.
> > > 
> > > The problem is that this check has to be done after checking all the ns descs,
> > > so this check to be done as the final thing, at least after processing all the
> > > ns descs. No matter if nvme_process_ns_desc() returned an error, or if
> > > simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached the
> > > end without error.
> > > 
> > > Even if the nvme command failed and the status was cleared:
> > > 
> > >                  if (status > 0 && !(status & NVME_SC_DNR))
> > >                          status = 0;
> > 
> > This check is so weird. What has DNR got to do with whether or not we
> > want to continue with this namespace? The commit that adds this says
> > it's to check for a host failed IO, but a controller can just as validly
> > set DNR in its error status, in which case we'd still want clear the
> > status.
> 
> The reason is that if this error is not a DNR error, it means that we
> should retry and succeed, we don't want to remove the namespace.

And what if it is a DNR error? For example, the controller simply
doesn't support this CNS value. While the controller should support it,
we definitely don't need it for NVM command set namespaces.
 
> The problem that this solves is the fact that we have various error
> recovery conditions (interconnect issues, failures, resets) and the
> async works are designed to continue to run, issue I/O and fail. The
> scan work, will revalidate namespaces and remove them if it fails to
> do so, which is inherently wrong if these are simply inaccessible by
> the host at this time.

Relying on a specific bit in the status code seems a bit indirect for
this kind of condition.
