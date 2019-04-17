Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DBFC282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 16:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A34206BA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555516890;
	bh=TRg4EzwBPmiLoFgszhjrFpdgQPoQNlT2s7C7DFcRWW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Csti8nI1fS0nA6uTKhau6rJ3zymhCvOSc/e6f9vhw3tSfGc0/wE0pK972fiGwmvp
	 oRh9QcCW06gv6HVIBrD+ZcppTj3HxmTq3dVtu6VkAuFVS8iys6yhhYaEAgXEptjG+n
	 vO6zJOxjoshm234XsqPASVeQyg943iNuei7Sr7JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbfDQQB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:01:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:57428 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfDQQB3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 12:01:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 09:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="292360525"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2019 09:01:27 -0700
Date:   Wed, 17 Apr 2019 09:55:12 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V6 9/9] nvme: hold request queue's refcount in ns's whole
 lifetime
Message-ID: <20190417155511.GA6005@localhost.localdomain>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-10-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417034410.31957-10-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 16, 2019 at 08:44:10PM -0700, Ming Lei wrote:
> Hennes reported the following kernel oops:
> 
>     There is a race condition between namespace rescanning and
>     controller reset; during controller reset all namespaces are
>     quiesed vie nams_stop_ctrl(), and after reset all namespaces
>     are unquiesced again.
>     When namespace scanning was active by the time controller reset
>     was triggered the rescan code will call nvme_ns_remove(), which
>     then will cause a kernel crash in nvme_start_ctrl() as it'll trip
>     over uninitialized namespaces.
> 
> Patch "blk-mq: free hw queue's resource in hctx's release handler"
> should make this issue quite difficult to trigger. However it can't
> kill the issue completely becasue pre-condition of that patch is to
> hold request queue's refcount before calling block layer API, and
> there is still a small window between blk_cleanup_queue() and removing
> the ns from the controller namspace list in nvme_ns_remove().
> 
> Hold request queue's refcount until the ns is freed, then the above race
> can be avoided completely. Given the 'namespaces_rwsem' is always held
> to retrieve ns for starting/stopping request queue, this lock can prevent
> namespaces from being freed.

This looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
