Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F221B9F5
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432302; cv=none; b=lEkBpBhMRabLPKvi8g0JO+/9dJt1Vt63NBvkEtGD62MqOmCwlyKw7ZWgWCdS0sI58O7zUbxCZlxZJUS7uQp5W4QdvgqEYCKiBnlT19sXp1Wf63fj6txV96Pey+aMUvGU6GJMimupz7fMNHSPHM8iRzAIjcBVzAdGe4cIJpt0Tdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432302; c=relaxed/simple;
	bh=6oPnpgrKG8UiMHh/FzSLJ2xzUVT86Yhro7PkrcRBTnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=LVyeS5px60kCTOfVN2sn5rrnpENVFVj5vA45R6r1c1jVQk+aPW68BlES0LBL2j0hG1gP6536pH/W3bsfktcbXZ8HfaA1DsIsgbF2sscUgAbuii+cSsDo+wYDBg9D6iPjYJAr5XmKmpdfAY4nWz9A/y9AR/dx6CC2pbIrPU5pDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hHPDjJQW; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hHPDjJQW"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251014085817epoutp024224afcc49810040b1412e0b53a62328~uT9kGE-nd0423704237epoutp02R
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 08:58:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251014085817epoutp024224afcc49810040b1412e0b53a62328~uT9kGE-nd0423704237epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760432297;
	bh=PsLQpFRzivs5D19kZtchId/dRRY+s/ejkx6URIvSCWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHPDjJQW2FQB7d3ibwWPAXScqaIUwXkHLzCaKpFwAfBVEOkqz0m8VXBzgQxJZUDtR
	 yJvOUzn2LRJmBdcNUjml16iritBg0EIrLDvlBD6hU8+/bWTmWFjdayKKqXRvxoVl+l
	 Zh1DGqBwtW+BwD9zLD8q0GVWqWWB9FLUlnJQIFvQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251014085817epcas5p3f81037cdad34db97959b19d5ff5c6aa4~uT9j3Nk9W1998119981epcas5p3R;
	Tue, 14 Oct 2025 08:58:17 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cm7RD4N5Dz6B9m6; Tue, 14 Oct
	2025 08:58:16 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251014083611epcas5p1c198e2ad844eb0ac08f0a9cafdeedb46~uTqRF8TUH1959419594epcas5p1W;
	Tue, 14 Oct 2025 08:36:11 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251014083610epsmtip1c571f196f52a7699afe671caa1718c9c~uTqQRqfvh0838708387epsmtip1f;
	Tue, 14 Oct 2025 08:36:10 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai1@huaweicloud.com
Cc: akpm@linux-foundation.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xue01.he@samsung.com, yukuai3@huawei.com
Subject: Re:[PATCH v4] block: plug attempts to batch allocate tags multiple
 times
Date: Tue, 14 Oct 2025 08:31:44 +0000
Message-Id: <20251014083144.5479-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <979713cc-b2f6-00fa-7021-17d0e74a6913@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014083611epcas5p1c198e2ad844eb0ac08f0a9cafdeedb46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014083611epcas5p1c198e2ad844eb0ac08f0a9cafdeedb46
References: <979713cc-b2f6-00fa-7021-17d0e74a6913@huaweicloud.com>
	<CGME20251014083611epcas5p1c198e2ad844eb0ac08f0a9cafdeedb46@epcas5p1.samsung.com>

Hi Yu Kuai,

