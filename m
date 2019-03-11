Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFF4C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 15:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3EB218FC
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 15:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552318922;
	bh=VSrQ/L/5OnfbS1F/MP/plby49DLqCBmzfy6d4k61gRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fj3CvQijCR6aTjqjfcygxWOgPYJi44zwRs1NfBbwFdkKzsHstoIqUbLQoYygCNUke
	 wBHVYOTWaPpOebiIrP7WjyL9HQWsDTxNZYDQSOwQ029Wb7B6VFHOPd1MQUjDHUWcHE
	 CLR1t+U3ErZqrHPG+zWU0Ogv9CWrBXZ3V/PIXwUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCKPmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:42:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:53870 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfCKPmB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 11:42:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 08:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="133124749"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2019 08:42:00 -0700
Date:   Mon, 11 Mar 2019 09:42:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/5] nvme: Fail dead namespace's entered requests
Message-ID: <20190311154239.GB10411@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-4-keith.busch@intel.com>
 <671edb24-d3a7-988e-c1e5-3ba140da5451@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671edb24-d3a7-988e-c1e5-3ba140da5451@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 10, 2019 at 08:58:21PM -0700, jianchao.wang wrote:
> Hi Keith
> 
> How about introducing a per hctx queue_rq callback, then install a
> separate .queue_rq callback for the dead hctx. Then we just need to
> start and complete the request there.

That sounds like it could work, though I think just returning
BLK_STS_IOERR like we currently do is better than starting a completing
it. But adding a new callback that can change at runtime is a more
complicated, and would affect a lot more drivers that I am not able
to test.
