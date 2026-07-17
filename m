Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB23FCB3D;
	Fri, 17 Jul 2026 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293662; cv=none; b=ItK5eK7PsTuq+gc39ehBMpgBOPZW9SnL/nrBtjNzYRh6AmOHuaw4xG4bqpXIQmLIqFfDnAkL/EBh43RROeCPJXty+XIFAE+x8c0J9EFE6mKpUOjeyO+XhPzSQYqf/v8hkEX89INdNFtRAXQ01eEP7iIrBsMUnZQaPW6NTeRsBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293662; c=relaxed/simple;
	bh=FK9yzES7VKd8Fftfk4CsEOxnZ30CVLaBrqab0FLOFgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKiIr3DnyIFDeKR4oLByAMBG4EZkiUYCXkWqq9xKucPB4HW5dvmW1MTaiTueQnnG3Vqji6i7sQV1JEekxC04FRfZyvKREbpZw618g8ejbQPinQ0IctWqGRkjDlfLmQvdHMYAQ3G8Phyfa4S3KoIqLrvUcOFr1hdyKpOIxuSf7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1UFaKp3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1UFaKp3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129A51F000E9;
	Fri, 17 Jul 2026 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784293659;
	bh=mooRlPTlUqV1sVp6NuD8rb2bN7qHo0BLIrW5P+Xgh9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1UFaKp3K1wugDE8JEb8ay0NtdC9vP4PtHFh0AE/O8qOH85sTTFovb+4ptE2qqLA0p
	 L4c55q22J1kNNNzoHIBXMQiC9DTw6EM1SFK4DPR4NthzUte3gFETh0B4SOaNuMbcdW
	 KYq2ylYlMHrAxWiMgrUYrCR/9mRDvjrWdvPQFyKo=
Date: Fri, 17 Jul 2026 15:07:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	Dave Ertman <david.m.ertman@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 06/10] rust: miscdevice: set fops.owner from driver
 module pointer
Message-ID: <2026071725-unpiloted-bogus-f1de@gregkh>
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-6-2495cfa82d47@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-fix-fops-owner-v8-6-2495cfa82d47@linux.dev>

On Mon, Jul 13, 2026 at 02:45:27PM +0800, Alvin Sun wrote:
> Set the miscdevice fops owner field from the driver module pointer
> via the `this_module::<T::OwnerModule>()` helper, instead of
> defaulting to null.
> 
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/miscdevice.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
