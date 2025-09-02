Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF54275AE9
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851768; cv=none; b=GeW3b9JQTKXNmPeSTg9io4IjY+4hmoKi4A0TymE0aBdumHdmMeQtNEQhVYIk/MA2Y4pscCnknbjKfYHWLtAkdVg82mazJY20I++2l7N7kNUQdhIG4c45OftO/U6gtHyOTlNDDiItND6EyJfz8lqmLg/V+560B191S57OP825pFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851768; c=relaxed/simple;
	bh=1r8Dd1Vxp/ZfKTkV/+QQqeGZJ37/gBVxDRLdoNTobx4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fRVpzn+GBWq5nOLuhffd7vxg1lP+WtmbIiJBseRlg6JDwYYlHYQuRA+A2PQM/tg+2ar7+GWk+0E1leb0ljwmveemTVKOVj0Gnzo3A576/zOjiMnZMYyamdmFruWSV/EXsNRtv+EwsdMoSRVx4f0noDvnp84NU3NG+jjkwedOSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q9+Fmpy4; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q9+Fmpy4"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3f372839583so2517765ab.1
        for <linux-block@vger.kernel.org>; Tue, 02 Sep 2025 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756851765; x=1757456565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsgHYoXl8XEDv6u9usSm/TLGj9iq5mbiFJJ4P4xGJcU=;
        b=Q9+Fmpy4dndieky0PudmQdsl/stk6Q+AweMcMIyn91LFVai3hbIioaqyiPam+zolFF
         1MIlPvd2jFCkwAJUjA5BZz5RE4sjQL/nDMbwe/DdEVQEXlDmdDwn8mbvO9r/K5UltAql
         wr74LPy5kZqFye4b5N1ZVMTxsYu8PLMcF/008/qTIixLJ7CkbfzYJETZzh9HvLLibltT
         icuq7aDYXD6r2zmOJSSOlgMbVoeBpWb/xqyvNmI733UOW/lMPiKV739cPFcXnwzwmrPL
         nMSBZQ1PVaPcD/5SCl+CbSsnlDLjKRxqPyusWDxMMzWGB9VqqwmE2uyJncyYemKJ1cHA
         k5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851765; x=1757456565;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsgHYoXl8XEDv6u9usSm/TLGj9iq5mbiFJJ4P4xGJcU=;
        b=ska7ZnoWLpO43eQLSq3dd7KH9O/GkaSz88JZxUFMrX8b8pmrT5ovBzFYE5X5MsgKGa
         4+Q/lT3mPQw6RcZoy2DORTyfTXslMzPSN61ltpfaAkWruGPIF8YgwmjyE6fMsi0vlBc8
         kUuTsuLXyKzte7VnH29Eptg9h+A4q/uOdGFcApD8DxOpcEbH98kz3cydFnA39dcNCJZP
         Y/xYcaPHib/FinNfEuiShlMsxCU0r4BpykOIrHrvjrlLVb/bJvpEuk2+HfWWRyDB7p6O
         td17pih+TEpAlNwUdjYnGpe3mlf5kMbWBDSi6BbrF+1dZ3yIW9ae8ZVjA+4ARUuTce9G
         lIqA==
X-Gm-Message-State: AOJu0YyavTOYmFzlyDEQwZS56Uf+RH64oHq3HsFuOimJtfLrJNF5/iog
	LoBup5BaB5Exa15eUQ4UuF2/t2ZsDOR+ZqOLH9Ndfd0vu1G67JO22IN6qGghEX90XZM=
X-Gm-Gg: ASbGncsOKlKt7TwT7Yznkkidy2OynopQLIvjZnenq084kfScxO6nFScg/0X8dFGH4Vk
	sfAR5ht6MoyPhFY9QX+6qJVQMNoSm7q0q99GG/PLi0QA0roRUW4LDlu30CsoolqQZWS8s3BYGMY
	eWAVg6+J86Qy9REd+t+o5uDNc5jiURqJmml0IQ33yvpu6vogjtKhuyS3mCjfdF59H81K1OYd0t4
	FvC0y1NwBRzCna0eScbQAmAeJhUgl1BsdU56LOipgECoaJnIry4mkd2zwDRObaP31sXawPONnb6
	3hLbDf3qDwotvG9S5wH0PK7YiKVk0s9O8FftiCXZsBeoN1dsXmriGmEsVvLnltbN8bahyMC+f+J
	DV68biUky9c7OnFmuQZ+Ez439PYfnJr6Af6hOXqIwJu+FYjCFT8yoU1B/4tyFF+bs
