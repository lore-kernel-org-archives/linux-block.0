Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8E43B6C5
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832795; cv=none; b=RQEGCogRRLEuKFEkdNhY+b5j4y8kmm9qh4ix11vCyARyKpm54C5z9cUPIOozXAvxnFqTxdTjFn31PlWj6M1N6rc3RTYMkxlmeMVnPxIni3mbxjeZOGHYpOmdiFBgiA12bX5qFEzOQtJSUxPq5OtWIBZWTyOFpQS0M0AOsxrf8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832795; c=relaxed/simple;
	bh=St5xZjAvHbO5wVL5/bUSVAInpD9XhzCT+/yCzyLg26A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THuJIq20wcgC+26OqxlSIN78uLpuWD77IsMHyV3gRAi/ccfnOUqjjyfJzuocS9H/w/fTitngNfaDyqeCEdAxjleAsHLb1Fe5lfUptyd5FdlegVrOUjH2DiA3YAf5VK5GsJo68AxW2bTmJ9rdMFMivdTNey08ME/fxeaMJSjC1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8pdWUdr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8pdWUdr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceb096e675so51047125ad.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832793; x=1786437593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64eSuQSg7peuhPy9EAyTkvD08lRNBOCEScrOfZTKXsQ=;
        b=a8pdWUdreBfl/WJduFzPJ7bPNmTNSJuEk9nRl42gbzij5MSOdvsqxQDhMitbA9g/kf
         GJfFeqUQ0+XkCCA2c26hmuugpcqwH8GliFJJKiOyjNF5sARUeA2Fjohuiq2H+7FuBmHe
         Iu4WSZYHeaOB+3P4yl93/tpaMX9P28j9A+D/jJfTGdSu1B4r+KK+0YqaM9Qi6w/ISZo4
         CBmwCgAcsyRe4glJgIYJQNa6Ttmj1uUfxMjcbSAyAiYWeJd7mT+NPtVdcm0T+PZzQjBc
         S7qfH1ceFeNo6eXpLmtCbj8rlTvk0zLwQ+otuBOOrLRAirmGT+ASi3RWNOVuZEBiTU9o
         2bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832793; x=1786437593;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64eSuQSg7peuhPy9EAyTkvD08lRNBOCEScrOfZTKXsQ=;
        b=E9nFNsjWWACGz39DHIaspErUpq++nxpbbGUdzajB1fWL0TaOP3MFjFafSmdI9BQ1S8
         FhaVQoxVUBpVjBH+G4W0bl+y52fb+o/Rbqk3j2F1EPbIy1y76wQjhT022vTG/V4r+zgu
         ouvA6Wo7Luk5TVVGuPkstUqvgtVLRXzj0yBQUZTaHqlUmlh50WmvpuOeSfs7XOsduwgV
         +CRsAm0Vkh4XOBfyIokhvgsg/12pbzSvviMnLR4WEtfaIqrEbsOEd/KER2Wb/21w0/iB
         +Zi30Q+LBg7auhxfhxBc2HXswgeK4hYhbveK9/YRniJFexAD984eP7jLs/x0J/1fC1mK
         vtNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpd/qu652CwY6CCIh+eoJE5qRKrknQewvCzD3jgIOI+0X6B8JJP8kRjSzk6n6S8Dh9iXnfwAqq4MdCk1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjOBdIEhvK6KqmcqdeOTc0nN2Vej8twBU+9OaSxPgcPjxM1rg
	V0GFVgOx7y2O22G/NFXIIqJeXDV5XiuWmuZSuMwZaArAGxUSSZSlG2Yv
X-Gm-Gg: AR+sD11jAEPI1RN09CbGw3Kb0wKeaevGTu/2oerw6GIGNRLWc1YIjdTRzwgNBTyMIgv
	mnf/PmaHw90ZleQrJtBxC8ein388Rw0vF7v5pZRuJO7GYNekhxzLBbsHEPMpRzRAf/9KQExIPQs
	8ltd2IsJqIitTu3N8FVo4ztKokhI4KgeY+CoDzzeHVkRIKg9UffdB/72orkcIsHh36l41vLdHkk
	/ozxYNs3Dl2oRUZ5+WeJISnWwEfNXSj8IkxBhsEOWnfnWUx9BsDRZFO0prtNRjGEKOU5ROhbKfN
	oi79im+/sOKTqfk9cm7b3FY3lIFZofKpxEeN4YS5GccvoQzFt9EHc7uS+Ler+h6wU2jPBG5myqm
	esshgWh9iguJ6qqmcp+nP/GphZ/mqAE8c/iXaM/4suvOKUOW6zelRMgAhYTp2yYjGv0+W4el/w7
	X59o+de7Rd8m1M2GNhkMFXqdk9bVZSWRhXH7rKSf4fIipAvFIPHO3n6j+QosRaHmIFinEYCZy0b
	vsEH2SkoMT2oSiZ3NoTUPXV1M2O6iYHJEWWdgnAu+YaiKJoL6KgEvxz+QyjbV728UdRN7nn4NTA
	88bsvGX+unPH5PDDi5oO
X-Received: by 2002:a17:902:da81:b0:2c9:e69f:8b0f with SMTP id d9443c01a7336-2d0521dd6e5mr137791555ad.17.1785832792742;
        Tue, 04 Aug 2026 01:39:52 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:541b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f93703sm3064405ad.7.2026.08.04.01.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 01:39:51 -0700 (PDT)
Message-ID: <214cf82d-742a-4753-bc86-c249366b54ed@gmail.com>
Date: Tue, 4 Aug 2026 09:39:31 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785596451.git.asml.silence@gmail.com>
 <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
 <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/3/26 14:20, Anuj gupta wrote:
> On Sat, Aug 1, 2026 at 9:19 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
>>
>>   unsigned long iov_iter_alignment(const struct iov_iter *i)
>>   {
>> -       if (likely(iter_is_ubuf(i))) {
>> +       if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>>                  size_t size = i->count;
>>                  if (size)
>>                          return ((unsigned long)i->ubuf + i->iov_offset) | size;
> 
> dmabuf_map shares the same union slot as ubuf, so this reads the map
> pointer as a user address. gap_alignment() below already returns 0
> correctly for dmabuf - this should too. Checked the rest of this patch
> (advance/revert/restore) - none of them dereference the union pointer
> for dmabuf, so it's isolated to this one spot. Doesn't affect the
> current series, nothing reaches this with a dmabuf iter yet.

Ah yes, that's nonsense, it should've checked iov_offset instead. Thanks

-- 
Pavel Begunkov

