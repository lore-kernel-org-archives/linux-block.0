Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36234 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdHPJdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2017 05:33:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id d40so4131070wma.3
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2017 02:33:50 -0700 (PDT)
Subject: Re: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816081605.GA29784@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <964d191e-0fe4-e440-71e6-0fd186d4f52b@grimberg.me>
Date: Wed, 16 Aug 2017 12:33:47 +0300
MIME-Version: 1.0
In-Reply-To: <20170816081605.GA29784@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>> This set applies on nvme-4.14 plus 4.13 recent fixes.
> 
> I can't get this applied at all.

That's probably because this is on top of the rdma affinity
patches which are already in Doug's tree...

> A pointer to a git repo would
> always be nice for patchsets as large as this one, especially if
> the base is a bit murky..

Sure, should I have it on top of the affinity patches or not?
