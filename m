Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CE2F8EAF
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 03:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782442961; cv=none; b=L51peNm2qWK9bFO9s+dPSG9qfFpBahrGKOatWwMuM4OmXjmWWAFPdBPd4C/MuhtUIR0sG54QkDv5TOQ74SwyS6xSbJAa2v6CE2huyCfIksSE7wwQ5EKZ2VEW3agxd5qfKdgRMnRguq3mQ1QjgXeG1RtO8QE9WfEi9UWbA/kggUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782442961; c=relaxed/simple;
	bh=ZcsBLTieoNkA9TEUBhYNrRlE05FDe1x3P3jRfh8SjQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li7KNFVrSxwoCP+zWZrTDqcfS5IK2IgVYKEZTaVeALwyFqe5M7q48YDu4r3Kk4y+A6GuMZuNLgpRCRb9KwTNXzEM8UkaMi+LFwEl419M2I6vgMbSVSmAV3MsK7y5cSvTKiupA0xIqH4ypa8Pzwt/YRo8A1zca4hJftCuLJ5ZPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q3DWILNq; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q3DWILNq"
Message-ID: <6d2b7611-41ec-45f0-a155-3b5c90c5d883@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782442947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f271ICHhBS5Ku8NbvazkeutM3PKmnGfN//6w5jBctrk=;
	b=Q3DWILNq4rp7hL2oZ6zGRWnQi51EjKsSeNeF9gJ2kjLwYticVzg/5adTwdCkossO18oJMv
	IX52h1GK1926K2SnQvL/RfDBYyDo0cmHpp2mWBjWBwBXYlPzRxN9/ESbADYOUha3RRcoHu
	ysyaxxln8iygLQDFXJyQQTJeou2c7/8=
Date: Fri, 26 Jun 2026 11:01:48 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 10/10] rust: module: update MAINTAINERS to cover
 module.rs
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev>
 <20260624-fix-fops-owner-v6-10-5295e333cb3e@linux.dev>
 <DJI7HR91X68U.3BVK3U4OJC18B@garyguo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DJI7HR91X68U.3BVK3U4OJC18B@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/25/26 22:39, Gary Guo wrote:
> On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
>> Module types now live in `rust/kernel/module.rs` alongside
>> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
>> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
>> files are covered.
>>
>> Assisted-by: opencode:glm-5.2
> Did you actually use a LLM for this patch even? :)

Yes, I've created a skill that generates commit messages for the code I 
modify
manually.

>
>> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> This patch should probably be squashed into the actual move, i.e. patch 1.

Sure. Looking at the change history of the `MAINTAINERS` file, the 
modifications
are always in standalone commits, so I followed the same convention.

Best regards,
Alvin

>
> Best,
> Gary
>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e035a3be797c4..74733de3e41ee 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17984,7 +17984,7 @@ F:	include/linux/module*.h
>>   F:	kernel/module/
>>   F:	lib/test_kmod.c
>>   F:	lib/tests/module/
>> -F:	rust/kernel/module_param.rs
>> +F:	rust/kernel/module*.rs
>>   F:	rust/macros/module.rs
>>   F:	scripts/module*
>>   F:	tools/testing/selftests/kmod/
>
