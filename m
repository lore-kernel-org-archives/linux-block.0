Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52258946F
	for <linux-block@vger.kernel.org>; Sun, 19 May 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716095144; cv=none; b=iMHs2ejCqo0c1/YFAIgLuiVwFerQjOgHo6kDXI28+SnEj0xJRT+EoV6dPhz9kPy1lIAiy0xYz2Zr8OmEoyWSyKrW6RzE2KHhE/QWqoiXuMBPdpcnqiWry5BUysilVgdpM+CFpa1xyBPcW5+kmeWwAd5ZN33lA4xoCn5XKOJJLuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716095144; c=relaxed/simple;
	bh=luobphtaggRTIHX34O6jyVWEXnFxOjMsxGKaQRu+p7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWHedUEOML9j1UiDFCtUTcOT1yN7PR3WVYrN5fteim9RXokFuLV/BbIIbXw6JqDzmiWJO56/cGDvumeb0Ic25GOS4h/pPerFZOr2UmmC5IKnofkCxVWayX74plVZesgdq2h2NPQMAcDcZZZQrdtIE4WzDxj5biZRo1iyoNnSR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43ddbdf2439so14535341cf.0
        for <linux-block@vger.kernel.org>; Sat, 18 May 2024 22:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716095142; x=1716699942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0vRva3h81x8N2Kbd4V8azo7Ww7WsqKpR54YqM9Pj9o=;
        b=QiRvpzpt2lUWB1fshUn5kSoKYQrHc3w+70F22vy+mDLFfZpiaPgoYNBaaIhpgKpgMW
         W8YSiYArwHawIwmc/Gzw3Md/flh84bvv+DyktMzIw+WeJd1jEsjhaEXrRFnf9L+xkNbt
         XebnLopsHL2RspcaBIO5O5W5XJcsc7o9oMOEWnOFhA4s1dLTm4Ud5P+4uNgbpJb5SbQb
         FEG0qFGjIHGJo9wJc1CH+aA6uw6Rda+UU+Hvwo84KjPz+WP2fQ1X4vdwa1AFYmhM18v5
         X5Meg2EYrwkRu2I1Tz/6V/aYu+CUAjx4m0MXMnTPqAL+9ZKeMgvzekHcyFwbbGu1/C94
         WxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwvmZ395JQHHOOC+oK0oIj4BwfYYsNXRzPp9ZBGbiKk/57oUZlq75zosQLjbsiCoLpY56dxy0PwVFJDK9m4Fow4Ed+vC0YZYF9lLM=
X-Gm-Message-State: AOJu0YxUA27/H3lsTbsnR2JeIyZtOgZvF3AH1ysbYUc4TXngzJcXeHE1
	f0kgzzqSX2wkSObPog6tVKDvrSe8NdMp2yJ1uO0sQj2LEHs02G1jvyckyCASN/s=
X-Google-Smtp-Source: AGHT+IH4+X4dYat+1w6SQ8pKv9TOYZD2hGahJqFKm/DkjBIlpUwIF256nHrcgELwcfTSVg9kuxO9dQ==
X-Received: by 2002:ac8:5954:0:b0:43a:c483:9fc3 with SMTP id d75a77b69052e-43dfdb299c0mr303159331cf.26.1716095142237;
        Sat, 18 May 2024 22:05:42 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e217a6fd9sm80501131cf.42.2024.05.18.22.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 22:05:41 -0700 (PDT)
Date: Sun, 19 May 2024 01:05:40 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: dm-devel@lists.linux.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <ZkmIpCRaZE0237OH@kernel.org>
References: <20240518022646.GA450709@mit.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518022646.GA450709@mit.edu>

Hi Ted,

On Fri, May 17, 2024 at 10:26:46PM -0400, Theodore Ts'o wrote:
> #regzbot introduced: 1c0e720228ad
> 
> While doing final regression testing before sending a pull request for
> the ext4 tree, I found a regression which was triggered by generic/347
> and generic/405 on on multiple fstests configurations, including
> both ext4/4k and xfs/4k.
> 
> It bisects cleanly to commit 1c0e720228ad ("dm: use
> queue_limits_set"), and the resulting WARNING is attached below.  This
> stack trace can be seen for both generic/347 and generic/405.  And if
> I revert this commit on top of linux-next, the failure goes away, so
> it pretty clearly root causes to 1c0e720228ad.
> 
> For now, I'll add generic/347 and generic/405 to my global exclude
> file, but maybe we should consider reverting the commit if it can't be
> fixed quickly?

Commit 1c0e720228ad is a red herring, it switches DM over to using
queue_limits_set() which I now see is clearly disregarding DM's desire
to disable discards (in blk_validate_limits).

It looks like the combo of commit d690cb8ae14bd ("block: add an API to
atomically update queue limits") and 4f563a64732da ("block: add a
max_user_discard_sectors queue limit") needs fixing.

This being one potential fix from code inspection I've done to this
point, please see if it resolves your fstests failures (but I haven't
actually looked at those fstests yet _and_ I still need to review
commits d690cb8ae14bd and 4f563a64732da further -- will do on Monday,
sorry for the trouble):

diff --git a/block/blk-settings.c b/block/blk-settings.c
index cdbaef159c4b..c442f7ec3a6b 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -165,11 +165,13 @@ static int blk_validate_limits(struct queue_limits *lim)
 	lim->max_discard_sectors =
 		min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
 
-	if (!lim->max_discard_segments)
-		lim->max_discard_segments = 1;
+	if (lim->max_discard_sectors) {
+		if (!lim->max_discard_segments)
+			lim->max_discard_segments = 1;
 
-	if (lim->discard_granularity < lim->physical_block_size)
-		lim->discard_granularity = lim->physical_block_size;
+		if (lim->discard_granularity < lim->physical_block_size)
+			lim->discard_granularity = lim->physical_block_size;
+	}
 
 	/*
 	 * By default there is no limit on the segment boundary alignment,
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 88114719fe18..e647e1bcd50c 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1969,6 +1969,7 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, q);
 
 	if (!dm_table_supports_discards(t)) {
+		limits->max_user_discard_sectors = 0;
 		limits->max_hw_discard_sectors = 0;
 		limits->discard_granularity = 0;
 		limits->discard_alignment = 0;