X-Google-Smtp-Source: AGHT+IFfI7hKWtDAOl7ZVodkkOkz+AIezL3CZ2BrlZMAw59f9+OYjXiNDkBRRbyrOg6biAgWIE7oTA==
X-Received: by 2002:a05:6e02:216c:b0:3e6:7ac1:b8bf with SMTP id e9e14a558f8ab-3f3d60dcb9fmr225041885ab.9.1756851765148;
        Tue, 02 Sep 2025 15:22:45 -0700 (PDT)
Received: from [127.0.0.1] (syn-047-044-098-030.biz.spectrum.com. [47.44.98.30])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3e136b841sm45322195ab.44.2025.09.02.15.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:22:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
Subject: Re: [PATCH v7 00/17] rnull: add configfs, remote completion to
 rnull
Message-Id: <175685176380.67509.14270978539673986925.b4-ty@kernel.dk>
Date: Tue, 02 Sep 2025 16:22:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 02 Sep 2025 11:54:54 +0200, Andreas Hindborg wrote:
> This series adds configuration via configfs and remote completion to
> the rnull driver. The series also includes a set of changes to the
> rust block device driver API: a few cleanup patches, and a few features
> supporting the rnull changes.
> 
> The series removes the raw buffer formatting logic from `kernel::block`
> and improves the logic available in `kernel::string` to support the same
> use as the removed logic.
> 
> [...]

Applied, thanks!

[01/17] rust: str: normalize imports in `str.rs`
        commit: d5d060d624e34c6ce1748a157cf2391e49af2a54
[02/17] rust: str: allow `str::Formatter` to format into `&mut [u8]`.
        commit: 87482d6d9104d087935592ebbf52b70f8a777c47
[03/17] rust: str: expose `str::{Formatter, RawFormatter}` publicly.
        commit: 8c5ac71cf19bc8a2ad5bc905d1fd3191d887d469
[04/17] rust: str: introduce `NullTerminatedFormatter`
        commit: cdde7a1951ff0600adc45718ba251559e4d3fd7c
[05/17] rust: str: introduce `kstrtobool` function
        commit: b1dae0be89278348e2c99ddca820d91292856b10
[06/17] rust: configfs: re-export `configfs_attrs` from `configfs` module
        commit: 60e1eeed8b53f65ef7919fd3f79cc9b7f20795c5
[07/17] rust: block: normalize imports for `gen_disk.rs`
        commit: f4b72f1558be1e2b173b6b1f93c09dc668592a26
[08/17] rust: block: use `NullTerminatedFormatter`
        commit: c3a54220b54a1bda0662f0e7ab90ffabf5036d50
[09/17] rust: block: remove `RawWriter`
        commit: f52689fcd8a2f78436b57d10ba742455431885a0
[10/17] rust: block: remove trait bound from `mq::Request` definition
        commit: 8c32697c4edd4180bc90d367e54fb64490c230c6
[11/17] rust: block: add block related constants
        commit: 19c37c91b4a0ff7abfc3dcfe165d1377939469ac
[12/17] rnull: move driver to separate directory
        commit: edd8650691c374bdce133af1b25ff4f3496f489f
[13/17] rnull: enable configuration via `configfs`
        commit: d969d504bc13b2f0c1f208e009e73f2625b421c0
[14/17] rust: block: add `GenDisk` private data support
        commit: 90d952fac8ac1aa6cb21aad7010d33af4d309f4a
[15/17] rust: block: mq: fix spelling in a safety comment
        commit: bde50e28f7c5fe874112fe9d98e84873548fa8de
[16/17] rust: block: add remote completion to `Request`
        commit: 4ec052841a545297a276e833817990f0e13b1b32
[17/17] rnull: add soft-irq completion support
        commit: 34585dc649fb255b40075dab56af063c1bfc9933

Best regards,
-- 
Jens Axboe



