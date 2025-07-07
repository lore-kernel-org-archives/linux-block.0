Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1321E47A3;
	Mon,  7 Jul 2025 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912742; cv=none; b=D4dzWcwGlD65MaAb8qci4HKTaowf+5HIx8AVn2R3GoR8XBgoG6+TgsOj/4VYcOypU/CMyp5wTLmoHnJnR6KO2UpLCjjk7lbC4d9pUIiCCzwf4jYPCmWZ9MhdOGs3unMKVNlUNexzcW1Ox0umCA/qj/jpa5dPgOoiuHY6d0tiv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912742; c=relaxed/simple;
	bh=anZp5DdyOR1f8FLHZ4XdqcWK+2212BKfuyZE8y4g9u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbhyqSICQXoP8XLfkMEP2iQcPCYR/INAeK0tQCeQV7z6bLzx8Ox52vQ1K0ie8nFIkVKC8uBf9f6LZHzFdnbnk+FLxyS147F7s7Md1JMaOkT47H/YKnWYjQT5ZYGO0A2iL3os/MhI4hYzxYMaBU7rNMnoNNskGZzPF78rkyjDbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzFub007; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzFub007"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31305ee3281so688992a91.0;
        Mon, 07 Jul 2025 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751912740; x=1752517540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anZp5DdyOR1f8FLHZ4XdqcWK+2212BKfuyZE8y4g9u8=;
        b=EzFub007CUHGqIHK6MfY1dBZyRYDaWlIalwMUiD2ucjZSEHbM1WuyfYSQYUuTmqtxi
         UAvA0KrYNqLrKbS9GNdmdMA5GsTtIdlbnK5COLY/TFOECv+cOasVr/LtWOkKrBJcGi/5
         D5wwA7azJc0wPvNMY2o4conbduPgwoGG557DYuJQf6BsalAiCgFBdahKQnVrDNKEzCYH
         3KgYgNa2O1yN1SAncN/ROPweigl+yXiQM9DsLvIB5Y2dL9PaRbzi63V1W7SPQ90OouA7
         BUm/idaaEuoMn3e/wrQOl2pobLY1HXpqKqFjeOa3ULpn4Gg6N9tLUsUpwLDI00kxJ3gK
         3P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751912740; x=1752517540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anZp5DdyOR1f8FLHZ4XdqcWK+2212BKfuyZE8y4g9u8=;
        b=t2B9ng9X2+Z3IP3P84NnaT/JnAF830JUTUg/6QA6FMSrxfF4h6HOdYpz0J7WBG56tu
         K75qMecGP04NSypnnAdAZh8gStKGBKP3ZocAK1O5OOaXOOI6axMjzAXe5GRlYoKYpy6D
         QUP/geMvjNp7YDpK621GcmF4P/u8zlgb3r2vZEnqyzjmv+NDy76b6Q9RVwbHbAn+dUtC
         CWLN9X8h1xSr1m2oOQWNJuatgBQCgz58bDtswyTVcGu4VzKo4eNQL+AUzPnk3i4lVxGL
         kZJkgtFGB15WkCCzF3t85eQPU8Pa/Fm3MPUakFZ7zix0GVtkAgtKoyyqk1f0LX8Te2he
         iMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/BPdk7SB0rl0trnpELWHxrjmfXW6dn1q12Lw8I0h8yoc8HymFeexL2eAmqSr9/0K1nn1yCH0bR1uiMWPt@vger.kernel.org, AJvYcCXFFwTDY9qy6z3qdX3SXNH/i5ow6qy9cI6NSYRzazfjlSJWOPq1CWD8DBBSoIPwG/dJPO4hGWdjAeh6XaXsRNo=@vger.kernel.org, AJvYcCXXuGeAu+lwRhuGbCQ+81z90nZtpZ6Nf+9/iqxHZFI87XF8sUFjqsUE2KFD7aeoXv0/EKKe52LUzSAPrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRlCji3VcZzW4ldvWrRSxSYw0zvBiTuhMUfK/eV7OrE0QsviK
	DMDQ58pZqJFBC8SDsiz/MX8hWExL7SqtrGBPzPoQKk77qFJDVnLAybHUK6qkp+IRUTsh5rsK/fg
	QmxjOAnQeEnokVrPx1hTGnTPSP5Ud84o=
X-Gm-Gg: ASbGncvEjtN5tUyxkzCY/VxGUiUNaJJ5SVON17Kboz/kW3Zv/qVMnHqh+bN3z0/aZaf
	cJ6gS//xReBruhLkw9R5SuPkbgh915uz2EYXSWTx0np+/re/vkWBqymyT14PdJhQkoe8rup4yhn
	xqXImVG7YCXEjZNg3T5S4fij+GhGzx6WMAMJ3e+QfM1dO9
X-Google-Smtp-Source: AGHT+IHKKiclk6LnFYU4xwnGBoz1P28AKtkC14eS32bLf+F5N8snKmGqdMiJVaa10jQj/25gyuU7OEoCaS/GnlBT8QQ=
X-Received: by 2002:a17:90a:c105:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-31aaccdb82dmr7759682a91.8.1751912740163; Mon, 07 Jul 2025
 11:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
 <20250616-rnull-up-v6-16-v1-3-a4168b8e76b2@kernel.org> <bpbFNIoKHyMEJSNSRBaq96hzfyrWNtFJIotbYdqEAcPhLhPf_sg-1kNlty_Uj-1tPs0ZQHcGrT-wlVRHYbANqg==@protonmail.internalid>
 <CANiq72nfeGwm17kp8OsmpgO-U6xMsuL9KBNwX34Rt1xz-Nxa1Q@mail.gmail.com> <87o6twoxoc.fsf@kernel.org>
In-Reply-To: <87o6twoxoc.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Jul 2025 20:25:27 +0200
X-Gm-Features: Ac12FXxOBYHlumDpp_OJHopwJSbZRBul7wVIj35x1jwdWWcN77DVEbOMGcX1RmI
Message-ID: <CANiq72kcR2Mct=uTzDQrWzAFOePsxG8Y=pS_6aGocbAe+Xaimw@mail.gmail.com>
Subject: Re: [PATCH 3/9] rust: block,core: rename `RawWriter` to `BufferWriter`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 4:58=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> The null insertion at the call site should be removed, it's a leftover
> from before `BufferWriter` handled that.

Just in case -- I think that if you do that then you would only get
the null terminator at the end of the buffer.

i.e. the one your formatter (`RawWriter`) places is really at the end
of the buffer, rather than immediately after your formatted text, so
if you don't have the one at the call site, you would end with garbage
in the middle unless the disk name fits perfectly into the buffer.

Cheers,
Miguel
