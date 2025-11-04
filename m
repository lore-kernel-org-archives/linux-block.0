Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94A1A9F83
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268757; cv=none; b=hD/T4HqWjrocZSQccFQ5XF2ImmjkgstnQg022sGMaRedbeCRgVcMxz6hDFSDKeNTOC5TmW3M3awvWqJLIrjQxWnYPS4iRlRDg7anmlABtvRxuh+beo9djct3KUuMlNRaVWxDvmTHSsD7tcYkcoGSz1Bp/uB219SgeA0JiN24ITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268757; c=relaxed/simple;
	bh=Yp6fUD952UVKQWCkV+hXAOlbW0lYlppgeblWFreQc58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6kEDaMdROpN01V0K1DnPyLbYOT9utrlq/f59fXXq5dVBBdtwxA/LDIEa7lOtm1h1JuY2uZylvrXylAMsLbKkQnMp3SJva6lnmVEnpbctV/8RzFPNk7SPWftmCdoBsmuFg6GSWvYnBsWhvNE7qJeU3ODIRQGQDASipHZsVhGUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnLbi/Rs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnLbi/Rs"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2947d345949so50271165ad.3
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 07:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268754; x=1762873554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjsZzzSV6ptDEgOqNG45MMGnROqBWBrdMHjfc2PbPmo=;
        b=hnLbi/RskHJ62tG5fmddzuJQ/uUw2ykV9H6PKkLxB3zk/3YDH1Lqh7YLHLEkJNrQNq
         863EdxFMPtKI12/auV2fwyH+VoOfVXWij7zML30P6EuPh6MKhl1AONZBxUj6RPMIvwWG
         iQY6ltYvgiC8Wiu2KP8Lav6z9ic6xHemBuJ5qsRKw+i/wy7HB4F4emkGg2y9xRNTagfv
         GvpFfwYOYoRMVeop2I9At03yO8RqJjC4uLdPGZBYYolHuXx/2kNObyBDvW1w+8oDRW9n
         0ckCEPY9JuNKZqIS4PrSAKjjgiDi/WqTq0i6Tx8w7G+s4wKIhojHlcMGKDAAiW4ZKYdk
         Ak3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268754; x=1762873554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjsZzzSV6ptDEgOqNG45MMGnROqBWBrdMHjfc2PbPmo=;
        b=nRhba/3F3SIfFPQkBhIf6Wbu355ols4krkAH0jJSvJCfVa4swhsU6SHCZnZrVrCFGD
         Fg740pDtpqWFhd7xiEip7YJSXdjORP5w51St+IiQP8LpMArbwYYTR+FLDJzdSqohCVoz
         12jplp4zEZwr1rhTXcgP8dcG95MoiLvKWm2BiqKGJuv3SwXRr5+COdW1GIZydnTzXykG
         X/A3kBnI6R5IkfJ5kEfpr7dK5Zks5B+KxfLw7zBwaw51/Nx8+Z1if5yD/YCrEwFXAFhk
         QJcIxJ/s2nYMr4s2wuwyXizhF3PIx8e/Nr/P1u39HzkbscmpbPcznrSvHa3HzBTgTpSH
         S92A==
X-Forwarded-Encrypted: i=1; AJvYcCWmdhpD9uPgAsoyIkVhvkUYOebhoad6XzdbhES3u7RncFVc9p8IHMqeoJyFpg+tM2nKtFYH/bD4AsxqBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySYAxs6mSvOq3T/lGmb5OcVuM6E0CRt+4F5dVNo5qSfHnq6ORT
	YocM74n0VbyYpN/etkZ5+cK5OvkH9rwi2d9VudwZ9Gd0U+ZIGNCkJJMq