On 2025/10/14 15:28, Yu Kuai wrote:
>On 2025/10/10 14:35, Xue He wrote:
>>   static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
>>   					     int index,
>>   					     unsigned int shallow_depth)
>> @@ -534,26 +560,22 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
>>   		unsigned int map_depth = __map_depth(sb, index);
>>   		unsigned long val;
>>   
>> -		sbitmap_deferred_clear(map, 0, 0, 0);
>> -		val = READ_ONCE(map->word);
>> -		if (val == (1UL << (map_depth - 1)) - 1)
>> +		nr = sbitmap_find_bits_in_word(map, 0, 0, 0, &val, nr_tags, map_depth);
>> +		if (nr == -1UL)
>>   			goto next;
>>   
>> -		nr = find_first_zero_bit(&val, map_depth);
>> -		if (nr + nr_tags <= map_depth) {
>> -			atomic_long_t *ptr = (atomic_long_t *) &map->word;
>> -
>> -			get_mask = ((1UL << nr_tags) - 1) << nr;
>> -			while (!atomic_long_try_cmpxchg(ptr, &val,
>> -							  get_mask | val))
>> -				;
>> -			get_mask = (get_mask & ~val) >> nr;
>> -			if (get_mask) {
>> -				*offset = nr + (index << sb->shift);
>> -				update_alloc_hint_after_get(sb, depth, hint,
>> -							*offset + nr_tags - 1);
>> -				return get_mask;
>> -			}
>> +		atomic_long_t *ptr = (atomic_long_t *) &map->word;
>> +
>> +		get_mask = ((1UL << nr_tags) - 1) << nr;
>> +		while (!atomic_long_try_cmpxchg(ptr, &val,
>> +						  get_mask | val))
>> +			;
>> +		get_mask = (get_mask & ~val) >> nr;
>> +		if (get_mask) {
>> +			*offset = nr + (index << sb->shift);
>> +			update_alloc_hint_after_get(sb, depth, hint,
>> +						*offset + nr_tags - 1);
>> +			return get_mask;
>
>I feel it's better to fold in above into the helper and return get_mask
>directly.
Hi Yukuai, sorry I'm not sure that my understanding is correct, does it
mean modifying it in a way similar to the following? If so, I will repackage
the patch accordingly.

static unsigned long sbitmap_find_bits_in_word(unsigned long index, 
					struct sbitmap *sb, unsigned int *offset,
					unsigned int hint, unsigned int depth, int nr_tags)
{
	unsigned long val, nr, get_mask;
	struct sbitmap_word *map = &sb->map[index];
	unsigned int map_depth = __map_depth(sb, index);

	while (1) {
		val = READ_ONCE(map->word);
		if (val == (1UL << (map_depth - 1)) - 1) {
			if (!sbitmap_deferred_clear(map, 0, 0, 0))
				return 0;
			continue;
		}

		nr = find_first_zero_bit(&val, map_depth);
		if (nr != map_depth)
			break;

		if (!sbitmap_deferred_clear(map, 0, 0, 0))
			return 0;
	};

	atomic_long_t *ptr = (atomic_long_t *) &map->word;
	
	get_mask = ((1UL << nr_tags) - 1) << nr;
	while (!atomic_long_try_cmpxchg(ptr, &val,
					  get_mask | val))
		;
	get_mask = (get_mask & ~val) >> nr;
	if (get_mask){
		*offset = nr + (index << sb->shift);
		update_alloc_hint_after_get(sb, depth, hint,
					*offset + nr_tags - 1);
	}
	return get_mask;
}

and upper like

unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
						unsigned int *offset)
{
	struct sbitmap *sb = &sbq->sb;
	unsigned int hint, depth;
	unsigned long get_mask, index;
	int i;

	if (unlikely(sb->round_robin))
		return 0;

	depth = READ_ONCE(sb->depth);
	hint = update_alloc_hint_before_get(sb, depth);

	index = SB_NR_TO_INDEX(sb, hint);

	for (i = 0; i < sb->map_nr; i++) {
		get_mask = sbitmap_find_bits_in_word(index, sb, offset, hint,
							depth, nr_tags);
		if (get_mask) {
			return get_mask;
		}

		/* Jump to next index. */
		if (++index >= sb->map_nr)
			index = 0;
	}

	return 0;
}

Am I missing something? 

Thanks,
Xue
>
>BTW, the sbitmap and blk-mq changes are not quite related, and you can
>split them into seperate patches.
>
>Thanks,
>Kuai
>
>>   		}
>>   next:
>>   		/* Jump to next index. */
>> 
