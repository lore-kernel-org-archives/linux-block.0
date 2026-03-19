Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2243CD8B4
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921766; cv=none; b=HIV4NsdwgSZvLMHtwFnIIc5vIvTx8ky/hSJIU0MLRuOHt1efh68G95LbT15eX5A2anv9JokwKe4JzOKOcjTb2wiOkWcjy1xb3wAgHw+oithWw5RDktZXw7PZUWEr/MkPdWndwAZ0fGNQ/6NcInAKve1u2kZAY09at3LSaBKRzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921766; c=relaxed/simple;
	bh=HZucGe+tXtLs6arl7n+/zfcUX95wZN5puvhi2kKITJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwRRfhjB0ueET5ZrG0yY3RGvkLWHTAnycaaqoE4U8FpzhXKBwsd4cHMvdbCeCQtHl6e0nY8FagvQ4pjiSTkPUrsjtRNj8net5vfpzKDi0GeA1ZctRqzW9lTZ9RsSkDyLvLCs19enT6dxCLnNkTUXyqeLwWJt+k1U1j652DDTvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DftRCptV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m17oNBcj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DftRCptV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m17oNBcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773921763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmtXuPZqg0u0KuwJyVBzjey4ZPEavJp9+pXBdZV2bRw=;
	b=DftRCptVfsHJVpoVtjowxPdGFz2Mr9CNOfhH4ISGbykKrY5tkQIAXPXsDPN938NsUxegQs
	1qlU6vJPm3EqgNmat+qtUN9MRwl/3j2yA0T5NBbbXKP7q3saVEAYPs6WerdhnrjeMqANX0
	Na5boTX4mh2Le98Zcm22SqqFQhzFX7g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-BF_k86WSNJ-IV5pkhHzYLA-1; Thu, 19 Mar 2026 08:02:40 -0400
X-MC-Unique: BF_k86WSNJ-IV5pkhHzYLA-1
X-Mimecast-MFC-AGG-ID: BF_k86WSNJ-IV5pkhHzYLA_1773921760
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89c4b118740so17656936d6.3
        for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 05:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773921760; x=1774526560; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmtXuPZqg0u0KuwJyVBzjey4ZPEavJp9+pXBdZV2bRw=;
        b=m17oNBcjIbctpTqfZlu+lzHHLneZTUXmE9bkJuGuwitXtmW2CaCLZ//LSmZpFO8eVg
         v93WI92CU0yVrjUNu3wjqiHVG8FKKdhWbXL6te+3KrYKR66r4Xic7bYbtSQDpoVmbDCY
         OG+iwuHP3jziMEo+gonE7D55aelQf/0gmAQMR3xiZX6o35PV/UrdZDGNYj0LJtN4g+x8
         N2c4+Mt0rF9C6aW/51TsJtakkSbEkB1NgeU6SL6orBksf8MVTq+lfthjuR1ROOzhGRSN
         o3vG4pSQeJBcQ8kspOgRg2rZqg0mFZEj7zmkMFbKMptsZh/R8Ihv/EWIAjPdoLu7R3W7
         Xmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921760; x=1774526560;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmtXuPZqg0u0KuwJyVBzjey4ZPEavJp9+pXBdZV2bRw=;
        b=KnKK9ZyjGWN1qiKYAtrdyyT8bscYY++0T0VMoZJYZ8iAdkgnGdkosVkUMSaBXoSUvo
         ZNeKr+VjBH1CqpBJlxWdfHoMg9cBuhUM6mtba3Vj8RyDKkj+E+CFgi1t+dur9WNhtGdS
         oZT0PCYWSCHvvIk48LPFXUQ6aoZLkQoEV2R39Nn4Mu2gG4L56mrg1XUn21fVM3I0EKgK
         bt8lATq4b3Yc/AEbuE9OYryJ6aQgq4D95586h8Tl1l7mwicqz4lSIRr0eOgmZ6nvqfX9
         7TWvX8xhDyspe/QKntQE9KNBk7fou6dnfzpG5EYeNvcFTFOrtB8FmywaNoNTXOaRuyb5
         LBQA==
