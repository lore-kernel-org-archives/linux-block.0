Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35401 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdFSIDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 04:03:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id z45so12184221wrb.2
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2017 01:03:39 -0700 (PDT)
Subject: Re: [PATCH rfc 29/30] nvme: add sed-opal ctrl manipulation in admin
 configuration
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-30-git-send-email-sagi@grimberg.me>
 <20170619072220.GF13168@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a13e909c-6f0b-0cb3-18c7-878fcf02b3d5@grimberg.me>
Date: Mon, 19 Jun 2017 11:03:36 +0300
MIME-Version: 1.0
In-Reply-To: <20170619072220.GF13168@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> The subject sounds odd and it could use a changelog.  But I'd love to
> pick this change up ASAP as it's the right thing to do..

How? where would you place it? there is no nvme_configure_admin_queue in
nvme-core.

I suppose we could get it in nvme_init_ctrl?
