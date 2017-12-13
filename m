Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 13 Dec 2017 08:13:52 -0800
From: Tejun Heo <tj@kernel.org>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, oleg@redhat.com,
	peterz@infradead.org, kernel-team@fb.com, osandov@fb.com,
	linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Message-ID: <20171213161352.GT3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org>
 <83fa38dc-ce9c-054a-43e9-38b339e5fb27@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83fa38dc-ce9c-054a-43e9-38b339e5fb27@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi, Jianchao.

On Wed, Dec 13, 2017 at 01:07:30PM +0800, jianchao.wang wrote:
> Test ok with NVMe

Awesome, thanks for testing!

-- 
tejun
