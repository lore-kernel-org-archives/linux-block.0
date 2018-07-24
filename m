Return-Path: <hch@lst.de>
Date: Tue, 24 Jul 2018 19:41:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>, keith.busch@intel.com,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@kernel.dk, vladimirk@mellanox.com
Subject: Re: [PATCH 2/3] block: move dif_prepare/dif_complete functions to
	block layer
Message-ID: <20180724174104.GA1791@lst.de>
References: <1532439222-5668-1-git-send-email-maxg@mellanox.com> <1532439222-5668-2-git-send-email-maxg@mellanox.com> <20180724135546.GB29918@lst.de> <2fdb170d-e8de-b7cc-429a-9b6e5f36de86@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2fdb170d-e8de-b7cc-429a-9b6e5f36de86@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

> /**
>  * t10_pi_prepare() - prepate PI prior submitting request to device

no need for the braces here.

>
>  * @rq:               request with PI that should be prepared
>  * @protection_type:  PI type (Type 1/Type 2/Type 3)
>  *
>  * Description:

No need for the description tag either (although I don't think it
is actively harmful)
