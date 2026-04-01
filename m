Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB83480DEC;
	Wed,  1 Apr 2026 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084492; cv=none; b=K+l0HwoKCk/pEZq/NHqhYLuxPqmFFdxmCGUXNZ7+sUmuGdcgekBAGEuZiplMgBLDZXbqTp3+kbkqYXIuKiP9lLnJv6ee9VQ04hxTwN7fJ8folZeTZgP1XnWiszXheQ7wlu4pW8D71LXESSv0voBWG2cnF6zAKYp+ZH+6tU4zRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084492; c=relaxed/simple;
	bh=eMEeyEmMsSEJqm/VBl3vGWpBMChoVMgzinIBBgfTPlE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ChLKVJxnQCaq0l2w/XsFWt/WkvYElMM4ib9p6ZrTwvmJAmR1nw5PQLSg9x0u3ebx+e8iihT98PHmQACvPcpFaAJfwZ3JlLvWuunmeOv2wTW95KAObRBc93JVoQybQ3WkQfHlSGCf36Udkb0oywCjIDA9BktB9WoZPxuDCYhS0MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqBr1Jat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqBr1Jat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E053C116C6;
	Wed,  1 Apr 2026 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084492;
	bh=eMEeyEmMsSEJqm/VBl3vGWpBMChoVMgzinIBBgfTPlE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=OqBr1JatdiUb2SuylVZI06g081Th5A5y+SBKA3HDmkQQ97vI3JEwhrSxvGwmRYfcT
	 gIgZiBk86U6zFl2xeAM5XAcNIndwN1BmcEoaR5ZvJYM7rqzMFz+1YsE+cz7axIJl2F
	 X039vepaYXzaeHv3h/+ZjOkTeUE+OJDVFelUi2CljqpO1nCMphf/t+AimoE63wwItA
	 oicrQfUBsr7nzOMQMl4np1MASYv6HNnj7KFB/AEG/OmevrCXcdXrzdV6/QynJ6W0qp
	 YB9ROCeUG7CfHzwZ7tLmPMeRsXJJ6hXMQDecGejA+SExP6VmmpiJ41ojKql7BZVzvj
	 qYYbOof6fOpDg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 26/33] docs: rust: quick-start: remove Gentoo "testing"
 note
From: Tamir Duberstein <tamird@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
In-Reply-To: <20260401114540.30108-27-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-27-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434468.73816.14590171380654521174.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=345; i=tamird@kernel.org;
 h=from:subject:message-id; bh=eMEeyEmMsSEJqm/VBl3vGWpBMChoVMgzinIBBgfTPlE=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnF7uuLFn5ysG844m+YOzU32yT5q2ddFFGwjjYK7z0s
 IHllYmrOyayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEx1cxYjw/WVXWtWXt19ZdneHTnhLd/eMl7yEJ8655tqxfdHppWHvysx/PdbySo
 az7fibtaeiJbGk/N2qotN1tyw6K2c2vSuyp4IYx4A
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:33 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> Gentoo does not need the "testing" note, since its packages are recent
> enough even in the stable branch [1][2].
> 
> Thus remove it to simplify the documentation.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
