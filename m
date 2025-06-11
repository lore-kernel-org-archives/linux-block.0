Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB9283CBE
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646620; cv=none; b=f8oU8EvJol46vOfdtc6nFXNQiy/8ZIT7I9dbJH1cIfjyol0IYo13bV471cR06r768Z/f8z9qBcBbAfqcenAoxN0JYD8OWUB548nhn04prF+3gNmZdSdqTetpeZlEC6I8yq2tu6D2n1W2AXpuNJX0cW7Nrz8NuKCzB+y3ze2xqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646620; c=relaxed/simple;
	bh=WFBUbKMMnKHZdjkqyPfepwRYRaY3PMbvKPZrZUg2BWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VE8LcOzFaaQISFiK0iM7IloNM4ncV2WY78cQd9kmWJQxjQayE/RkZHUceZi22XN+Mrow0VnICZUcd8iUiIN4p1eRiNpIb1hIVHosfSEgwHZSEW3VDOoaLtOjZuU4g1cSnq0JCMBv2ytS/N0uRnyvB8kbg9HYQp4WujnzEOAHi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3SNeEW8J; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3SNeEW8J"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ddeaad6036so20371325ab.3
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749646617; x=1750251417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=3SNeEW8JE6h/oz8q6m6QF2ImTL+tlmycebGzUU801zIFrCEDkbol5VveffiMdaCcVr
         DR4DtdLs0b+1vL/7V92uya5ywuKnyqGYVSg0ovhGxi0LJoY7dxjooMAxjnoIBEzQXMr+
         qMeCgAww9N0HEgBHk0ug5O3IF+BFEyTe1ylZYv+Y826rZiB61Q2HaxeJnbGKLVKmd7gE
         Aeg10w+4veLhgu4Nb+O8L6MkAU1TZQkC7AhlyIGuZtpexzE1kEY4l5aPG9Hz/W2teHnY
         49kehI159q8ArkYpHFN9doyq3ao1juv/h8HlhUTH3p4/xVB/T2oRSBlwS1sUivjQy8Bs
         7uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646617; x=1750251417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=MQzCM2hPtWnNdizNYLU98mPosTFXvEmhhJkdejPJkUUaAGO1ArtDndI4tGE0Qs4/o9
         1rK20NuI4qBu3UGgIKwP5Q5W/924ibI9pRLHUOh1/g+V4UAzVCztUCIF+r8IqYNJy2Vy
         XrkfdBleND/+fTl9mxNc9da75Nlqa1gbWjW+dY6iIR2ghQx/OgBItfZxEF6klYgon+9t
         NJiKhZCR4hQxSuzWmlDkgtaPFJVr9ND6pWdS0lNEvLLs7tw7lZNXThWcDK/kpr2wQOTY
         ncmUwbYdblkA3pfWxPbDdPbZ9hHkD33bPgqDQiP2/V7EYDjk0L6FTaCLHEdpxlI7qLlD
         OHxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUscOl3abaQKqHwGmXtWyX3IbNgOEwsci1ehhvbzUTOUk08qxVE99YJtC4ErReWeRTDH+356cJdP0aSWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGEXlZ5Tn51hUl3gmbJEz+XRSub0GjJGqqOxn7ICXlFrBTLH/C
	QyY7inWVMQ3+x3EdR6ugln/O/6D4EFycB8enQerFvEkEDjSWbwFKu8OQIWqJ7MWG1/g=
X-Gm-Gg: ASbGncs93rOcqsllu8p7mRcdZOQYLGjtG1cpNfpBKIrcTgDOIGDvNQkqJ0OSlmtDAz+
	sWexf9kM2/yBqdXUmJwNAb9rqwUJMz+QwBXzG91lzznuy9ejZraTuLip6tES02GMSLUqxFkzVOP
	CJbXc+RttwvQoy6LuOJJyJQw1dfAeaqIvhzEwMCsMl45hTGl7x8jMUM6AvNseqgFgxPBZS0LgS2
	4yfM/Pop1tgCRzNH1BpoUT3aYVG8fBHqgb4oZwiYVWl3RtD6gNXD79/vp4hszE1SdQNBYnZmeKv
	amy9c3xBtDfS+4twsD9orslns6WoHxf8mEGlcFhwCTJrIS+fwM5dPQV8HM6oEVuLcr9qQw==
X-Google-Smtp-Source: AGHT+IERz9UEhN3gPoO6s9ZO+TGganlwoJirBS1zd34gle1XGHdmdK7NOLrIX/f0q//+H5iwkCSLYQ==
X-Received: by 2002:a05:6e02:12e8:b0:3d9:668c:a702 with SMTP id e9e14a558f8ab-3ddf4d5d68emr25015895ab.9.1749646617386;
        Wed, 11 Jun 2025 05:56:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddf4768c0dsm3851505ab.55.2025.06.11.05.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:56:56 -0700 (PDT)
Message-ID: <ed33ffb7-31bf-490c-b1ae-304a6e4b9a0f@kernel.dk>
Date: Wed, 11 Jun 2025 06:56:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 6:14 AM, Hazem Mohamed Abuelfotoh wrote:
> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
> 
> Commit <e70c301faece> ("block: don't reorder requests in
> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
> list, this had significant impact on bio merging with requests exist on
> the plug list. This impact has been reported in [1] and could easily be
> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
> having any filesystem on the disk.

Rather than revert this commit, why not just attempt a tail merge?
Something ala this, totally untested.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3af1d284add5..708ded67d52a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -998,6 +998,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	if (!plug || rq_list_empty(&plug->mq_list))
 		return false;
 
+	rq = plug->mq_list.tail;
+	if (rq->q == q)
+		return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK;
+
 	rq_list_for_each(&plug->mq_list, rq) {
 		if (rq->q == q) {
 			if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==

-- 
Jens Axboe
