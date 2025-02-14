Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19DD17E;
	Fri, 14 Feb 2025 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515275; cv=none; b=LniNbbhFhluZNhI0j+/5YIGBunsMxQr0BUxVlj2RvoNX5QpoRhQLfd43kxBZlDs2ViKrGdZbXTWU3QxGezpIk2qJHbCJUVKEdMbcVNAT5xq/7AOQoS5EDokUWu3DodEJAMZINCA/fXm48ISQHKK22MlY6T1nWYNPsL4cKMjHG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515275; c=relaxed/simple;
	bh=A9X0IPhsOquXB9O+JtBUqY2Irt6WYI5xfoWG4/qO/vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jTlBh0wkACcUlHm977IfuLRcfIqjf/SFhgdXnQwn+YnxB5tQTRY5cce2/F4dWrJ5qiUGj24w6lGjovpln38djqPwNpyYCie8NdiDm2suIOAVjOiNwSXHfaT8vBviNkDM+eeGRf+rQVbvUw6h4ZEgl+6ESg1/h7jp2VRjGz9zCzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7lVuXwH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7lVuXwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C368DC4CED1;
	Fri, 14 Feb 2025 06:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739515274;
	bh=A9X0IPhsOquXB9O+JtBUqY2Irt6WYI5xfoWG4/qO/vw=;
	h=From:To:Cc:Subject:Date:From;
	b=h7lVuXwHiYm/E1jZR1+Qp6RHRSxpHlBqI9Q8VoJlbp8byg/nrv/kWaChK2/CULtUX
	 YEdi0QvUY23zZV8q/Bhhg4sXyoaQezNGJUkgLDKBjLCc2bWSrlVviEiZLX6cvAu8hc
	 ctyba3vY7ai2RM3jCYnc9vvCq89LqwP6C4bp4kGZ4AvEB1VOre40BCnZDWeumY8lZU
	 uXaO7NU9GpgkKPtzzvXHujHWsemexbRMGr7RBNkLcEG4NvBU1H61Hxx1/zytaD9kbm
	 9Hx4/ff3JkwPdSupgyVvHoqi8AstNMgmKE0ELdh6hAbNauve+EQVFs4QgjQWDPkKDu
	 eM0Z7wYc439rw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Rust in FS, Storage, MM
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 14 Feb 2025 07:41:03 +0100
Message-ID: <87ldu9uiyo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi All,

On behalf of the Linux kernel Rust subsystem team, I would like to suggest a
general plenary session focused on Rust. Based on audience interest we would
discuss:

 - Status of rust adoption in each subsystem - what did we achieve since last
   LSF?
 - Insights from the maintainers of subsystems that have merged Rust - how was
   the experience?
 - A reflection on process - does the current approach work or should we change
   something?
 - General Q&A

Please note that unfortunately I will be the only representative from the Rust
subsystem team on site this year.

Best regards,
Andreas Hindborg

