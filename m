Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45117 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754618AbdCINzG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Mar 2017 08:55:06 -0500
Subject: Re: [PATCH rfc 09/10] nvmet: Use non-selective polling
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-10-git-send-email-sagi@grimberg.me>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <74284e7b-ae3f-4bbd-c28a-2dccab58cdc0@suse.de>
Date: Thu, 9 Mar 2017 14:54:47 +0100
MIME-Version: 1.0
In-Reply-To: <1489065402-14757-10-git-send-email-sagi@grimberg.me>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/09/2017 02:16 PM, Sagi Grimberg wrote:
> It doesn't really make sense to do selective polling
> because we never care about specific IOs. Non selective
> polling can actually help by doing some useful work
> while we're submitting a command.
> 
> We ask for a batch of (magic) 4 completions which looks
> like a decent network<->backend proportion, if less are
> available we'll see less.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Just out of curiosity, how did you come up with the magic 4?

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
