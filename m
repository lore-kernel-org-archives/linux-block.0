Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F703D5676
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273819; cv=none; b=mG2Z5DuMa070ELMOWlyzgY2fH2O2x33S3ezOwgCyNQ9GUvWLMELEwt3l9KlqfYxeyuEn42oA+JOBhNQvl83DFVwwdpnYHcbLdI1KMldYU8jsWZ0hn5lwjnuJlNQ8BlY+eMLZgLlL2QOu3f0Do3z4jVSx11xw8DfnhK872nScvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273819; c=relaxed/simple;
	bh=pQpe8Q9yj6ROldK867ps0eaFTpFT2jm9cS4CxVZE0X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7aya78swVTXxRaeEjxFKRS8xFfmnxNOWJLVU54PfI0jzXKd8MRSSo4r1F4jT3sJuGoYs01XUn5bKolxYJkcc6pWTQ6j7fGhemqlmURmqRvbvfjE9eqWQ+0DFUVxX/D59dVxW2H+N4xYOtkAI2HBf5txcjQrEjowRVjQIbkv/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jCXc38FT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jCXc38FT"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso4981356b3a.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788273815; x=1788878615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VGr8F8L21ebVXkeXY8Md7VVfyAGYTbciZibwcQd/kPw=;
        b=jCXc38FTDeaoNtl8yW07DhWLMZoTysbY0o9VLT2EJkCdzgQ7rKTLtKbZ+RqB+B/FR4
         Jj1dcn4+OjinmDaLUlfj2ORQBonFqcLst440vNPPmZKY8TNV7N7vJQ5fzNvSXjwFVo9U
         bStWGfcCQlEduGUgOnru50Xxf3uV4sOm8st9bdVFl4NyaEZ3nDedaXH/fweNjXl5wLJA
         SXqHNMnHwERivdZjNmgmC3RdaUbfNodR5w0dl0WyulzPmScu2CvJuPTE4JH+sTDGfgmC
         MOeJ2ZS8DnzOK2NAZECObGRpvpecLNlH0U72GM3iLYaSk3lrsLwDza+nsh9G0Ox1sM3K
         EuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273815; x=1788878615;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VGr8F8L21ebVXkeXY8Md7VVfyAGYTbciZibwcQd/kPw=;
        b=Ncdz2gpkMq/4ps+cDCJ9CZiEFRUAhkweBsjqgxbgZb9v5TmztAJ3gyFsI8i1G73i2o
         2m3SDWCz6/F7m9FyGA4P7l9qvMKcx6KfnHjNOeepVstmU43WFya+8OuxWnZDtRDpbm9C
         wcc4FePP2q1jijBKtJKaBos4t+NoHlo9Nue104xapjEwwabTjkYbl0Plizn5Dii5ZSzM
         8cqRi/CPJSk+uUNRx5NvYnIA96YTTndjbaIsY1z4HJy4t0SAxiUTJIbA9SmQ7iuTjqRo
         qw4WGiTE7VVU8yG71Upt4I+geGs8UbksZe6vRb/WN6aTOGAYmBZq9YBXAdp5JZXFNYjr
         h37g==
X-Forwarded-Encrypted: i=1; AHgh+RpfZ3qUfYDgbxzH149senEIlvu6o6WbGRHV8y4wq0mI1hXcBWKY3mnCFTjCY4TrmhIPJIeq+k1RS8OdEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mToLIGvI7MbXOxGMNCYBC1nS0SLCTrLLjDN2rVHdfPcgWSIO8R
	8AxP/yJJCBLlAUnp4Jp4v6k6DaerkquObb9lybgoXdqaCT/7LjYC3Vp7UPzzG7NyMBA=
X-Gm-Gg: AR+sD10tH54FsVOsAhZ8Ynkl31xxoPrHwxczKfIfZo+jhqapXxae9/2V/O4oWZJPW/h
	MRb1RpY5GhAA5anaOowq8ZYTsjpBrKMu7WArPxzlDxqQkWAQ09jh8zBCQdNsUuZzpSPX46Brma1
	oLADMkNv/5wDp/rw2AGCo2fjFlqIBv1qe/1b/wbYuYk+GBEmjds1giotQmG6hl2E1n0VVFn5QZu
	eaZzU8zeWDCcjsKw0Bro/aYQbNsRv2NgtvDl8bMAhZ4GUp+tnSdeS+s5+BPxLShcgDMLooFSup1
	xlmHOalfOvajBpav6kW46zP4ju66y0TpnkRXu/P2Ek9j66stgHjs3iLm0sjIE1ewBILkikaztuo
	wR9eMc4rImkAhKZfsVo1DxsbG/fNcihvQAdlSo0mX0ZeTRewkIiDBs1rxmrHkdTvuHZrT0OMFLd
	o2vNECxps3RanBlnp6tnsyfYLf9TAwvnENp0EgpINMtf0031VCeFpE1ZMRwkeqkE25qcgMlCvYF
	eLej040vhG3jrYL2USt2inyA/iiuZ6pFTXrZvoR537WLMg=
X-Received: by 2002:a05:6a20:2d26:b0:3d0:6c90:5a33 with SMTP id adf61e73a8af0-3d265a40e73mr58722419637.4.1788273815501;
        Tue, 01 Sep 2026 07:43:35 -0700 (PDT)
Received: from [172.20.4.188] ([192.77.111.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa5517fsm43158468eec.31.2026.09.01.07.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 07:43:35 -0700 (PDT)
Message-ID: <2a69d47f-9dca-4af1-9d0d-2358af79e7d9@kernel.dk>
Date: Tue, 1 Sep 2026 08:43:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: save page offset gaps in cloned bio
To: Keith Busch <kbusch@kernel.org>, Eric Auger <eauger@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
 Eric Auger <eric.auger@redhat.com>, Bart Van Assche <bvanassche@acm.org>
References: <20260819154937.3903312-1-kbusch@meta.com>
 <a31c539d-3554-4f8a-8ff8-a313a554d4f1@redhat.com>
 <apWbEA42WEJQ1uBB@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <apWbEA42WEJQ1uBB@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 9:17 AM, Keith Busch wrote:
> On Mon, Aug 31, 2026 at 02:26:06PM +0200, Eric Auger wrote:
>> gentle ping on that fix. Could someone pull it?
> 
> Yes, and these two pending patches as well:
> 
> https://lore.kernel.org/linux-block/20260810164218.3721636-1-kbusch@meta.com/

Done, those two.

> https://lore.kernel.org/linux-block/d919f5285d16afbec6c51ecdf201692a484566e5.1786637565.git.bvanassche@acm.org/

No longer applies.

-- 
Jens Axboe

