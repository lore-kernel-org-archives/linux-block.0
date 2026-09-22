Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC42549376
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085284; cv=none; b=MSJZHNdq0SfuX8dmcl3Lw1XrbWifesCiDYPLSCwEjlTDrv350FvZ3bDts6DxalrOR+y7FVAk/dTc6NOWJw5RD63LGTi2BpcanSy7E4wy77NoUVm7PRmJ/I16F5AfNSmm/qsWODhnbzvhQLUykQkSTbEPdoM27VL6Y4yVI1/V+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085284; c=relaxed/simple;
	bh=of1kRO6ILjWAgj4iFFg39n1f9ag2O5+deE7KCawy++g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9Q8wpo74xL9rbFEsbI7Oa91X1ukaoPMKPwwoIy6a+7CrQU7I6p+ok3qBhssitnDJP7Ew6ByzNes/tvC7/mBmoLLl2snwL8i30AsCeL1uReR7w6a7cwqX+mrRk1YIDubM+9+1vFlbZSE+LbJyxPsmneIvN2Mehn75kc9WTcQvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbWDwiAg; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbWDwiAg"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so615492866b.0
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790085280; x=1790690080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufPZGPSZBLf6/pwvKrChnuajCoyQv+QtMvUQGkdovhk=;
        b=JbWDwiAgvuWT6Uu42JjZYnRml38hEKzTCJ6Q9fYTgb9qCSitbHdSQyR0+2K5JnqsWK
         lC6m13cAB5KIQu2DdJNmT6TELiaso3Rnm0Py4f/MZ4m0xAhgaSQMFPfRjenPHTxyEB00
         813UI4lAirAeDf2dit0LlDoI52HKmdGR6bDAiF9XXtzZVUtiTRG2hJGYySOo7kE9MI1q
         nmQ+XVAVp9IFiilUPlvhMkBTHJ51+C0PtnzBuZmG3D7cnuyd3XYJsmR71f59Vm+RenZ6
         Td5j8LVipadxst801DvaEnxsSSZdE6wa31YaEL0ph/skpusJElsrFnI+nXqbskIVLZKL
         KSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085280; x=1790690080;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ufPZGPSZBLf6/pwvKrChnuajCoyQv+QtMvUQGkdovhk=;
        b=h4MhAE0xUJQxwFF7fPkm7Au9LtlbB7bdMF+5s57FtKRXxaQM9BuiPf+icsU3mCcKk5
         CunLS2VKyEXDUo4DygIXzSgt5WITWg2nn7Zqhnua4v5koNVxtz4EszIVVKKF3rRpBBaO
         7uyxvtTqVzVElDtiNy6Tu/vGcYDM+ntgkGC/iJ2AWBK0co4Sgp7vh+xYsZ6jo6gQnTN5
         df+UdM6GQ6sCsW845DbARsCVypKiKfOaVNMc0/76kFwmXsHccCrN7y40mQtDYuayTVhQ
         GuhuuCskZapFajj40ZtHayJctRYXDTjZrzG5lq0ib1v9rLzDTNPuHprNvhiHQo5z6KBj
         1LYw==
X-Gm-Message-State: AFuF++mvIY7+FhuSz1enJ31KyhNf+N/Rxd6z5BYmuK5kbVNkpO26nLfk
	I995Wkpp2DIQlvMDrJifKZoc70Sx6Tz8d/eC0Q9FosACMsBbZE4Wcls2
X-Gm-Gg: AYBFou3wXm0fY1uHOTTgH8R0B0VSP+dhTmLKArx9hlkc7HlZ91vhXufKG5p360q5ny6
	V5jTpCNmsKpwfknDeezkJXQ/XAtStorKEuxFuOdu5bL+yIdsXXPyQVziRGsVtUx8HSYHHvmk0Gq
	ZyaDDHofYhRAFwjMdGjk47q/hXncwdQm0rierrI9Zb2O3MYd8ndJ9FInMWFShUb/vM/ScLkSUNx
	EZ1SlwG1PNSCeP5hXXNmV5ni4PR3Y0E79WihWaLq1au9IKLdDPOm/3iroxmzW1AhrIljKYKXreE
	S5CQ9x2KA3htB0WjN+u37ztuLVTCPeEy9KibLlS/B5PB+DYmnhwmt1DWi/u+iXiifDC3OVOMHsQ
	FdgNm7f3MRSNSkfIikOWJOYg8HrS8Fk9mgELq1fxOJfXy1L9PdlyJ8cRSj6qhwUTf9xkEqFrz/L
	vYHDFAxLNeJpo7bKKm02Q0OARE/WbewTpwvJgC/oljOZS+npyX7AAEmtFVcjpdV4MtOKs0PYt7Y
	CRjb2gVboys1w4fUbYpZFfFoNyMxyhWqKSU6m/kmp9ZcJtEb+nPIPl0tjSn0JZIPSpGoxtyU33x
	gKWBJPm32nqDSdvZdTBk0tOznC9p
X-Received: by 2002:a17:906:c111:b0:c29:f5d8:9c6d with SMTP id a640c23a62f3a-c2a15802eb7mr1217098966b.28.1790085280498;
        Tue, 22 Sep 2026 06:54:40 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-197.dab.02.net. [82.132.213.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c5baa1bsm93202166b.39.2026.09.22.06.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:54:39 -0700 (PDT)
Message-ID: <cce62c72-278a-44d1-9cf7-e0beb0b72688@gmail.com>
Date: Tue, 22 Sep 2026 14:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/13] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <a3ee719abc440ca139f1a945fdaf43a45f0c6b57.1789997898.git.asml.silence@gmail.com>
 <20260922131610.GA30468@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260922131610.GA30468@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 14:16, Christoph Hellwig wrote:
> On Mon, Sep 21, 2026 at 02:38:48PM +0100, Pavel Begunkov wrote:
>> Premapped buffers don't require a generic bio_vec since these have
>> already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf
> 
> s/strore/store/
> 
> Can you please expland on the splitting considerations a bit?  Preferably
> both in a comment for the details, and in the commit log for how we
> arrived at them and why they are fine for now?

I'll add something to the commit log, but not sure which specific
details in comments you mean. Do you want me to expand the comment
above limiting the number of segments? Maybe I should add there that
it's stricter than necessary and might cause more splitting than
necessary? This one:

/*
  * Limit by the number of segments. We don't expose the underlying
  * mapping layout, but with a known minimum segment size, any I/O
  * consisting of N full segments should be able to cover at least
  * this much.
  */

-- 
Pavel Begunkov

