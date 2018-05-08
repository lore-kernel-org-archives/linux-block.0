Return-Path: <corbet@lwn.net>
Date: Tue, 8 May 2018 09:19:06 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, axboe
 <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>, Cai Zhiyong
 <caizhiyong@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: block: cmdline-partition.txt fixes and
 additions
Message-ID: <20180508091906.7d085bf4@lwn.net>
In-Reply-To: <dba389fc-2745-34b1-e33e-fc83f53eaf42@infradead.org>
References: <dba389fc-2745-34b1-e33e-fc83f53eaf42@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Sun, 6 May 2018 11:50:29 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Make the description of the kernel command line option "blkdevparts"
> a bit more flowing and readable.
> 
> Fix a few typos.
> Add the optional <size> and <offset> suffixes.
> Note that size can be "-" to indicate all of the remaining space.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.

jon
