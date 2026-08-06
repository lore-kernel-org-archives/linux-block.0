Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C953473C72
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018899; cv=none; b=hdeji/hzsWdMZtWmjtsnMOWz0w9aM2fpHW7oFCKVmoJZxLOAFqPnooB/iBDYoQl2Ks4NQ93PyolID3tWRrHV3/5GmLFTDxNUZxtT+9HhNqfWcUSUmKPq5H4GxSy7zPqo2Aam+Pa6kCLni+SPnwxrPvBx7VfsPBcz810RF0/5Zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018899; c=relaxed/simple;
	bh=TTiHlStxZcKVKrwqcuDMLj38rBSP7TpoZoQlRZGLyrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCP+h5G751szhRTwHZzpvyRSKO35GpSs0TluZPViUN3A5Ps47ptFjLtnqYR+A0C+NJeK7LkkcYWe6U+d88S0ukrn/hxvyV4Pgf0v6Ig7Unxt0mxx30mQxluOYhBWGVlliLwNn8caic0vsQILIJvdARsZinCyZSdbQEKQ18wFrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJn+DDkP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJn+DDkP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-472326ca506so1438548f8f.2
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786018896; x=1786623696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfDlnjwEjqQiBft6//i9aWDA7+Wxp9IrqsB/3Fhaw40=;
        b=XJn+DDkPJjP/V2NYxQMNMiUSztdxL5BX3WbOePcGIWTdGsldovqU+YfLJCrgljR9wi
         Y7Zz1/sSG7RzzLYA2LPhGo+cnU6cJb9RbZpDL23FjZFb+K4qZGkYxZJToxsT0UUNh/da
         4gSd5ws2QvWA2bITT/VCjrmjCHJzcr07+p8KF1EhyRnckQU+Fjc8duNsPqwMsXZLrnJw
         8XeSVdu3KCL8RgMkdeKpLnPdI6TcVjzcqv11BdjCHvpdXY4YJW9NTiepW9CXB4dA8Ml1
         3OATNWEVAQ3M8+khX9YopaUgISPtmr84CTmTp5pvcKP+jJCJPvR7s8sU9HZX6DBjg+gs
         W/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018896; x=1786623696;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DfDlnjwEjqQiBft6//i9aWDA7+Wxp9IrqsB/3Fhaw40=;
        b=oSpE4jWVL5XzvLgtwr0lZelVPkkIwHVoWiWpolCXFWtBn7RP7IJjjIlh+DDWWf4eqW
         segiEfMMlC9ANO0ZFQ3l9m4mDdHXKuqK4n8KmdiSBS87b/5eLdFeZ9NFTv7DYVT7Bujb
         fXE0ZS0nr+M1qF/t/7GrR5GI7ShfNQJi7b1EiUvZziZ3YfVGneCWRjOjkCJIsWZBgHRS
         kAk8ljEdYKNEgDE8xzoMhs6QXBIkv79plEZQ+CDlXyHLeY2+RsOABu6sFccRfRxwfRmZ
         oQEBszQtlqkwcMKpa3SnTT7bXVjGr61oXCJqeokoYqgC+kewv0S4p6AX106HSPY4qUM7
         mzJA==
X-Gm-Message-State: AOJu0Yw+uUbxyoYIsoS2oe6NtqEFnZ29wm9tmAxbyPy78CwGTu/iqHZ/
	EEGg7H/tyrDP6k0Jo7hDsBkL9i112faV/PcJFN6OTImWN23hXto8gXWIYh7H1bv+YWk=
X-Gm-Gg: AR+sD10QEaU5XWXN9sR9GjzGTksDqybfuWpvlHOwTwin2Jh7m+UCV0NzBe4kljvVmuZ
	AGxdyCO++oQ0zU87/odq58oJooqUiSj47/ULCXS2e2E+ne47lbw7JteIu6qfgH5xXur389utHkf
	uaPdFYa+8sAHXxhkZNFHUd1g+d7be1ArD4bd2cK0ELIDC9QANfON1cVp2I3nkMAuu2YpE3KxbdH
	pf+dj81JiDf5+yVt8/Y7WReNYTnqovQqsn9SiuAenDhfR3+/PlvNVwHSracCIKgmB6nQ2dQxJrL
	Nbb2BwkI/bPoCBDFQKPmx+4tpd0UqIDbN3zt/tEBoAUeBhfam77z8b0sJfUDT2srThDFzKljjwt
	8RCvcqWb3eNpN9GTaiZseyrOag799vKFeJrWse1mVItvBlX71PWlPWMP5BPfKU0Z8IFHfcNPTph
	Ao9JgBteVZK6vV/+90jZ9EX2VEHEZ4U3n44Z7IferpQrAooLfe/Z3GQNVH9IDemwdlnlxGg6kTH
	ee9ZyTJiEd6W1/u3zku0zD9nMk9y3USKiAIZanOHqKHzmfcM/ZTloYj7VPGYUNlXt7Nk5clDeGA
	R4Qu4HByPgTdTvv1KmIeKsvfyc7qxPKm9EFvmQ==
X-Received: by 2002:a05:6000:290d:b0:47f:f42e:9715 with SMTP id ffacd0b85a97d-47ff42e974fmr10864047f8f.12.1786018896398;
        Thu, 06 Aug 2026 05:21:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b32492sm5927425f8f.35.2026.08.06.05.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 05:21:35 -0700 (PDT)
Message-ID: <f47ed617-5ee7-4259-9f5f-a6fd0f5aab24@gmail.com>
Date: Thu, 6 Aug 2026 13:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: rename bi_bvec_done
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Hannes Reinecke <hare@kernel.org>,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 13:19, Pavel Begunkov wrote:
> struct bvec_iter::bi_bvec_done is used an offset in the current bvec,
> let's rename it accordingly for better clarity. I also plan to use it
> for non-bvec based iteration in the future like dma-buf, so drop the
> "bvec" part.

I have this patch for the dma-buf patch set, but it's a very noisy
one, and I've got an impression that it'd be a good thing to do
regardless. Hence sending separately hoping it'd get into 7.3

-- 
Pavel Begunkov

