Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539F3112BD;
	Fri,  2 Oct 2026 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921412; cv=none; b=bKYPCiPQl/hN3+5EgCN12vxWH+Cszs2O5lEz6S5eq6TBrTSmu/sGhvVredORIRNMyp3AJqnnd+KOfWaHg9Cp/s2SV2/MKPgIyqZeIBZHEmu9GivicPWuCIzQFjGKjH/Lf66JirrVBSw+m5Wod6LY5+Q4FpuQZr+wNN83tK/BHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921412; c=relaxed/simple;
	bh=o7rJJQgh/3j79IzOprTmpWJmYCED70PEfUJHJqo+FYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2CcggGHfwht46rLEmMyDVBseAIgWYjjXuWUTYM7kkSVOaHys/XZrkCD7xvm1A96wRHGAvALdi6OFxcvLyl3XzCKd4dQ6eKrnB7zFUG3iIR/TAl09PQoHchDw6Xq4gQC4rEaWyWotjWF3LQC9BE21/pESDaYLaKSrcDKoNs3mqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IugAGnv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IugAGnv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F7C1F000FF;
	Fri,  2 Oct 2026 06:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790921411;
	bh=de6fZJO19EErsSeBKDWDH3nqmW15NyYddlHGSZ0/gGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IugAGnv6n1YAUiwN+c2vWpwsoMcUdNyMCgWXd41Z/aLBLi0nl8BbCW1rYsO+YnOsj
	 AJsRgLocb0bUEeoGtkoGGSBsGr+pgYoj/D3FffEStagalGVABjA1mLMNaLzprgq8l1
	 UVgWI9EoAZicIpRHZxW3916fs2oIJwO58OpFSvjEHqnTODvQ8TSW6gAIQ8iARD7Vhg
	 v9NGxg6BpgzObSGArEk+H4bY4zDut6YreMBrU0yOETxqxY0Q2SLOR2tu54a6S7QdwU
	 hLiZlVVQQVUZv/L3qBIyCuVGwcVOz7qQl5pJDxh55d+1dCv3Srm1pVdqIAbH3cW1I3
	 RrBDQLP+tBO5Q==
Date: Fri, 2 Oct 2026 08:10:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	djakov@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add QPaCE binding
Message-ID: <20261002-ecstatic-crocodile-of-acumen-4a98bc@quoll>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-2-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930145215.3380977-2-georgi.djakov@oss.qualcomm.com>

On Wed, Sep 30, 2026 at 07:52:10AM -0700, Georgi Djakov wrote:
> Add device-tree binding documentation for the Qualcomm Page Compression
> Engine (QPaCE), including the resources needed to describe it in SoC device
> trees.
> 
> QPaCE accelerates page compression and decompression for use with the zram
> block device.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
> ---
>  .../bindings/soc/qcom/qcom,hawi-qpace.yaml    | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,hawi-qpace.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

