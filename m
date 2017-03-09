Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754776AbdCIN43 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Mar 2017 08:56:29 -0500
Subject: Re: [PATCH rfc 03/10] nvme-pci: open-code polling logic in nvme_poll
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-4-git-send-email-sagi@grimberg.me>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <534565a7-4a8d-d125-49db-c8679f716466@suse.de>
Date: Thu, 9 Mar 2017 14:56:27 +0100
MIME-Version: 1.0
In-Reply-To: <1489065402-14757-4-git-send-email-sagi@grimberg.me>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/09/2017 02:16 PM, Sagi Grimberg wrote:
> Given that the code is simple enough it seems better
> then passing a tag by reference for each call site.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Deja-vu again?
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
