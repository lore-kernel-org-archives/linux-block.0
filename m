Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041D543D4E0
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832928; cv=none; b=Wh5qLwhe/Ya0Trp8i9yGn61b9SwYdwQWcQiQAIdxXg82bTepBykYzrUyDo3unKRwHEeGnqP5GGmUBiIpIhvQQKo62MHJgh7kc+Bgb2EJgPzwcL/WKuzx+L/LLm+RxY/XZzxaqzYXpq8MBDIHMFcQM+pJdEU2ht70zsH6HbONe9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832928; c=relaxed/simple;
	bh=SD2jpuPrRshOPjZPDhOULtKF/IyS30DOHYKRJQ1eYRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dByDcOCCtsKdQiy4BGPsEQaflsMRCJ0Fzje4oK3bQz6OJ4tK3WlSDalDlQ3+vg3cSsSCz2ta2TemZvqIJrEuU71h7qo9Z8Y8XNefxI/jelgod0LkPCaarDhNhQdiK/e7vQik4KicWIMBD28oKPL2pUIT1YdvCeil0VAjQ6N72uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA0v0brP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA0v0brP"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a2c90e383so571121b3a.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832926; x=1786437726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U2I8sdYMfYJjOc8dSgSE9HfEVezQOKs2ggEWu0ibP00=;
        b=PA0v0brPxdaG3MEMmRscI/ZEK7lPZvVtloK+bV3z/F9OTMQIQYQK3/DIi4u1GI7qFN
         loGlkGRq//5VBuMSUY8lNrmwfGcdY4Dc3skR5sZU+/7VijefGzbiWad1oWBUhNiRIcBR
         cATciU315li3smb1VkkPjTv/WGRzNvjMRooeuj3M8NegTKCk5+CniXtcBKbrwzdX5Ppk
         AEZ81m5gD/uKb6SuQr7oj0ccxoRAvDdPkdHbgbpQj8hdWtBtKR3OCIc+XDmV+K49o6JU
         g8ze6gtlfWfC4/AeGKb2PunLoQvQYsHnEgqI3aEJhVqD8xaegcnxUAv7aD+3NAQ+DF75
         YToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832926; x=1786437726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U2I8sdYMfYJjOc8dSgSE9HfEVezQOKs2ggEWu0ibP00=;
        b=gcsiItTTotDSaly0bHe3gEX5NWmKoHvsvCezryWj/vlqZeSms5sZo4s4un6AaOWGgW
         zJh9fpRxDkzu4F6M9E7HUUQ1rx27SYr+MS01zBx6PxA2RjCjMW7swDSbFV2ciXwwzon/
         ufEiWkiYedwaj+HWIokwd1jTscTo4nC2Gj4fs+y6HFo8rZctHwWrYH9Px160kho7WZIk
         Bo6NknvYx4cyiSkbL8av2TAl8atZ1QqBz+YqEABWUE2HT+DFo1RSyLH9suTb7kFvVS1Z
         HCfjDnu+3SPovVWJxDGALQpl38mN8AfR+HdfnTJZUutX4XCEl5SWxnu5PRIVumLReHtf
         GvqA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+q/5ELo2aj48UzRJ7a5AIjQWHoVuEuCwIt/n4BxImggxH3j+ouOl2cJ7hqyRB6l7Bmm2l3MymAFH3bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDLMd1mNhzArT8i89IA7rcwhvuNEXFTcx7D/pzYLVfvLhLSsn
	q82VvQZzC8BBu5K9dnTCCqdxnV8FRaG9PqLu8u1zoawQQpaWR/zUAaNa
X-Gm-Gg: AR+sD10ojYPT0e+oeUWQXcPdARAdPqI66kYQDUBCiApE8NZjAcC7AeREtX08Xe5Iinl
	4vbddCdK16gfWMXWEIkcS93PaQVdAh46InOkc5BNEU5Ad/zQPfld0LDVU7VqNxNwRC++SJ26UX6
	NQ6o1fW1cHL5CDyuRlf/G1tp3IbjXA1bED/qzPc0sAC8VtQUb+mOrAJpp0MffAzs3PNx7ze1hIR
	l0n6szD3KqaSKKED8Ktzzc5Bg641VHMRjdQT6IZEtEjE2J4/6xTuaRy5XGpa1ubgmiTC8/kfCDS
	DF90G2dctmAumrUgLUEnTXLdXYzrE5M0uIXqklj2Zv0MQ56PA3x2ou2lclSt97Qyg1vc7H8puhO
	EmFycDOfqBB/pAvBTlqcVp83iaS6FlQfVDGlYsPKzjJzhIvOn5ovxDIoLyazDavc7poJBL7gp/b
	CjYlv/fs9wygiM0Xex5WIBxSlKQd23or01DCgPXWMHnVB6o9WF4wEsHsR/IKscksUA8Ltz2z48k
	KAJ3B/165K1r3PHSi7dVKb9r7ESHy+i8d37S5IpiNxKLlFXY71zVneJwAS8HDW+oeYaFXgyqnSr
	NrOy+BG/CVsVdAaPgiQx
X-Received: by 2002:a05:6a20:9188:b0:3bf:6c27:38b with SMTP id adf61e73a8af0-3cb6c937c3amr2601207637.29.1785832926102;
        Tue, 04 Aug 2026 01:42:06 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:541b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea0a73sm4753273a12.23.2026.08.04.01.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 01:42:05 -0700 (PDT)
Message-ID: <53c9cf90-4284-4b6a-ab2f-1686c7461bf8@gmail.com>
Date: Tue, 4 Aug 2026 09:41:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] nvme-pci: implement dma-buf backed requests
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785596451.git.asml.silence@gmail.com>
 <CGME20260801155005epcas5p4ecdcdf532aa2c2ff4e94638eedaa435b@epcas5p4.samsung.com>
 <9e3dd1b2d71dc0f9bd556b6a6d6e48fb6a8d727b.1785596451.git.asml.silence@gmail.com>
 <c4cec417-24b8-428a-853f-4e1ff1e29a6a@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <c4cec417-24b8-428a-853f-4e1ff1e29a6a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 08:29, Anuj Gupta/Anuj Gupta wrote:
> On 8/1/2026 9:16 PM, Pavel Begunkov wrote:
...>> +	if (WARN_ON_ONCE(seg_shift < NVME_CTRL_PAGE_SHIFT))
>> +		return ERR_PTR(-EFAULT);
> 
> This should be 'goto err;' instead of a direct return. If this ever
> triggers, it leaks the map and already established sgt mapping.

I can change it as I'm going to respin the series anyway,
but it doesn't really matter here as it's a warning and
shouldn't happen.

-- 
Pavel Begunkov

