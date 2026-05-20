Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD939936D
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267300; cv=none; b=J7i/m3qd3RNL9i1UQ2t1yp1ByQODfsqdPurjgEUxkSPUk3fFI6NyKEjs7ek2AhfIw4a4iBlsOAf+Mco8iek+eV5d5mjOGKqXg3hu/Kq6pVI19gc8Lj3R9S1H/HpStLPIlggVRhQ45uRzlqivqSvDmpFdLIYNUC0yyNVyuPu8XuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267300; c=relaxed/simple;
	bh=xHyTDYMIueRzo/SEG/1vuBgSGwFfMVv9GNL3h7aYAqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTxLPO/JPfmdvMTA0gotcKbAuR7nT1iJna3NxuxNogr3DDB2hRnDo89eganIWLsQmzNa5M0EELwM5jnompHSNd+TPr+t9Cj8ZiSZq7J/xrClSH2lcFxp95J1c2+7aYPjzp4KqW9OWhcndWFD9fKXLqDy8GOZClS4+rvPwvjpiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM5k2aVo; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM5k2aVo"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-47cbd444fd0so3019148b6e.2
        for <linux-block@vger.kernel.org>; Wed, 20 May 2026 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779267298; x=1779872098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ND+IuduqwCQ7jAcLo0l8S+CJjohmBHkLkrbOeAIupY=;
        b=QM5k2aVoJ9AVr3xNIz0/m8WdWDB8xQtcoYnfHwv3vzVwZf/D37RGScZmVwVnF92mRq
         ILMKP/dZvGlkw94ApQQlTSLqmzYFyKug4eo5kbgNDpevBZmPeMGvWSOcYlIbAR9xChX3
         doxZ3nTU6pKgxIEnfp9DM0t9ALtwyMkllQhkN630PwZeutdiUiaZMXRyVDkwAyoFde0I
         OhQnRX0zM/we6ivJwVZ2jtv8TqcSar5MU1hSvZeM5lvEFrTrLZ8yD6NR/TXoKVCPSraJ
         smLIcoSYGe1Y99bAyhJjtpjgTHhx0NoiyEQ8yRN9mKxUn+KTYIV8WwusUo8ocRBtq3lb
         aPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779267298; x=1779872098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ND+IuduqwCQ7jAcLo0l8S+CJjohmBHkLkrbOeAIupY=;
        b=fSe01mIdApfE+i77SZXfiYYFXuTEGcNljZy8G57nXG+zP2hZN8DrNQ7j7P84tTagfz
         QMeIuH2IrK08YAAGHYLCtvgvyM0XBmkINTWoYAoN7bEITH532SmiHwv2J3+2MAI4CWIM
         Rszrr35FtrB4YyGvtOLIFKwpwmp7N/0x3D3ZrGKqxRQZAyoVW8fr9++vOvwQ1BenL0Z5
         /IeRXDdepdR3RSPuJJPcWLpHrXVlSzSPOZExgMUh1MTFMPypP9ydC5UF+N7YjAaNbmzK
         SESKLZ3m5VIMW0yytB9BeO+pbTGdo8l91bWl+z8lSV31NOeQvoxEM6606zZmRAmhRIwK
         BIaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wtj4cdmMmunUDvzgFJj6Zlq3jkVzpB8z+ht1uNkRxw6KOIg7lyqRNcS+uK0zdHNqD3ftsvVzo7DdHsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTGBzS+poPmWKXnPlI/NllQ0PO8ZM3zD1Uhsi277FsPbf2OTa
	QDZ6dU4MgoVYG0DbnEWRZVDffMqAC7Y4bReDQgZK8065p2JqUr/Srrlc
X-Gm-Gg: Acq92OH7ikH04hbPZ0hA4jD+lC/cyEMHpZkYwUBQ7XpWs3elNmg537jsX5haK8+QhI0
	Slel+TImKbTYn5t6IUHV+GPwiKYqERU4MMxDY4wYgmecJEyra0+IhS8906DpCLcXmKuhg1mX24B
	sHgUXAmhxwQsV/EFa2lJaQurC92IXY1D1QdixQ0ixnlmLp6PScj/2D6hPIOsvlxpHkCRdF3wH55
	mjMDFtjwE5/DbUlGPZ2ZwiFFDIM0mNtQYY3yKp0ZT+bUFeOnR6YLmBiQk7fikWgoA4sMMjel6Mt
	Lvx57BzLB7kUoHtVJCt8huVla35iRy7vIRw/onAMJeguWEeFyJd6sSmUhdE8CZVRMTu7V8wRlSI
	p3w9ZTLiY282TL9O3m6mzVMcYwdpsvTnPE5m80/ktLsahMZLUrarNfeYiNErj5FoAhblJKjz/31
	UkddaB3FxHCsX5/bIL3yqFJRxCmBeN6nm6Kswj+9yE1wveC9DfuaE0bJ9EOqnyE0Vnu3Q4GzAo+
	1eFBGIyUQ+9Khm+9c/QfOIHhNsd4KA=
X-Received: by 2002:a05:6808:1b20:b0:46a:746c:2d53 with SMTP id 5614622812f47-482e55c6965mr15535056b6e.2.1779267298073;
        Wed, 20 May 2026 01:54:58 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c6b38sm11987730a34.2.2026.05.20.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:54:57 -0700 (PDT)
Date: Wed, 20 May 2026 16:54:51 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
Message-ID: <ag1223nAa0wZ8ALC@fedora>
References: <c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
 <f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
 <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
 <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
 <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
 <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>
 <ag0lS_CbKO9R5CV8@fedora>
 <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>
 <ag1nfIFcykmQHbkk@fedora>
 <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>

On Wed, May 20, 2026 at 05:20:01PM +0900, Tetsuo Handa wrote:
> On 2026/05/20 16:49, Ming Lei wrote:
> > On Wed, May 20, 2026 at 03:36:12PM +0900, Tetsuo Handa wrote:
> >> On 2026/05/20 12:06, Ming Lei wrote:
> >>> The IO after close(loop) should be from writeback. rcu/sruc isn't necessary,
> >>
> >> Gemini's comment is that drain_workqueue() is not sufficient for waiting for
> >> do_req_filebacked(REQ_OP_WRITE) requests with cmd->use_aio == true case to complete.
> > 
> > Anything cleared in __loop_clr_fd() is not used by lo_rw_aio_complete() & lo_complete_rq().
> 
> "struct inode *inode = file_inode(iocb->ki_filp);" in kiocb_end_write() from
> lo_rw_aio_do_completion() can dereference "struct file *" with refcount == 0 (UAF)
> because fput() in __loop_clr_fd() can be the last reference to that file.

OK, you are right.

It can be handled by adding sync_blockdev(lo->lo_device) in __loop_clr_fd()
because IO can be from writeback only when loop disk is closed.

Please feel free to test the following change:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..bbd15974a082 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1118,6 +1118,8 @@ static void __loop_clr_fd(struct loop_device *lo)
        struct file *filp;
        gfp_t gfp = lo->old_gfp_mask;

+       sync_blockdev(lo->lo_device);
+
        spin_lock_irq(&lo->lo_lock);
        filp = lo->lo_backing_file;
        lo->lo_backing_file = NULL;

> > 
> > So why isn't drain_workqueue() enough for cmd->use_aio?
> 
> In addition to possible UAF above, the assumption at
> https://elixir.bootlin.com/linux/v7.1-rc4/source/drivers/block/loop.c#L1134
> is currently broken due to this race problem.

That shouldn't be one issue otherwise bio based driver can't work with updating
limits.


Thanks, 
Ming
