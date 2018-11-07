Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
To: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org
References: <20181107143745.11845-1-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b7a9a32c-6d5d-e73f-73ba-186b640400d2@kernel.dk>
Date: Wed, 7 Nov 2018 15:41:46 -0700
MIME-Version: 1.0
In-Reply-To: <20181107143745.11845-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/7/18 7:37 AM, Keith Busch wrote:
> If the kernel allocates a bounce buffer for user read data, this memory
> needs to be cleared before copying it to the user, otherwise it may leak
> kernel memory to user space.

Applied, thanks.

-- 
Jens Axboe
