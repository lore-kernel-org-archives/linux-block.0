Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76518C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4059F20830
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553521707;
	bh=RA5q9JPt+g4BuA2WAtZKYnH0ae0Hq57mSjDJHYpp/Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gaO7zr99AZkm3EzWscTYS5vTtkoFbKnpHt1SVkLEy+fuhYnAJTsMxi+04TobjzCdk
	 k8Iz/kO8j+biBCGtvZlzU1RDMfa9LbNL6XAZwMQHsy5Bl6oY+nx+QjpBQfiC2Lp2ft
	 UDAfU50h8KC3a1dAEsCa7Yh7TH/6N3d/BQfv+j58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfCYNs0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:48:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:5603 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfCYNs0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 09:48:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 06:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="217363341"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 25 Mar 2019 06:48:11 -0700
Date:   Mon, 25 Mar 2019 07:49:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, hch@lst.de, jthumshirn@suse.de, hare@suse.de,
        josef@toxicpanda.com, bvanassche@acm.org, sagi@grimberg.me,
        keith.busch@intel.com, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
Message-ID: <20190325134917.GA4328@localhost.localdomain>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 01:38:37PM +0800, Jianchao Wang wrote:
> blk_mq_tagset_inflight_iter is not safe that it could get stale request
> in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here. A new helper
> interface nvme_iterate_inflight_rqs is introduced to iterate
> all of the ns under a ctrl.

Nak, NVMe only iterates tags when new requests can't enter, allocated
requests can't dispatch, and dispatched commands can't complete. So
it is perfectly safe to iterate if the driver takes reasonable steps
beforehand. Further, for M tags and N namespaces, we complete teardown
in O(M) time, but this makes in O(M*N) without gaining anything.
