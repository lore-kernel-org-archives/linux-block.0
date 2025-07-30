Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32D2E11B8;
	Wed, 30 Jul 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899880; cv=none; b=atWOCfVb71eEUBltdsOpr6YkUhuMWjHddsR4l132SQd6sHOCx4rObjQWhZzYXiAfBJud7JtgTOJEl1ewu1d2EIfzZljg8g/+Hpz/bOORW1PYy8r8jMHmxu/kn9EXK9Dt/x+Y2nJ/SE8N4SA/4LRlIoNfX+p1y+Bi+jK+WEEQr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899880; c=relaxed/simple;
	bh=SVUxG3//hb8UHCN4I07aWYSwn9hZOjdtL6QSHDR6zPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O09+7qMWzSzPqAsPjicYd/Sll6yWpESe3jmfWrikIJLwY8XizTREuvInqpgBXCcIdai7I2gWYrSLgjyH4F5LsWjyIDhhIiEuvMuw2I09HwKkZPd30ZbSy0bCZJy/cuIy3MGG2nO2dGxaZXxyAFeh5a1CGvOeepIm829FVJ6Gquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nngbOdBK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nngbOdBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AE0C4CEE3;
	Wed, 30 Jul 2025 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753899879;
	bh=SVUxG3//hb8UHCN4I07aWYSwn9hZOjdtL6QSHDR6zPY=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nngbOdBK2tjDPEFgPZ/O1weK+wX3umrBzl8GCxIBK7YylSWZbPFK6k8ZOqfrAdYBs
	 8BxUHD7HLShfev60lp1Qx9/dKds26qJ52oIaGEfR7ISYUC0+Wsv9apqCQT1Yjv3x+H
	 oK0G6xHAYhNKNoC9egQtkp7slBL1aPILZ5aKW46uyUUOnTjOezopWMfI+WGj/67KhD
	 IT56N4TDwp/Hv4G4Rzw2ZQonQDS7WdwUxAu0veoQEk5JmOtpKy78dYtrIuv00kgzmQ
	 634yfe72DThGAwDaf1Yus7Os+oj7jJzXGxFN1yS69IJw/R68gVyjxDD0FhE6edy5Dg
	 H53VopF/UT5WQ==
Message-ID: <223acbc1-60d4-4687-8eea-5306aa44ae24@kernel.org>
Date: Thu, 31 Jul 2025 02:24:32 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH v2 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, yang.yang@vivo.com,
 dlemoal@kernel.org, ming.lei@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, Omar Sandoval <osandov@fb.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
 <20250729031906.3615228-2-yukuai1@huaweicloud.com>
 <ozjsdoiqa2uem65qqj4fjbrwm6toxlj5bzv7f5dg5xfiljv3zi@wcaamboo2r6h>
 <8edcdef6-8749-aa45-e7d2-ada677645d76@huaweicloud.com>
 <jr54uomodnzqyw4bu4hcdpllgafkhueyygiiempuudwjy3vir5@d7lv3jsxxqx2>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <jr54uomodnzqyw4bu4hcdpllgafkhueyygiiempuudwjy3vir5@d7lv3jsxxqx2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

hi, Jan!

在 2025/7/30 21:03, Jan Kara 写道:
> I think having two APIs will be even more confusing than the current state.
> But as I wrote I think you can have API to specify shallow depth in total
> size and in sbitmap_queue_get_shallow() do:
>
> shallow_per_word = (shallow_depth << sb->shift) / sb->depth;
> rounding_index = shallow_depth - shallow_per_word * sb->depth;
>
> and allow depth shallow_per_word + 1 if current index < rounding_index and
> exactly shallow_per_word if current index >= rounding_index. This will
> still evenly distribute shallow depth among words and I don't think the
> additional overhead of the several arithmetic operations will be visible.
Yes, you're right, I did not get your idea before. Thanks for the 
explanation
and the suggestion :） Will follow this idea in the next version.

Thanks

