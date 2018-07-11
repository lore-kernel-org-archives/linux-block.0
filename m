Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] bsg: fix bogus EINVAL on non-data commands
To: Tony Battersby <tonyb@cybernetics.com>, Christoph Hellwig <hch@lst.de>,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
 linux-scsi <linux-scsi@vger.kernel.org>, linux-block@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <7730dcb2-7e69-3fc5-7eeb-4bbcf5091f14@cybernetics.com>
 <20180711063716.GA7934@lst.de>
 <21524c51-7b58-19c2-dd13-eca592824185@cybernetics.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9e55c6d8-781b-ccbb-70fc-fc6d7fde5a43@kernel.dk>
Date: Wed, 11 Jul 2018 08:48:46 -0600
MIME-Version: 1.0
In-Reply-To: <21524c51-7b58-19c2-dd13-eca592824185@cybernetics.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/11/18 8:46 AM, Tony Battersby wrote:
> Fix a regression introduced in Linux kernel 4.17 where sending a SCSI
> command that does not transfer data (such as TEST UNIT READY) via
> /dev/bsg/* results in EINVAL.

Thanks Tony, applied for 4.18.

-- 
Jens Axboe
