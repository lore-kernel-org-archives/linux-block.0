Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF683CBE97;
	Wed, 18 Mar 2026 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839013; cv=none; b=UBATo7Uk6oJbIBnvCqG8npBAlXOdkxgA2adrIel0b+arTLCeLFdUZnHgCEKuAsSk8+JYZYB4kOVHRmvrkzYtROLQCH1+fbEF73QgDYaYwUKRRgtzfBcegHEpiTlaVrMMxtuDrBoWmyYvX55QVbucYPWX6zSk82q9/GDY2sQh/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839013; c=relaxed/simple;
	bh=bRy7rDK7eF3hv3Haa5YwTOZ6mEe35vz0YQ7rtZP3VDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQvPruwUAb+SukFyBWeSTtu7wsP3j73yp4FbvjUU3cv+XOBDBaQMrMigIpo+sMDFuISv4wslMi4At5V0lHcPLbfj+ZoIjgsrkLi0sEQ/ZRpVbAiXCIUHV2SkBffpcC/xdDkx05VITdNljc0IF6faMULJ0vCmyVl5TL2H070s1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1lcPZBq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1lcPZBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0516DC19424;
	Wed, 18 Mar 2026 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773839012;
	bh=bRy7rDK7eF3hv3Haa5YwTOZ6mEe35vz0YQ7rtZP3VDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h1lcPZBqyrITBMgQvR+OtgU0rl+ZX+dOVjSD1htZaJxXfzSTUi8N8SbvH1LjayMaC
	 KbJ1sNSoSLrKSv+aLKv0PiMJF3PxvtBXF5H6ToT4DbZBtQt0azeCult08MCBsIfGXJ
	 fry810h1z+YDSISUwK56fO/E41oNdO5S2cdcYtMyOWAEYmglW+MY6KbGHXGz3N/c/e
	 Ijwvvcn+C7/pG1+Jw7/eNeP9W2GZPT7cOzGR1HgQtQFXljeSxk8J8IZ3OtxeSVDB+U
	 AvSYfK+kbsCIWJT4cJfvC+ImdqvDv4SuV7sM8GAtT+0zWThR+9yZPWMlPCdo3fFdWk
	 BoXggWeqaf/hA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: =?utf-8?Q?Adri=C3=A1n_Garc=C3=ADa?= Casado
 <adriangarciacasado42@gmail.com>, Jens Axboe
 <axboe@kernel.dk>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Adri?=
 =?utf-8?Q?=C3=A1n_Garc=C3=ADa?=
 Casado <adriangarciacasado42@gmail.com>
Subject: Re: [PATCH v4] rust: block: rnull: update to Pin<KBox<QueueData>>
 for PinInit
In-Reply-To: <20260317193257.13848-1-adriangarciacasado42@gmail.com>
References: <2hK6oarCGyUX9gXNJ6wZZoePYLShXTYjw8wOlhbW1szik-km-pMO8wtX6dgm5i34HLG2zxzqZgK-cb2MiDtdpw==@protonmail.internalid>
 <20260317193257.13848-1-adriangarciacasado42@gmail.com>
Date: Wed, 18 Mar 2026 14:03:22 +0100
Message-ID: <87qzphqoh1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adri=C3=A1n Garc=C3=ADa Casado <adriangarciacasado42@gmail.com> writes:

> Utilize the pin_init! macro for QueueData initialization to correctly sup=
port in-place initialization patterns. This aligns the driver with standard=
 Rust-for-Linux pinning practices for driver-specific queue data.
>
> Signed-off-by: Adri=C3=A1n Garc=C3=ADa Casado <adriangarciacasado42@gmail=
com>

I don't understand the rationale for this patch. I already have a patch
on list that pins `QueueData` for rnull [1], but not for the reasons you
mention here. `QueueData` does not need to be pinned if it does not have
any fields of types that must always be pinned.


Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/r/20260216-rnull-v6-19-rc5-send-v1-13-de9a7af4b=
469@kernel.org


