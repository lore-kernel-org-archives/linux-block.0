Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] (xen-blkfront) stable/for-jens-4.10 for your
 'linux-next' branch.
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-block@vger.kernel.org, xen-devel@lists.xensource.com,
 linux-kernel@vger.kernel.org
References: <20170127184743.GB31429@char.us.oracle.com>
Cc: jbeulich@suse.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <35658a30-43e6-8972-fd2a-0d5131f1a77a@kernel.dk>
Date: Fri, 27 Jan 2017 11:57:32 -0700
MIME-Version: 1.0
In-Reply-To: <20170127184743.GB31429@char.us.oracle.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/27/2017 11:47 AM, Konrad Rzeszutek Wilk wrote:
> Hey Jens,
> 
> Please pull in your 'for-linus' branch two little fixes for Xen
> block front:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.10
> 
> One fix is for handling the XEN_PAGE_SIZE != PAGE_SIZE (4KB vs 64KB
> on ARM for example) mishandling while the other is fixing
> the accounting for the configuration changes.

Pulled, thanks.

-- 
Jens Axboe
