Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058F282F29;
	Fri,  3 Apr 2026 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180488; cv=none; b=NFIG2b1QyoUsGyp9Um/R0Udy1dGCYL7Z+ehylOyelm2m8pytLc8FgCk1tmPNoqCoD/HzEFiVUmNErUDdaFCpsn4WvAT6jBtpARN4ajC2RUWYoPcD9hflGgsf32wyptSaFOp1odC2yN9koUFA7lLJOUgn8j6SjO8vyzdVGRXnyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180488; c=relaxed/simple;
	bh=hBsFtqeDYyaEnd9WAUBXCv3Q5emZDStJq/G7dk8rzWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1jI9InoN0kPGwECuGlLr357WRQu0XKlbjpxTShEiqLnP222Sp2Z+bIlYieJN+ZNiy6v90h6aRS5o3e9nyJC12DHhZRB9i1yXgX58wpeH9g/FlK+eV36QyK71FpPjs7BJyo4allXiBIbhZ2UW/ZiPdoUdSF6fHEkSc17HK4mNFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOHYU/ps; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOHYU/ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD3C116C6;
	Fri,  3 Apr 2026 01:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775180488;
	bh=hBsFtqeDYyaEnd9WAUBXCv3Q5emZDStJq/G7dk8rzWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iOHYU/psteVXjTqY2klrLcP4ZT/agIeBwQfjmbemwaldELrAOymkJf+HEUC7jqw11
	 ByvwrN9QqL7WnSU6IZQgcuIw9Mm4Irj8yl0WZcMH48mxXH67XEhFP77E5eQUZn1R3H
	 2Bo+mWu+8vK5b9ooL/CzRCvnrVpHuC4IWbSjBJHAD38vn3WWwTlNklN03yqFIxOMVI
	 aEAzM1CNfLXsKEIUBMl2OgoM+KNtUQwMbuGPPS1Ru92gvVe46rjgsWdhduQ2jBp5lb
	 Bp4K5EwpnUho2iMvm8ALkSnil8DgWVVCRtbSysRB/IrUP0BNXiK+Dl5YQC0Nf9r0Co
	 kxVRafPVYJNVQ==
Message-ID: <0650ad37-2c6b-4134-9eaf-c0fb5cff2f26@kernel.org>
Date: Fri, 3 Apr 2026 10:41:25 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] block: use sysfs_emit in sysfs show functions
To: Thorsten Blum <thorsten.blum@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Kees Cook <kees@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260402164958.894879-4-thorsten.blum@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260402164958.894879-4-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 01:50, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() in sysfs show functions.
> sysfs_emit() is preferred for formatting sysfs output because it
> provides safer bounds checking.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
