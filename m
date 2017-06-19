Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35700 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdFSN6u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 09:58:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id d64so16519863wmf.2
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2017 06:58:49 -0700 (PDT)
Subject: Re: [PATCH rfc 10/30] nvme: Add admin_tagset pointer to nvme_ctrl
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-11-git-send-email-sagi@grimberg.me>
 <20170619124138.GJ29061@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2e697102-4560-f104-f1c9-cd7c3733b386@grimberg.me>
Date: Mon, 19 Jun 2017 16:58:45 +0300
MIME-Version: 1.0
In-Reply-To: <20170619124138.GJ29061@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> Will be used when we centralize control flows. only
>> rdma for now.
> 
> Should we at some point move the tag_sets themselves to the generic
> ctrl instead of just pointers?

We can easily do that, but the tagsets are heavily read in the hot path
so I was careful not to completely move them to nvme_ctrl which is not
arranged for it at all (and transports through it far back in their
struct).

Once we actually get some of this merged we should look into arranging
the transport controllers to be:

struct transport_ctrl {
	/* transport specific accessed in the hot path */
	...

	struct nvme_ctrl ctrl; /* hot members first */

	/* transport specific bookkeeping */
	...
};