X-Gm-Gg: ASbGncs/EKvhVXaQuJ/U3A/ww2YVx1wTgDYlXPQcCMCgfOshNydTHlxZ2K6DTc8KGFD
	RUDH7VTYF5xSnMHKGNYdk6fieQY4HNg56Wg9g0S6gLiSYMQIil38dIP4dToJ5tJAdN67eW3riLM
	VmjzZHZWj7YjAHmC+7bSPZn/PBdEUomJKG1xax6EPtyJb2MTo4ShxyuzjrIqd/RE1N+LNrkBp0S
	oHb+MJk/CAJeh/vDdny9yM7ztZbjG3ITj4gjXioxH3zaYyTavyyxaPPH325WYrMRrZJqVhYpeN6
	gtFlD7A/2bnhOxcmfJ4pxAJpkYEpnYhvZJCy16xpdPkIwwoJauUb4wnVHQOB40MLZuSbO7zho5S
	AKFH6UobBgnl5wGMAoHJLM9WkM3jd3rVOOB5UWTyYqeHyGTeiICRcrs7LNhEwo0VOxIk6noqq88
	ZvaOosOPiZtrXmftQRaDhh/qtt7+asQqnaPwjWbFFemq07IP1QO62ya61qJU7aY1JhSUpPQQ==
X-Google-Smtp-Source: AGHT+IF6GMlcuTvJ/QMvT7CMF97mhy83YwPs7iC6oKLK4oKXG45cls7H4Vrjj+0VVpTVu8RpWQY3oA==
X-Received: by 2002:a17:902:d48e:b0:295:986f:6514 with SMTP id d9443c01a7336-295986f65fdmr98727215ad.9.1762268754106;
        Tue, 04 Nov 2025 07:05:54 -0800 (PST)
Received: from ?IPV6:2409:8a00:79b4:1a90:a428:f9f:5def:1227? ([2409:8a00:79b4:1a90:a428:f9f:5def:1227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019982c7sm29883325ad.25.2025.11.04.07.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 07:05:53 -0800 (PST)
Message-ID: <b8f06e62-27dc-462e-83ad-33b179daf8a2@gmail.com>
Date: Tue, 4 Nov 2025 23:05:49 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fscrypt: fix left shift underflow when
 inode->i_blkbits > PAGE_SHIFT
To: Christoph Hellwig <hch@infradead.org>, Eric Biggers <ebiggers@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-fscrypt@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20251030072956.454679-1-yangyongpeng.storage@gmail.com>
 <20251103164829.GC1735@sol> <aQnftXAg93-4FbaO@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQnftXAg93-4FbaO@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/2025 7:12 PM, Christoph Hellwig wrote:
> On Mon, Nov 03, 2025 at 08:48:29AM -0800, Eric Biggers wrote:
>>>   	*inode_ret = inode;
>>> -	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
>>> +	*lblk_num_ret = (((u64)folio->index << PAGE_SHIFT) >> inode->i_blkbits) +
> 
> This should be using folio_pos() instead of open coding the arithmetics.
> 

How about this modification: using "<< PAGE_SHIFT" instead of "* 
PAGE_SIZE" for page_offset and folio_pos?

--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -333,7 +333,7 @@ static bool bh_get_inode_and_lblk_num(const struct 
buffer_head *bh,
         inode = mapping->host;

         *inode_ret = inode;
-       *lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - 
inode->i_blkbits)) +
+       *lblk_num_ret = ((u64)folio_pos(folio) >> inode->i_blkbits) +
                         (bh_offset(bh) >> inode->i_blkbits);
         return true;
  }
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 09b581c1d878..72eeb1841bc3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1026,7 +1026,7 @@ static inline pgoff_t page_pgoff(const struct 
folio *folio,
   */
  static inline loff_t folio_pos(const struct folio *folio)
  {
-       return ((loff_t)folio->index) * PAGE_SIZE;
+       return ((loff_t)folio->index) << PAGE_SHIFT;
  }

  /*
@@ -1036,7 +1036,7 @@ static inline loff_t page_offset(struct page *page)
  {
         struct folio *folio = page_folio(page);

-       return folio_pos(folio) + folio_page_idx(folio, page) * PAGE_SIZE;
+       return folio_pos(folio) + (folio_page_idx(folio, page) << 
PAGE_SHIFT);
  }

Yongpeng,
