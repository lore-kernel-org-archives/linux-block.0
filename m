Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34841 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbdFSIAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 04:00:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id d64so15318903wmf.2
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2017 01:00:44 -0700 (PDT)
Subject: Re: [PATCH rfc 03/30] nvme-rdma: reuse configure/destroy admin queue
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-4-git-send-email-sagi@grimberg.me>
 <20170619072004.GC13168@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <71fdef71-24a5-9514-e504-35e7c52b85bc@grimberg.me>
Date: Mon, 19 Jun 2017 11:00:34 +0300
MIME-Version: 1.0
In-Reply-To: <20170619072004.GC13168@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new)
> 
> Too long line..
> 
> Also what about moving the helpers into the right place in the
> previous patch that already re-indented most of this?

Sure.
