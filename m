Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] xen/blkfront: correct purging of persistent grants
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-block@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, roger.pau@citrix.com, konrad.wilk@oracle.com
References: <20180928072827.14229-1-jgross@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ccbfcbab-85d5-8ca2-8019-dd24b994f791@kernel.dk>
Date: Fri, 28 Sep 2018 09:41:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180928072827.14229-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/28/18 1:28 AM, Juergen Gross wrote:
> Commit a46b53672b2c2e3770b38a4abf90d16364d2584b ("xen/blkfront: cleanup
> stale persistent grants") introduced a regression as purged persistent
> grants were not pu into the list of free grants again. Correct that.

I'll apply this for 4.19, and if things unexpectedly don't work out,
we can always revert the series next week.

-- 
Jens Axboe
