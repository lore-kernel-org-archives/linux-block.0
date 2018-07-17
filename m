Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731532AbeGQO3K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jul 2018 10:29:10 -0400
Date: Tue, 17 Jul 2018 15:56:20 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] blktests: add test for ANA state transition
Message-ID: <20180717135620.7gomzfbnauneu2x4@linux-x5ow.site>
References: <20180717133118.39026-1-hare@suse.de>
 <20180717133118.39026-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180717133118.39026-3-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 17, 2018 at 03:31:18PM +0200, Hannes Reinecke wrote:
> +requires() {
> +	_have_program nvme && _have_module nvme-loop && _have_module loop && \
> +		_have_configfs && _have_fio
> +}

this needs '_have_module_param nvme-core multipath' as well.


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
