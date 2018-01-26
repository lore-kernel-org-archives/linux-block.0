Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove smart1,2.h
To: Corentin Labbe <clabbe@baylibre.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1516997561-13708-1-git-send-email-clabbe@baylibre.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <55f4f9c9-f851-4ec6-68e1-2e85f12442ab@kernel.dk>
Date: Fri, 26 Jan 2018 13:20:22 -0700
MIME-Version: 1.0
In-Reply-To: <1516997561-13708-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/26/18 1:12 PM, Corentin Labbe wrote:
> smart1,2.h is unused since commit d436641439e0 ("cpqarray: remove it from the kernel")
> Remove it from tree.

Indeed, thanks, applied.

-- 
Jens Axboe
