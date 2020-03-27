Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FC4C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 18:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453C2208E4
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585333114;
	bh=nD1ZASDin7IOUe/665O+N3wleArI2IiupnuXq6p37/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yLn5tk02Sd1pAPfC6uF4NtEAJXArBm/uCnVQvKl1Yp+/q1l/fxi50BFSEeQ+uDmaH
	 v8T52z5Eu3ymo1SeM+SkfkWY6EC1kqR08OZc7Gdn2nSZ59nKBeIdAbgLYaUBWi/vFi
	 l2QCfYmSwP2SLCdYrU9dbWU79QM6dMGR4NFDS+VI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0SSd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0SSd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 14:18:33 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFF742083E;
        Fri, 27 Mar 2020 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585333112;
        bh=nD1ZASDin7IOUe/665O+N3wleArI2IiupnuXq6p37/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0MFRh6Tqf32c/CY26P6nrLMdJDOc6f/E8tygCg5stx2gYsuuEOpUS4B+rYa563rkI
         EeQfyM6ZB1JpwQkM72ZyTSn8teCyqqVAtimB3Ziln92WNuBiUGaqPVTo2g2o2vrJh4
         P3ZF85J5gqJepjB2WMibEM8sfNyZI/gKEbAQ8QVI=
Date:   Sat, 28 Mar 2020 03:18:25 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Tokunori Ikegami <ikegami.t@gmail.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
Message-ID: <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
> On 2020/03/25 1:51, Tokunori Ikegami wrote:
> > On 2020/03/24 9:02, Keith Busch wrote:
> > > We didn't have 32-bit max segments before, though. Why was 16-bits
> > > enough in older kernels? Which kernel did this stop working?
> > Now I am asking the detail information to the reporter so let me
> > update later.  That was able to use the same command script with the
> > large data length in the past.
> 
> I have just confirmed the detail so let me update below.
> 
> The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
> 64bit).
> Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
> But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
> (Ubuntu 64bit).
> So the original 20,531,712 length failure issue seems already resolved.
> 
> I tested the data length 0x10000000 (268,435,456) and it is failed
> But now confirmed it as failed on all the above kernel versions.
> Also the patch fixes only this 0x10000000 length failure issue.

This is actually even more confusing. We do not support 256MB transfers
within a single command in the pci nvme driver anymore. The max is 4MB,
so I don't see how increasing the max segments will help: you should be
hitting the 'max_sectors' limit if you don't hit the segment limit first.
