Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 00/15] bcache patches for 4.20
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20181008124121.20192-1-colyli@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8a6ebecf-9bed-afee-488f-1bacef2db8a4@kernel.dk>
Date: Mon, 8 Oct 2018 08:20:24 -0600
MIME-Version: 1.0
In-Reply-To: <20181008124121.20192-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/8/18 6:41 AM, Coly Li wrote:
> Hi Jens,
> 
> Here are patches for Linux 4.20. In this run we don't have big changes,
> most of the patches for fixes or code cleanup.
> 
> Ben Peddell resends a patch which had no response for a while, I pick
> it for this version. Our new developer Dongbo Cao contributes a bug fix
> to avoid kernel panic for too small cache set size, with other code
> cleanup changes. Shenghui and me have several code cleanup and minor
> fixes, and Junhui again contributes helpful fixes for several real bugs.
> 
> Please pull them for 4.20 merge window. Thanks in advance.

Applied, thanks.

-- 
Jens Axboe
