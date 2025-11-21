Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6490296BA7;
	Fri, 21 Nov 2025 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708718; cv=none; b=qHr7gq1NPeysd0+bx3sDKH/+GfZcQxFf44C73r0+ExI3zqdzufEwxaGdjDlv0LM+kX1ceLuOweLQm5/F7ZcHueHx9pQ3FBfFWM/SMKZ2e81kYTBAPTgblRB9F18dbKkyfdXVjD8/PMi7FSQAzDNmfGVMAafKJ3+H2WRLlTesHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708718; c=relaxed/simple;
	bh=TysMVlAgZHEtXel8Jzt/aImsWIJRorMNwBr5l76BKF4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tlqJuPG5PEwT6AlRoLO0ZzpcK5M3lSUu5SKSESL1BeLEhxlGYwVTFLH3gxwFplJ9pgFrf2xjG9EpHx2vAFUiuX/AQ0GzxT6UEKRtzFvfoBcUcgEyVaos8+TDF0AmmItY/WpafAZ8LD0GtoUh7n9WOaZpmBnNnUEVMyFugA5yiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=iuZ5EChK; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="iuZ5EChK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763708710;
	bh=TysMVlAgZHEtXel8Jzt/aImsWIJRorMNwBr5l76BKF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iuZ5EChKC6jkK2ZgKAj/po40+MehtuavJznVvf+hIzCg/x6d2ZCcsvOta1FfvmAsI
	 Vfa2DV6XyCotuOlzqyf8ywSN1YqzmN0792NUl2LyeNVJHIyYlhuv0joETvU5/df3VB
	 YaPlIo5f5MXZrKRD7Um5A+Y3jUD2WqPTejVX+ndg=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 147BFE15; Fri, 21 Nov 2025 15:05:07 +0800
X-QQ-mid: xmsmtpt1763708707t7bqn4l5y
Message-ID: <tencent_F47110578F73D23CE92FD0AE86A27F6ED507@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRsm/HvCRPm7mM+Z5Zf+A3jcMf6GQa7PngQWsjn1DVc4Zf3OmB75
	 7OyvzJR06jIr8MHHLn3oq/6M3Jl3C8d01YWHfGz7hCToWzPBNb+N34wwXUT199KOqgn5gajPlgXz
	 R3WEO7ARSCcJKjjqIDr7dASUlBJXheJs502RWtOMEka+Cl/f57mM7WosbBDrMUa/AawcHg/b62YD
	 +o6wWFPauYlknIME+pbUwY60tLMeWOnPaB8+S1DzPZQFJze1a5PM2fHBT3f8f9pBjS0m3oCVDidp
	 lT3crhpxpzwliIVuAWD9s2X4uHo4o5aOxQCQDKarwf7cysiDsb1it/yCK+oV6qcNUfpu/jx7W9Sv
	 1IcGqI++sM/adhUcCOS0HayqkhDmb7wC2QRTvNnZnCdyphw+6tUFjMM4A3IOzI9UnXDqwxJf5jGM
	 mvVi/5bI3UTQX7ovlhrAGH9P0DMracp8oJHhJ3HkW4cl7PMSWTH0lrrBlS+iIDonbF6iWVmPjnZi
	 Tj8/jyC61mdPRtBz9ghWbSpt44R7uHdiHMAkiyTKXQhBzc0GSJaH2jaGIaR0T7gFubEhKg9Y2y5G
	 hL67ayKpwrWCudbR+v8u2iNV7JjiXYo8OF+Orj06MGWl4cwhIZod+k2cIlU1RGp8f7heGs3Vx0Ne
	 A65aUJiquElqEoxFKnYPFLn7vfq4fyl0vcMgXegD7DT466F3vpau2oUxxqwubDSe83pIBdsJBxgM
	 jET7VJArqe3THlxV+0iksnNTNd7uzpbHMfpA4ufeShVQGfoyV5ZJETn5qknlYqBdGUTWJhWNXhxr
	 14o5jxV1pCcBRaBLU7U2roObPWkZxkHA7jljWIc9cq9GAolzMsCn++STrT/enbtncnFdPeKVllWJ
	 iTGHb9pBmoIRkcBS0HrTYMR9OwZtTH8ATuuAOYXSs115S008KyrDOf3XQI2HIcuVQTVHVPAsvneW
	 vnz++Uc6hyf267I1w6lYZ0kQ+VJSo3gslpQj3ruuwFsERHHUvH8y8s+YEy9ZxTtc5Upc6HMSP09z
	 zMQzx/1qDpbygL6sHp89lnZqlfZgNB22lvlatxLA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: [RFC PATCHv5 1/6] zram: introduce writeback bio batching
Date: Fri, 21 Nov 2025 15:05:07 +0800
X-OQ-MSGID: <20251121070507.2999428-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120152126.3126298-2-senozhatsky@chromium.org>
References: <20251120152126.3126298-2-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Nov 2025 00:21:21 +0900, Sergey Senozhatsky wrote:
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Co-developed-by: Yuwen Chen <ywen.chen@foxmail.com>
> Co-developed-by: Richard Chang <richardycc@google.com>
> Suggested-by: Minchan Kim <minchan@google.com>

I rarely participate in community discussions and I'm not familiar
with the processes here! I hope the community can be more friendly
to new members. Indeed, you wrote that patch all by yourself.

