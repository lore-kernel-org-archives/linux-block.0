Return-Path: <SRS0=4Sb2=2K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340B6C43603
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 21:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054412146E
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576876858;
	bh=yGg5OlUqc48W/wvYsM0UnmokbFwFG5mhnif2M8frODU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Evxzw3pjjSteTVCGVp8F90jfm+C7PGK21CeqLtSuL+HRdhHTTBSR9EPT7Ghvx7+//
	 o9wBzPmYc3kSR1Fi4ZRDbLtcvqqH40DtXOZ1bB8Ky2hLkn5svYosD6T64znzjbRWkH
	 FwzkcWHCgSNlQmwUUI8ql6NhQbBtoO0A7HUHnys0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfLTVU4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:20:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfLTVU4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 16:20:56 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3AF02146E;
        Fri, 20 Dec 2019 21:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576876855;
        bh=yGg5OlUqc48W/wvYsM0UnmokbFwFG5mhnif2M8frODU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWWY0UW2sFFIBtlkukfagk7PdXSlhHtKkyDbmN0b7MlVVaPBN978xsJ77maOc5+h1
         zVfm2zAtRKL4MQhZmbqbtcHmYyG4LkE1kE8h/KV2mhe6tE4b8ByzgApeesSeq2/RE7
         yFZy3wqZzchXnF7KcDZWUkhm7HkMaNg5GSwoO/1U=
Date:   Sat, 21 Dec 2019 06:20:49 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Ober, Frank" <frank.ober@intel.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "Rajendiran, Swetha" <swetha.rajendiran@intel.com>,
        "Liang, Mark" <mark.liang@intel.com>
Subject: Re: Polled io for Linux kernel 5.x
Message-ID: <20191220212049.GA5582@redsun51.ssa.fujisawa.hgst.com>
References: <SN6PR11MB2669E7A65DD0AD9DC65A67C58B520@SN6PR11MB2669.namprd11.prod.outlook.com>
 <20191219205210.GA26490@redsun51.ssa.fujisawa.hgst.com>
 <SN6PR11MB2669F3546ADCCAEF1D8E50308B520@SN6PR11MB2669.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB2669F3546ADCCAEF1D8E50308B520@SN6PR11MB2669.namprd11.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 19, 2019 at 09:59:14PM +0000, Ober, Frank wrote:
> Thanks Keith, it makes sense to reserve and set it up uniquely if you
> can save hw interrupts. But why would io_uring then not need these
> queues, because a stack trace I ran shows without the special queues I
> am still entering bio_poll. With pvsync2 I can only do polled io with
> the poll_queues?

Polling can happen only if you have polled queues, so io_uring is not
accomplishing anything by calling iopoll. I don't see an immediately
good way to pass that information up to io_uring, though.
