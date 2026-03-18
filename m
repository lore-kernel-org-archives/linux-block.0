Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37E1C84B8
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795428; cv=none; b=uHjRj72Dvohyw3HQGn11puOcrXMrpYe3MfUdoJO+lP7rP/sk9ByedRXYqaFjXKoE+6QzCFRHDQG7I1ZqJcHn7H++XokbA6TTeWIRaR5P5mfSJTwhTpqdVsJriRF2hEUu4YeLb5/IRQEL6NCUBgRv/nt2h2/8ZjzlMoWt+adE8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795428; c=relaxed/simple;
	bh=BbrR2yJFV3QE2pVvXjPV/Oc51nDEnob1bgUAljOu5qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPWJamaZlTE1It3J0FFckfMBfd73F01IAkmBZyv1nn+JTANGVaDaIk0BqRBQSCka9Dmt6iexsPZNPnMbVN7lIq+Bp5kQR8Ow6qjnyFCz+mRyxJ9a2KbXDRv8oYVd0gqtIqf2v1HHyyiMCH9Y1EfMPkVA1jVAqlg4pCu8Ac1cAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJG33wLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJG33wLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9F3C4CEF7;
	Wed, 18 Mar 2026 00:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773795428;
	bh=BbrR2yJFV3QE2pVvXjPV/Oc51nDEnob1bgUAljOu5qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJG33wLPwj3WjUdcpfyd8j6tRg+gqdtrGvXRBOP25HNsfbdtdQ9XbzlzW3wfA7pj9
	 NqLjqgaQauIRPD0x5wewDumvwEBVEXVSqiLLSUtZMOJEFjjnopO7qonduGURUjYqK3
	 YDydcKh1CXnEDbVRo7WQGL3XI+v0k/Slejkgxrv/NxBIt+aQuy3ZA3VzlFrBrErzHW
	 Vc4B5aoEYJFsXmA3Uq9NOirbb3r76SjcvO3j0+R2vYfCxiQzg4J968QcVug+8+B+gX
	 BzNHgW0WLyDJ8qSMyf++gdCzPoPquQmL4184FlAabces/Bi8XfoToU3VJwZhTImVKi
	 Ju7iWpnHwcjuQ==
From: SeongJae Park <sj@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] zram: change scan_slots to return void
Date: Tue, 17 Mar 2026 17:57:04 -0700
Message-ID: <20260318005705.132331-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317032349.753645-1-senozhatsky@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Mar 2026 12:23:19 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> scan_slots_for_writeback() and scan_slots_for_recompress()
> work in a "best effort" fashion, if they cannot allocate
> memory for a new pp-slot candidate they just return and
> post-processing selects slots that were successfully
> scanned thus far.  scan_slots functions never return
> errors and their callers never check the return status,
> so convert them to return void.

Makes sense.

> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
