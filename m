Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F361DDA18;
	Wed, 19 Nov 2025 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525388; cv=none; b=jce2e32RZPGmwnQfr3zfIH02/F1JQTgRvuICLJhvAVAYJwxAaaSt6YIttQBjVgrzbNwSUNctA5rnmMynrNfyXNMqPmgJuwZ1I/XbfbT8T/TyRsWgOVM2BJpLUFCwAKZDsfAix/DYvEtw+9QMVbkhGC5dQymRAx54OqZub32zSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525388; c=relaxed/simple;
	bh=H5yKS32BQuCKm8u+J7ZXZMVHHkiZ52CYE7eepE2wbw0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oeZVjAiikON9gfGB/q/H8L+bDa9pDSZ50ehPw2JCWNlJBvBhBMNTrr0e7Ow0RDfpLioCjsrKWILU4IN/1b5Hi4vcFrGJbNgP0bF5UwApBv2WLshcAa9AMaqZuWnYqKwLlPPTIOqAF9s3awWCJ7C+yugtwsxRKdnAKANc4VEB+Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hXW0B20i; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hXW0B20i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763525374;
	bh=Qi2rddwojXbTrZJFwpSOry4P0NpvHwP/7WohDB6ZufA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hXW0B20ipgYdpv947r1CjHIvPM6vXBSpPycfa5qAyjCpI7dvd9yzgeeQ9gk3ho6/w
	 UOj9zpW8j5pe4aP+/Op+G6pY5tT37XjiPUPRfDMvANveUwW+Zi3NXha2P/sEHfkcwR
	 W4buji8Ubz8VZYUg57V5yU9jU+4hvkrGGXrbzz9Y=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 25EAF47D; Wed, 19 Nov 2025 12:09:30 +0800
X-QQ-mid: xmsmtpt1763525370tx4vs152f
Message-ID: <tencent_ACEF6BA50BA908889B631CCED5FF1C244F05@qq.com>
X-QQ-XMAILINFO: MVa6T+CC+5BrANV1TTOpO4+KMwMRZVgcDDvc37ypycJMpmOOTVBOoZR3Y/zkdi
	 Uh764ZeAk2HDJesJr0Q8X86yHdtQNx/cNeFxpJS3G0dJskm9zAQHnjP8B51KDqt3Hto8NNG+69YZ
	 bYL3P9VS9rxgLCx7FxHDERRx0EYxKVSv11z+0Dh2cgkReA+Frj57wW9tyz2DV1H28HbWqhWIRqMD
	 cDddxysh1W5sm0Ft0c0MCj3KvJ8lpvbVz2siFbulWrftXne4O9Xg7RHQ7cTz0zmpJfVGCRL06Pk2
	 bmoPyoHQeLgPVtlpgm7niYUJWz90Z+dUd72ekvn5GokFMC8l2U6cpxpaOqQLpZ+XGpq7nC1p/o/1
	 UewonC/EN2vA39A7AD+U2selJb2XJ7LkzcfFKRQQjwO1EtHgEazP2OvkCv2ATV1bSxVcI9lkxH2+
	 GA7tkUdOeBoZLjXovMGjqbu2dA4xGapJw621E2LgiYQfQ66VyXpccEJAWn7VcTrhj3QZQtpil/Sj
	 obBxFBtbZaXU0hN6oH/340UDZ+HR92oQ0ZSwkd3lK5ICATHSPqidSBfONe9p1ZRb02Fc6mA4u5eV
	 pBpsM+n8qigsrroZ9utvho0mwttmC13VG8emmRveCnA0+xKBB0ckfr8M8LmfKsrEjTE8DenbYv4+
	 /eIc0UueSmZ07N4W1X89VKpR3vax+qrVt4b3rh1bwAylpBIKvGuoytkPDcs7TtfsDpQYaowXJVED
	 yg7CAW2OyCqn+NMitFGpKCzQLQZxVkE/ASvoiCRPkhNPyg/zDWzIc6VsITf158UWh/mEXY9di5Ab
	 8Zztp/icWhM6MjzmmWk6t9apuL3ei7N2eYHlCoI4qt0BB2ImuknrtZWWwbY3KJimpmXHjgbV99xH
	 JenkOZIO45o/dIrgu1DLdFUWnmBHGluaIX6JXugzMFa8a+SfTTkGE5S2Igsw8lbVl3H1nkwpsxTJ
	 QrQE5XQ0EHocKorqDN1rPlLUVRPkJ9hi+oFHgS+og0dwA/wDkNRrXcTH6VlF8UGmecik5wPT0dkU
	 O1B8zLj9Jafqzz88CZLF46CgJ0mP9yGy+xfiEVpLLWDPxfvlR+fv7B597AsxiOgJ7zrPhm0AKv47
	 iRIXgIoU4IqrMT9Lf8lvNprSbSemHAwly5r0MtUtJ86DEWF7o4pt9+Kdon0jJ3QVhWL1CNqEljO7
	 2oBj1JO2t2k7UlvA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	richardycc@google.com,
	senozhatsky@chromium.org
Subject: RE: [PATCH v3] zram: Fix the issue that the write - back limits might overflow
Date: Wed, 19 Nov 2025 12:09:30 +0800
X-OQ-MSGID: <20251119040930.2875269-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_C9BC3F2FE38BB1EBA44887FB683CD195E705@qq.com>
References: <tencent_C9BC3F2FE38BB1EBA44887FB683CD195E705@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 19 Nov 2025 12:01:57 +0800, Yuwen Chen wrote:
> + /*
> +         * When the page size is greater than 4KB, if bd_wb_limit is set to
> +         * a value that is not page - size aligned, it will cause value
> +         * wrapping. For example, when the page size is set to 16KB and
> +         * bd_wb_limit is set to 3, a single write - back operation will
> +         * cause bd_wb_limit to become -1. Even more terrifying is that
> +         * bd_wb_limit is an unsigned number.
> +         */

Sorry, I forgot to check the code format here.

