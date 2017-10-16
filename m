Return-Path: <BATV+3ff110a13ecf88c993b6+5167+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 16 Oct 2017 05:48:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Move tagset reinit to its only current consumer,
 nvme-core
Message-ID: <20171016124817.GB26833@infradead.org>
References: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Jens, are you fine with picking this up throught the nvme tree?
I think Sagi's later changes rely on it, so that would make life
a littler easier.
