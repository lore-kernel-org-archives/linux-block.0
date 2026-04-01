Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94F44CAFC;
	Wed,  1 Apr 2026 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084393; cv=none; b=GX2HlcYfbErKkxolaHRCreELvJbWs1SN4CKXNVZiIjIAf+CQIOfXM9ktnLYdajq28/zOGHaM5qcDZ3bNOHh7cgrU276WDtofBaXseP5r/zbCMzM38hw7kNjn9ZqqB6qF8rYWH7L4bCndI+kVIgpgWAQajzNnnAFr5yoz/bt3m1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084393; c=relaxed/simple;
	bh=xq9NcCud+LpB0atoCb11q9Wd2+LfbKDNAZgfYlibXt4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=XXX2KPUs9q4LUEq3eqKfqXbz7xd8GSjEJiH7OoSnLSd7jpzJ0U0pazI0DoJ7FVW1ggoQv3w0cP/eNbMEPrW+Gi+g2UQ6tmpr4CPMsx9YKFiu0z9Za8m7lVxplUXu/Ktpt6GN27yc1VMKQIqZTJz56aO+RKfU6CLCALD6bYSsfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AInBcHCO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AInBcHCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A75C4CEF7;
	Wed,  1 Apr 2026 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775084393;
	bh=xq9NcCud+LpB0atoCb11q9Wd2+LfbKDNAZgfYlibXt4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=AInBcHCOb6slZkVW3sn4yoBhwFNl5NlNG6FRxcOcIgbbEkjdrWTvy+wLlDWdNljcc
	 vk4SDzjYy6ZR3ZjdWJhBV2ccdBdnaQCwXJPz5Yi0tg45+MPA61hDBoLRIoTN4QvGxC
	 44aHSoDRJmSVpgbQHlXqD6c/CH53DMmvO7Q27cV7SRH799uEQrs0IUUfAUC3xvcSfc
	 HJj3S3JF4Rz5M7mt9X4oNWU03EttVxsgI9eMoA7Rv84vHKGz6jiEL4Zcrano0XnD79
	 RGUY+op3WG++YeUETBS3kAl5j78KT3CoatR+1yaVIVR8silujNcQMpHiLSrolxpScn
	 YBJyUoPe/kkSA==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 07/33] rust: kbuild: remove `feature(...)`s that are
 now stable
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
In-Reply-To: <20260401114540.30108-8-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-8-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434438.73816.15311163307401795216.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=313; i=tamird@kernel.org;
 h=from:subject:message-id; bh=xq9NcCud+LpB0atoCb11q9Wd2+LfbKDNAZgfYlibXt4=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnFzspLpTbOycju58p6Jb3ZLOTu+M754m9/iawQLs9w
 erJzAPzOiayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEx19zGG/0FezPN/HDOfzHe+bNJvl0z7Rx0bKgOunZEp7JeLPBIyT5+RYZfYni7
 GH+9rH6cZM1tXqnm23i9Nv9+0+PeGNO+Zi4rv8QMA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

On Wed, 01 Apr 2026 13:45:14 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> Now that the Rust minimum version is 1.85.0, there is no need to enable
> certain features that are stable.
> 
> Thus clean them up.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
