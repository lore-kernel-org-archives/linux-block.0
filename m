Return-Path: <jthumshirn@suse.de>
Date: Thu, 1 Sep 2016 09:55:18 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/8] block: add WRITE_BG
Message-ID: <20160901075518.7itcqemtm6dzmj7k@c203.arch.suse.de>
References: <1472663151-18560-1-git-send-email-axboe@fb.com>
 <1472663151-18560-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1472663151-18560-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 31, 2016 at 11:05:44AM -0600, Jens Axboe wrote:
> This adds a new request flag, REQ_BG, that callers can use to tell
> the block layer that this is background (non-urgent) IO.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---

s/WRITE_BG/REQ_BG/ in Subject?

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
