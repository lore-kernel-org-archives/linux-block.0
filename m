Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3A17BD6;
	Mon, 25 Aug 2025 05:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756100513; cv=none; b=h38AQZosafu6XQv/PPBABCA3g6WvBbkSLcFJYuPSvRmkCdpGGzqbb0XdjZvPRCd/VlbFPCElEdQTSd4JruYRXNMRvZjZq1ucc/mTJfFnKinJE7C55IWJkY1lIp+t5bEQToo1FeQFO/IL1UlHn0kyvq5L1sjXROCaBUWb7jguUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756100513; c=relaxed/simple;
	bh=MnZiu7fXrkM6+MnglxgLey/FjF8ZRA2j7g6c+i2mgeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxyhlj6bqyV7r3gZPA7xpCQ6i1RmjgekJV/sBzTz0oEkrKVy92YdYorHpQc+aBVYpHz3KVD8nM7QmUDNyJRguTXA6PbXL32CQiFZKSYoa7+xwijqYbFdgVS6SVayJphpkDQLNsQkAbJci9uBFdBUnUToVYdNpF/VOZdk38B2fnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSFGaveN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSFGaveN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-324eb9cc40aso2952970a91.0;
        Sun, 24 Aug 2025 22:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756100511; x=1756705311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNqmPCrc+HXWAXDIRkVQuzgw6NMzo3YWapK+gmBm+rI=;
        b=gSFGaveNVS6/u50l/oaep2COXNPlS1dBmurY7HWN4HlPuFUevakXnfWshG17xi0j5I
         uFKEiy5TqcKzdAi1lzfOnw39w2avvEGh2CQVryQWhtL65lvCwWpBY6eCmmDO3wSrvPLe
         BUJNkbCfxdlsBfAgyM0JRmKY74EgkjBSLmtixs9Ustv+wAb9N8WyRruYNrOAY1pwNok4
         VnGtaZ6lQLcZ7j7v3fayMNa1zGOgKzGfnZ1gY4hp/X7iaMPrVwiEsqOXScI7RkTXy0iP
         QO2+XzW5oT2x41KZL4S8CIGo3aCE+IQYuKOXWupUF+/Mvn2PvKw/puqG5z4ejmk7AYmN
         ce1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756100511; x=1756705311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNqmPCrc+HXWAXDIRkVQuzgw6NMzo3YWapK+gmBm+rI=;
        b=OeTf4uBMIVlU/+gvIYsNSdzTS4L5gy5+4vFtnIJUkaXL0FvHdplgDIoiX3io5DgLgy
         7p55GbcMmQILOgkTbaw5j6OPxmcy8cqgQFIdqh6qH/q5PHyNZwpuJg4xwmRii/9kmizO
         INHE6InqvDsqgOC4LJFw8JMyD3kuzQ+0ZGDuqX7SfcRI9MTMi47xst2zyJoJd9jetICz
         v57Ptk2+9A4mOdTde8zsr81rK5gmuuV2SF/dApkR9kOLRut6uiqlAskISWyj1XixA6y4
         U0kp8xWw/eobtzdTELJXzOfFZNpeEHlR7Ndz0+Gwobsf9o2dpxTnH3rFaI9MpKRnrw2c
         TEew==
X-Forwarded-Encrypted: i=1; AJvYcCUsbUK6rDioBAHjuCuac1HxW2hyG+q1YwWUVG9l9js9kvs04aOUJErD3kLdqGAT+wsBl25Xqz11lMJ++w==@vger.kernel.org, AJvYcCWQUEom18unX8YpQS+eVkxNZ0QnFVUBN2IfUTar/2vNnU/omRaoIHml+2OCMdhIIXeQ8zvgMG14h9yb7cY5@vger.kernel.org, AJvYcCX8LAGrUxaBE27I/D8I2kCdLy1cdFThhMlTh83owrUM9IRukXO5BqY9DxH4xAtvMU/+iUxLPfYPewr3cRziCMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtlDY1YFSckrDilI+U2iwM+8QUPr2rpFoOU39thT7CVRbOu/BB
	Lk2RqfC1RDIO3oQObUi0B78tYJq4YSx6q/AZX4xZbtJd55HRaYZpL7B1
X-Gm-Gg: ASbGncswiDKFqrLQ6g7UtzWqhyUxWjiP8ElwvO8lvmtgTBuLlBewd6BiQETaB/doebT
	mJQQkvcFWU2wl+PIza1llFQBBllx+wg++kPGpG9zQuE44XDviYRtmu9EDNYg0s5KmmFVY8AcYge
	QnpiBHimZQ9I8U4VIjt3dTgmzmyG2OUpnz6P6fI5XcOggFGdn4ku1d+xhPADQ04AZhtRWtLuiW9
	BJpqgf0rQbbRrCOvJpmic5boAyYSOByS2kJE2CNSYFqYn3VUO/jwwIzCRf8TcvV0CQ3GUVmH5fM
	OL/6FOW1h4Yd6kqsTf1SaR+n6JV4XvGPixeD0jKneHwuKVninGzgU0d5nlWGXiUOsl75jzLbTzF
	nUEZdOpbVRKUFWvm32uwAT8cHfUWswOs5ioK1Wpze1x4=
X-Google-Smtp-Source: AGHT+IGY58Ypohz2bYe1bBZh2q57Dq1fev6swoKD3WIWeo6f/8JKG6e9vuIpZOUm322P5Z4BcaQvug==
X-Received: by 2002:a17:90b:14cf:b0:325:6598:30d7 with SMTP id 98e67ed59e1d1-32565983322mr5164426a91.16.1756100511144;
        Sun, 24 Aug 2025 22:41:51 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:408c:8785:5427:408b:6413:d449:110c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af4c347sm5804475a91.18.2025.08.24.22.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 22:41:50 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
Date: Mon, 25 Aug 2025 11:11:41 +0530
Message-Id: <20250825054141.56262-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72k_+eA259oEq1fBKCOVOK+2GCAwqF_JfweJ9A3ih_Px0A@mail.gmail.com>
References: <CANiq72k_+eA259oEq1fBKCOVOK+2GCAwqF_JfweJ9A3ih_Px0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Aug 11, 2025 at 12:44:01PM +0200, Miguel Ojeda wrote:
> On Mon, Aug 11, 2025 at 9:49 AM Andreas Hindborg <a.hindborg@kernel.org> wrote:
> >
> > Jens is picking the block patches directly from list. I would prefer
> > sending a PR, but that is not the way we agreed on doing it.
> >
> > @Jens, do you still prefer to pick the rust block patches directly?
> 
> That is fine, if Jens wants to pick it, that is nice. Otherwise, I can
> pick it up, no worries.
> 
> Thanks!
> 
> Cheers,
> Miguel

Hi Jens, Miguel,

Just a kind reminder about this patch I sent earlier.
Thanks a lot for your time!

Cheers,
Shankari