X-Forwarded-Encrypted: i=1; AJvYcCUR4fFmrG6daM7S20pDLEOnZnviRfjOjOuMa3U4YCEVcqAsgcGuozaYLB7YngVy/K93RSdgWCNGy5SPsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBW8cyvahi0McuzOmf7OZIyptpfqd5OHtu6V75QvtOMxIiFWAV
	ZZtqBXknJhz/X86uOc0KbgufMSAXVUOEN0MNoHn2gtxtyo3hgtjilg0XC5fyMpooxtQgL8/Ssp2
	sL4EADyw505vahashLg7E2cNBFlUkmUTo3FXvZoMXMAXVxcltOqMOXUTHJcp8gqbY
X-Gm-Gg: ATEYQzwzcYAgLPCzRb7AHH9gqwVNaXTEynz5MgUEea+P9O3Xif3wnmmpBgzfhfkXKEF
	wOfH9MWVNOzteWuo5BIiT9gQcCOZcHLLnaGNR6QxxQNuckWgcm7QsqOeB4+4PAv8WKa251tDhpw
	F4fhw8BDp1aFBBRzCdGinK2dlhWMYAD+LX5I1Ytfo0sIkFyKwGyWAaYGhnd2zVHUviIoVaqJCRY
	fUZwZVb8jfXZ03EDftthoxaDlDl/CbmYqGCV5/MFlE8IDieAokAgcpoNhS2O2ll5PBThHWqkl0m
	z8ZjSSgAs+8V21Ybvm24mNJx+1RscfazR68u3ycZeV9R1+bTX0UbqhN8gRi1CnXe4u8P+xDOg3L
	X5Eq3D0mAKKnCHvIpmL+FIf9APR8MWf9Is4Ie8wOc408DcKEnaOWFzr7hpEQ=
X-Received: by 2002:ad4:5ded:0:b0:89a:666:ad2b with SMTP id 6a1803df08f44-89c6b56bcf5mr102002986d6.27.1773921760078;
        Thu, 19 Mar 2026 05:02:40 -0700 (PDT)
X-Received: by 2002:ad4:5ded:0:b0:89a:666:ad2b with SMTP id 6a1803df08f44-89c6b56bcf5mr102002236d6.27.1773921759463;
        Thu, 19 Mar 2026 05:02:39 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c64:4e7f:603b:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8e0a5bsm43875346d6.6.2026.03.19.05.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:02:38 -0700 (PDT)
Message-ID: <9d6ca1c6c919de0999c64628feabf1e677f7e759.camel@redhat.com>
Subject: Re: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
From: Laurence Oberman <loberman@redhat.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Aaron Tomlin
	 <atomlin@atomlin.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "rostedt@goodmis.org"
	 <rostedt@goodmis.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, 
 "mathieu.desnoyers@efficios.com"
	 <mathieu.desnoyers@efficios.com>
Cc: "kch@nvidia.com" <kch@nvidia.com>, "bvanassche@acm.org"
 <bvanassche@acm.org>,  "dlemoal@kernel.org"	 <dlemoal@kernel.org>,
 "ritesh.list@gmail.com" <ritesh.list@gmail.com>,  "neelx@suse.com"	
 <neelx@suse.com>, "sean@ashe.io" <sean@ashe.io>, "mproche@gmail.com"	
 <mproche@gmail.com>, "chjohnst@gmail.com" <chjohnst@gmail.com>, 
 "linux-block@vger.kernel.org"	 <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org"	 <linux-trace-kernel@vger.kernel.org>
Date: Thu, 19 Mar 2026 08:02:36 -0400
In-Reply-To: <63dfc26d-7d9d-4530-bf85-4f07fbcf240a@wdc.com>
References: <20260319015300.287653-1-atomlin@atomlin.com>
	 <63dfc26d-7d9d-4530-bf85-4f07fbcf240a@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-19 at 07:32 +0000, Johannes Thumshirn wrote:
> Looks good,
>=20
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good now.

Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by:   Laurence Oberman <loberman@redhat.com>

