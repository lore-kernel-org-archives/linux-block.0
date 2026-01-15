Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876D8F4A
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768446834; cv=none; b=U6bbwAhOlTXhPU02xuEVW4/juXUpkMvF95XKiweZ984vhOqnFC+3XvFpZQUuUtiOn9/a/7Kx+8bL/eNcw/mTv3TY4VzF1hvO509pfPMtEpM5EgwNnDCc+McSEqEy2eZEWBKMzWjt4VcljFcCFbO01nCw+yISz6xS1Phe2sEKH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768446834; c=relaxed/simple;
	bh=CVGxq+65zjKHrQqhxY3GRJQu57gVDWDKQMEuzPtG85c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSpdG+Vb8K0VTkhSPcw+KSpyaA4bzRI8M4hr92jznNX1382scOaAX5tNJvx4xGAnQGDqXC8blNWY3NfwdvHz3W67sdH9dSm4IWuKoqQSHP+3ATaSMLaZy5eFk1qQFvbYfAWv6x2mSlLPuNinsSH4RYD5lKUxHAizCJXxY0WeA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LPTONG+Q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPTONG+Q"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0ac29fca1so3233245ad.2
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 19:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768446832; x=1769051632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jw+mUY3hA7BYhlUNwtrUxUYy8CLTFaUlLtDD3kSUDM=;
        b=LPTONG+QT4X3sNxRYKSdneAgx0HZ7VsD6iLVLy9HaKJvhDE39kNyESVvKAucXuVZU3
         JdzAduOE8VjGpERt5/tu0JfPAZ9pLnfXqOavPuqhffYr2Y6w2UhK3RFLz1CvrVMj+3KE
         XrWw4+7RSMFAzmtuPueQlIf6Bag28TDSMNkSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768446832; x=1769051632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Jw+mUY3hA7BYhlUNwtrUxUYy8CLTFaUlLtDD3kSUDM=;
        b=dYiQZgp6fsWHsha4mpFkmU42OyOH70htt+adUY1x6u4NkHMNeiZ3yxXWZpdBtpJBgR
         6hH+IezY/esEN6tf+kZacvqGEdo2pdlkqsy2ilOluE+wvNzXlX8OZ4V1+y2Mr5toCF5J
         u1DHPubFbjjIcihbSPbVlLDeNYEA2HUF4N/uws4w7CMp2Q1RiAT309kZewf0pc5KJzhI
         CLgY3084YxJjpv1B/+q4W68UJfcUNFi8iGk9PHjOpAw8P96olQ8Df5JuM1Arn11g7Of4
         pLI8zV544AuScxgJBmbdvGgNxTRERXXncmk2vGzTv0bSScJGDT1Juh0IvjptM3iGYhQu
         Jbqw==
X-Forwarded-Encrypted: i=1; AJvYcCUUD84zQdlDcDBQPpz+1M+s4RSxs455XcjdrC1iT+pzGL9z8ZcvXbomW2ppZJm1paHkdI+WsyQvsAWBXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mCGMe5wgcl9rPkAi3VBOoqSJg9/su/dDD8npPOOq0CMOKWWC
	dpYtwB6Ncwgvb4Uq0OR8BToVSO9zUZpEOzVTJTwS4PFzMl1Fgs/Q9s6wTEqUBfJVOw==
X-Gm-Gg: AY/fxX5ow1czf/XyyxeLQWDInrJjJHZmb8qvbbU8R66QBIOcVxxhbBFdQDfrMFIISU/
	i8s6DpM/yy3vM7O4tjUcEUd3vprq+aVw4jBDG88Fxmsc1wVzm3uaGhpKiPXHmXruxacLfBOdBxn
	QvEfbXn6FIYiC2XmO40UxpZavkL37GqkhiQZT6T0okCck8BC1f1eT8JqwuqMG1xhxlDdPWp29Ia
	oMdlxJNrkTJ384v4z813F2JJ2BcetYQRXqGyIqS5UKRW0O/NoG2HayDHlchpgpb5oRLRJoIY1pP
	abwptP3qeM7JmoFMY2k9wNvbwtXbjpfn/mBElnu4tHHCHdAHoRgr24+IYWKScqqPzZmAVHDivZy
	heao90AnsEitZmmNASwyXuU+9bmHxjTTGsLFdFhartXHJTZiBJhS5lOcqOD1SH4iYCuEd+/xguh
	2NbtgM1T3Tpbjr6MT/p1SLojbJYAAe8cbqn3QDVuUSH0zAM79hvBQ=
X-Received: by 2002:a17:903:41c2:b0:2a0:de4f:c99 with SMTP id d9443c01a7336-2a599ded072mr37132945ad.9.1768446832370;
        Wed, 14 Jan 2026 19:13:52 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:36c2:991a:5236:1fe5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c5ce06sm235752335ad.44.2026.01.14.19.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 19:13:51 -0800 (PST)
Date: Thu, 15 Jan 2026 12:13:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chris Mason <clm@meta.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, David Stevens <stevensd@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] zram: use u32 for entry ac_time tracking
Message-ID: <5dm7qshgxenr6urnd4mdis75r6zpk2rlzcey4svjsp6m4jvnqw@iq4myzyiwm6u>
References: <d7c0b48450c70eeb5fd8acd6ecd23593f30dbf1f.1765775954.git.senozhatsky@chromium.org>
 <20260114124522.1326519-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114124522.1326519-1-clm@meta.com>

On (26/01/14 04:45), Chris Mason wrote:
> > @@ -1588,7 +1588,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
> >  		if (!zram_allocated(zram, index))
> >  			goto next;
> >
> > -		ts = ktime_to_timespec64(zram->table[index].ac_time);
> > +		ts = ktime_to_timespec64(zram->table[index].attr.ac_time);
> >  		copied = snprintf(kbuf + written, count,
> >  			"%12zd %12lld.%06lu %c%c%c%c%c%c\n",
> >  			index, (s64)ts.tv_sec,
> >  			ts.tv_nsec / NSEC_PER_USEC,
> 
> ktime_to_timespec64() is defined as ns_to_timespec64(), which expects
> nanoseconds.  Since ac_time now stores seconds, will this produce
> incorrect output?
> 
> For example, if ac_time is 3600 (representing 1 hour of uptime),
> ns_to_timespec64(3600) would compute ts.tv_sec = 3600 / 1000000000 = 0
> and ts.tv_nsec = 3600, resulting in "0.000003" instead of "3600.000000".

Good catch.

I think it simply should be like this now (I don't think anyone uses
this function tho):

---
 drivers/block/zram/zram_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cc51aa8b6181..912711faa4e4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1579,11 +1579,9 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		if (!slot_allocated(zram, index))
 			goto next;
 
-		ts = ktime_to_timespec64(zram->table[index].attr.ac_time);
 		copied = snprintf(kbuf + written, count,
-			"%12zd %12lld.%06lu %c%c%c%c%c%c\n",
-			index, (s64)ts.tv_sec,
-			ts.tv_nsec / NSEC_PER_USEC,
+			"%12zd %12u.%06lu %c%c%c%c%c%c\n",
+			index, zram->table[index].attr.ac_time, 0,
 			test_slot_flag(zram, index, ZRAM_SAME) ? 's' : '.',
 			test_slot_flag(zram, index, ZRAM_WB) ? 'w' : '.',
 			test_slot_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
-- 
2.52.0.457.g6b5491de43-goog

