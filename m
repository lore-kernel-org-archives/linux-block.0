Return-Path: <BATV+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 22 May 2018 03:05:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
	bcrl@kvack.org, tglx@linutronix.de, mingo@kernel.org,
	pombredanne@nexb.com, kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org, bigeasy@linutronix.de, jack@suse.cz,
	darrick.wong@oracle.com, rgoldwyn@suse.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 5/5] fs: iomap dio set bio prio from kiocb prio
Message-ID: <20180522100554.GC30026@infradead.org>
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
 <20180521160147.2372-6-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521160147.2372-6-adam.manzanares@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
