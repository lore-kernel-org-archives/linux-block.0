Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D82F7AB0
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665577; cv=none; b=FrQ0g11aEKikKza5vT0ctzxzHhxvbeY1spzYvGsyRvfi8GYGc6+dzx2Mu5/88uj25tuVbtsyr/U0h0Pey6nlLpj+U6YxSoeEJOvCZIwrRbvQUxf01+z6FBB17uV1PYGOGPuJpL6UslXgU0p+wwQahNBYOkkCuiBNAF89C7U6Eso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665577; c=relaxed/simple;
	bh=PlhNRBqqOdYaPjfLhcRPDV73rzC7fYT1YsJuvbN/Zeg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M0mt5Wm43ZP5B8aamBVp9+aiByJOqtWw7Gz9md8gwA3QQ9QGYQPsqcEMGTKMt5ih7dLN3m1lKDJRdnQ3jfNZSBuaI7LEXpz+lNBGLUX6RsJ3uG8/GIAiLjNcxvXPosXPJPN+dgNu9KW+3iU9MOx9H7rFtiiGUiAGbvVyL3qQwNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=U9oMns/S; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="U9oMns/S"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769665569; bh=PlhNRBqqOdYaPjfLhcRPDV73rzC7fYT1YsJuvbN/Zeg=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=U9oMns/SCRqUMsgtG7n4ulz7o8OCW4anuOLCq4d1yznPx38JW5gBO6AmzvYhCGq+8
	 7Nbpu/Gdu/y6JDSWnd6UIYsIr2fwbohCmIZHGKcaNAvhob6ULOtOwIkAJTjZKjrl1y
	 CYesFjMw0PIJWiu+WP6Z/lOwNPX1jNsqtwW8emu9BoqUqk45sGBgWikEBYkUtFF0x6
	 AEp3X4hchLA6NmsE06DfdJs2UieIUWP7wLog47rwDL4yfXkQMP2wup41sas48pES3l
	 ES2nXIYcVsmBNHIUaUPYC4iQ34CylXwT5PqYD2Am592krH3zjiDYfZLZbnuJvrys5x
	 EgapkuF3w+yReNYKOot3cx9jN481CGF5aNDE5BUg1/5d0mpj4njQqCj/dOJMRS99lo
	 /up7uB0fuwtBy9QDRqAQopnD74FytEZyjBKDIGPde6x35iEHoSa5Uqemu90dprYvGF
	 jwECMREIcQ0OaAsWLGo3kwASXQHQfnRHy8FL92ZtVS0vGpfe/oGBsUAyRBAr2Zvfus
	 oHWArD3kGfTcO/X+1Wt2B6HWqcRA2etasdbY0jJAASxHUf/sTbDmiGyxX8CMdlz7ZO
	 fFf9eA5vHhivxclOLUv+S3MvnBYKtTzpemBhKvR2W8qflF/QpVftHM5YcbOvN36wmb
	 rM4wbBhpVaEQFesOwJC1egC8=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <20260129031501.3403688-3-ming.lei@redhat.com>
Date: Thu, 29 Jan 2026 07:45:57 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Caleb Sander Mateos <csander@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>,
 Yoav Cohen <yoav@nvidia.com>
Content-Transfer-Encoding: 7bit
Message-Id: <4D5660DF-DE29-460B-90C8-F3800F6DCDC2@zazolabs.com>
References: <20260129031501.3403688-1-ming.lei@redhat.com>
 <20260129031501.3403688-3-ming.lei@redhat.com>
To: Ming Lei <ming.lei@redhat.com>



> On 29 Jan 2026, at 5:14, Ming Lei <ming.lei@redhat.com> wrote:
> 
> Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to suppress
> automatic partition scanning when starting a ublk device.
> 
> This is useful for some cases in which use don't want to scan
> partitions.

s/in which use/in which user/


have fun,
alex

