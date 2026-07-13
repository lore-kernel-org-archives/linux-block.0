Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C23D3D16;
	Mon, 13 Jul 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932841; cv=none; b=XqH/wcVkwd9b6sZr2VAfenBpzrgUF/frl1oMHzTm9X1BTY/eRTQxoPuCxRLQJ41gyeJnllHEKeruCRpKm6i/9HBUJapDwFO51c5Z4MxxHgETS7Qs8lhNGnaig/W16pI10Q6M72hJT8+BpfMWHzZPN9b9smdGv1ki7Tt6S+G/VG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932841; c=relaxed/simple;
	bh=JOa6K++P6fYRskwoWz6GdiFHuS+l3STV0JKn4weWjIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjK9o5XNLYNcugTLQmB+aeg/GX4tnx0IcWfaPUX5iU14AXQzgKsc/9Cw1+pUxENExM98yN+t3EE/7WoNupH1UiDlXTXes8nfgJqlfiFM6Mpxq1IFJomN0UQApnJApjIL/ddE46Mo0e1nJlmzX5o4clmOSzNnszYh3YUFrY7SCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RUIqvmAD; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RUIqvmAD"
Message-ID: <0d439442-19b5-43b7-b4a2-1db31c5b4ebc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783932835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvIp+NR3qYt0PrZhDL/f2qxIy2gEc52ljxfHQCXyhr4=;
	b=RUIqvmADdYkety6SJEMUvPmUVl1FlTSnH4pfZO2icxTa5w3TBNYqcfBM4n1KYGDarXxqYl
	u40sg7a6WvMKynquAjKrvQ9QgIkjuf6AOJ80ap/o5+Tit35evljxX52dy3jOnhg65mJCLL
	kpz1hvGHzfnvtIiYRs5Pa0CvbZs3mMw=
Date: Mon, 13 Jul 2026 16:53:29 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 08/10] rust: binder: use `LocalModule` for
 `THIS_MODULE`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
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
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-8-2495cfa82d47@linux.dev>
 <alSeRIaps6QSqxJE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <alSeRIaps6QSqxJE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/13/26 16:13, Alice Ryhl wrote:
> On Mon, Jul 13, 2026 at 02:45:29PM +0800, Alvin Sun wrote:
>> Replace the `THIS_MODULE` static reference in the binder fops with
>> `this_module::<LocalModule>()`, consistent with the move of
>> `THIS_MODULE` into the `ModuleMetadata` trait.
>>
>> Assisted-by: opencode:glm-5.2
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> Most other Rust Binder commits use 'rust_binder:' prefix rather than
> 'rust: binder:'.

I missed this prefix convention — thanks for catching it.

I'll fix it in the next revision, along with any other feedback that 
comes in.

Best regards,
Alvin

>
> Alice
