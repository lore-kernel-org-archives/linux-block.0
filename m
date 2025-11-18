Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07240328B7F;
	Tue, 18 Nov 2025 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437078; cv=none; b=O1qemgNOHgl3eaArqS0Z5gbKs8BY5wtYwjelNDS9HNiGew/BJmdKH/+7wdLyTQNCsvpHBqb42NvJoX6VoOvcbKcVxLm6JlykiHLICSB/WUrltQSETNlkbJtcV3FUbXEmh44AvVTC9tJrkrZhn3pC4Fc8U4hzqRhDgcjBIhSyzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437078; c=relaxed/simple;
	bh=i/lx0vJt2c+Jlh+xt1q2w8s8S5CmYNxxs4saNccZCHs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rtmtilwWcSiUWnUetvZkH3QelHstdUg8y0qRp36Q3sWqnVgyX8MuPeFRbuNw6kx6yRMmXGKKVAtegLxDpvaEksJ1B1gJSxf8lY0gOjx1ppGgQSIai9A92ukhvq8bzH4At5uOJpvW6vIx0J8dryPk+mQK7/F56hHczfwu/eYti44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=SO4VBDzh; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="SO4VBDzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763437067;
	bh=Jg6yP8UZqFpmGrH6BPgJIrhTzqHKBD8D2boFONw6O+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SO4VBDzhla7WrC4oq/y3OJ6uZHv7xylGZvYPxs5hSnv20zQsD2Hwj8ZIOeLoV+8Eh
	 IDFII+hOF6rPAdxCM3mF57IBUEFy9q7Bbe2S9kFFbedX/rfIBZAbI3gBEUq+FhWpQc
	 QZCxztg66L0WgAVD2k7L9WqhHUtog3jAnYUQRTPs=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 9170F43E; Tue, 18 Nov 2025 11:36:23 +0800
X-QQ-mid: xmsmtpt1763436983t4l7ughp8
Message-ID: <tencent_900337D4388F6BEDF9525EFA974CD7669106@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ+aLrhAX6lVrKo37Ip7fZzZ4MhSBAlO0isBR0Cj2UVQIuH3JFqT
	 kARfMx6rYs1RfYE0YFbso6Q/8xTRAHRg+kHIB03VEARzzRGw5nLdTDemtlsGbwwelE1BRi6Y24jc
	 p5bel3fkuKkvtceYIo86vSqWxOz3AmZtpZKho7EcGDQNYLxneQR3tvmE/OtwUWUG3WYFGNZmWJ6C
	 tVkOzHV89mBlcLK1FmahtPHMZKML6269q+BcCkQk0ZfJTJYaoHKNCJN5X0MJAidP2/HC2ZFggM7W
	 4MMe/ktdlGakW8vAQZYessG0r2vc0NizmCV2wqJHfaWiyUnhqZeNkX/6X9hcdAAKqo9XW3ispzEd
	 8Jue6QPfF8+6it4o53toclAfyNu3nhwyYLQlnuMwG0xTawyPMbX0y7UgKBtDbSA9LuJhpAo2o1WP
	 yXEPcu7Zsh9ekO/ftrFQxMbgP+BzAEFL3OvR0VkiKULx3A3iM+7sOhJl8tzwVCuHkdA8JlF89aH1
	 hBN2oK4ORLoG/uYArl6Y2VAHKqu5iYwB00j83V0+y92PNiRqhfC4DUhZt0AT0w7Q0tY+VOZ5VdDv
	 9dzlRVhCDdThCYV0dwsSnQKa7mvekbj/sgFb3mD0qgty9sjh4gpon5Dk0f57V6J62HbEA+CjVHd5
	 MtlLdK3VSkN/DbR5jEqcgyvpjo8UiG2ZL/ILswgrkFCJYCzCOn716CASXcY3D4ryydyr+E+CYj+z
	 sHPbKFYAEcmlD9BUKaGQD0lsPQbdfY+ov1yGPQNuJCvM0EVgIKHK+8MZCJvMTW/b78qGl9lMItp2
	 xrMBKdkD7M4w+ShreJZlWe0p4RoJ0LtodjO9VMxGiuPbHv4s+seMPkVr6IvDd5xOy+AdqZoHega8
	 9RX5B2G3NnabMWV/1KJVay9+Xd2FzvVQJGD9xy7+BUYz73HLOtriWtFTDTf3A2LpO1o4oK9Z+y2V
	 6FY4vIQmLyBjARbyB6A2A9heyJHBhtWGy9LawXqXIIXTL0S9GE8ZowdJvR6nG1FmJADlWSqHjMtz
	 ZatfNcIUNyrsbjxkqPxEPkaanYyVWo8IFSgyR1HnhL4hMCD4mxo/pCoyQRhSEFOM7zfRo1Ew==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: Re: [PATCHv3 1/4] zram: introduce writeback bio batching support
Date: Tue, 18 Nov 2025 11:36:23 +0800
X-OQ-MSGID: <20251118033623.2801211-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3nqzi2v72dsef2dte7iqe7wahrbzam33druh7klsh45zvefdm3@ab6stznzdxmh>
References: <3nqzi2v72dsef2dte7iqe7wahrbzam33druh7klsh45zvefdm3@ab6stznzdxmh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 18 Nov 2025 11:18:56 +0800, Yuwen Chen wrote:
>> +	/*
>> +	 * We release slot lock during writeback so slot can change under us:
>> +	 * slot_free() or slot_free() and zram_write_page(). In both cases
>> +	 * slot loses ZRAM_PP_SLOT flag. No concurrent post-processing can
>> +	 * set ZRAM_PP_SLOT on such slots until current post-processing
>> +	 * finishes.
>> +	 */
>> +	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
>> +		goto out;
>In this place, the index may be leaked.

To be precise, blk_idx may be leaked.

