Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89093D561
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004567; cv=none; b=PeIjui1UZO1muIE9lndXgAJ7DOOjI4W+Cn/y61U1Yms6krUyqIoznqh7sh8Kfv1m3NB/n1QFWWITXRFjK8bl7H343VQ4EuDrVpnuD1xEnz/T2sMOCRi7fjf3Ac65x3q5QewkLKLPv2JhDcQ94LsdX+qhtaXo1YsDMN/k1qOHlRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004567; c=relaxed/simple;
	bh=VMYEXmQ31vZoaeT5BJqBEM7W7RxQf5HP3q4nS2rIaMI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gdZch+ouqm9HDurhYut6Ck8lH1WcZACM8INTyQ6b9ggkX9Fc1sRUaA9vgBO+pt4EJsQS3yy8UHVRJhxvAR3DFyOepzympBePkLL1uxbovaw0HmopCquU2xdag3MKvzNSmapx5ePWc6tDBPCj3NDKLCuWPLWgFDSchMqp2OPNPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PLS4hCbR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PLS4hCbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20D3C19423;
	Wed,  1 Apr 2026 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775004567;
	bh=VMYEXmQ31vZoaeT5BJqBEM7W7RxQf5HP3q4nS2rIaMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PLS4hCbRspOTf3kxCl5oZZ61sXb0Z3sOjK4oQzOBTNxJmyUvD3LTxjueGtaPbuOnD
	 w6QA3iIrDJXL/dcU2iMc/jTcmFtSMjnhGc0X9pOJJYPC+UYXjjGseYbasBM/PRO7yu
	 cn6FC9+3rvOTZBAyNZGJgtyLzqrB6zqL2Htg3uTM=
Date: Tue, 31 Mar 2026 17:49:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org, Qu Wenruo <wqu@suse.com>,
 Avinesh Kumar <avinesh.kumar@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] zram: do not forget to endio for partial discard
 requests
Message-Id: <20260331174926.58ef8dc4d40ac12f8ce3905d@linux-foundation.org>
In-Reply-To: <20260331074255.777019-1-senozhatsky@chromium.org>
References: <20260331074255.777019-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 16:42:44 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> As reported by Qu Wenruo, the following
> 
>  getconf PAGESIZE
>  65536
>  blkdiscard -p 4k /dev/zram0
> 
> takes literally forever to complete.

I'm wondering how you measured this interval ;)

> zram doesn't support
> partial discards and just returns immediately w/o doing any
> discard work in such cases.  The problem is that we forget
> to endio on our way out, so blkdiscard sleeps forever in
> submit_bio_wait().  Fix this by jumping to end_bio label,
> which does bio_endio().
> 
> Fixes: 0120dd6e4e202 ("zram: make zram_bio_discard more self-contained")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reported-by: Qu Wenruo <wqu@suse.com>
> Closes: https://lore.kernel.org/linux-block/92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com
> Test-by: Qu Wenruo <wqu@suse.com>
> Cc: Avinesh Kumar <avinesh.kumar@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>

Thanks.  I made several changes to the changelog from the earlier
discussion (Anivesh Reported-by:/Closes:) and added a cc:stable.

0120dd6e4e202 was a few years ago so no need to rush this into mainline
- target this to the upcoming merge window.


From: Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: zram: do not forget to endio for partial discard requests
Date: Tue, 31 Mar 2026 16:42:44 +0900

As reported by Qu Wenruo and Avinesh Kumar, the following

 getconf PAGESIZE
 65536
 blkdiscard -p 4k /dev/zram0

takes literally forever to complete.  zram doesn't support partial
discards and just returns immediately w/o doing any discard work in such
cases.  The problem is that we forget to endio on our way out, so
blkdiscard sleeps forever in submit_bio_wait().  Fix this by jumping to
end_bio label, which does bio_endio().

Link: https://lkml.kernel.org/r/20260331074255.777019-1-senozhatsky@chromium.org
Fixes: 0120dd6e4e202 ("zram: make zram_bio_discard more self-contained")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Qu Wenruo <wqu@suse.com>
Closes: https://lore.kernel.org/linux-block/92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com
Tested-by: Qu Wenruo <wqu@suse.com>
Reported-by: Avinesh Kumar <avinesh.kumar@suse.com>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1256530
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/zram/zram_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/block/zram/zram_drv.c~zram-do-not-forget-to-endio-for-partial-discard-requests
+++ a/drivers/block/zram/zram_drv.c
@@ -2678,7 +2678,7 @@ static void zram_bio_discard(struct zram
 	 */
 	if (offset) {
 		if (n <= (PAGE_SIZE - offset))
-			return;
+			goto end_bio;
 
 		n -= (PAGE_SIZE - offset);
 		index++;
@@ -2693,6 +2693,7 @@ static void zram_bio_discard(struct zram
 		n -= PAGE_SIZE;
 	}
 
+end_bio:
 	bio_endio(bio);
 }
 
_

