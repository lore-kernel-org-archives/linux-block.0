Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C0BC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759F12146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759F12146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeLACtx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:49:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:46461 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLACtx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 21:49:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 07:40:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="294015723"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2018 07:40:09 -0800
Date:   Fri, 30 Nov 2018 08:37:16 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for 4.20
Message-ID: <20181130153716.GA10660@localhost.localdomain>
References: <20181130152430.GA3107@infradead.org>
 <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 08:26:24AM -0700, Jens Axboe wrote:
> On 11/30/18 8:24 AM, Christoph Hellwig wrote:
> > Various fixlets all over, including throwing in a 'default y' for the
> > multipath code, given that we want people to actually enable it for full
> > functionality.
> 
> Why enable it by default? 99.9% of users aren't going to care. That
> seems like an odd choice.

I'm okay with making it the default, but can we move this to 4.21 please?
