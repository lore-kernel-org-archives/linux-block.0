Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB95DC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 20:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE2820672
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 20:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE2820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbeLJU3U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:29:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:57881 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbeLJU3U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 15:29:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 12:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="108488073"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 10 Dec 2018 12:29:19 -0800
Date:   Mon, 10 Dec 2018 13:26:47 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Laurence Oberman <loberman@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Todd Aiken <taiken@mvtech.ca>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Restore tape support
Message-ID: <20181210202647.GA8101@localhost.localdomain>
References: <20181210030814.13235-1-bvanassche@acm.org>
 <20181210153230.GB25206@localhost.localdomain>
 <1544472412.18488.5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544472412.18488.5.camel@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 10, 2018 at 03:06:52PM -0500, Laurence Oberman wrote:
> Tested and works fine. 
> Thanks All
> 
> Tested-by: Laurence Oberman <loberman@redhat.com>

Cool, thank you for confirming.
