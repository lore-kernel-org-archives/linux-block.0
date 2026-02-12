Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B061519AC
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919422; cv=none; b=l51K8deJCrNdyZoTAVqIsC0cBwHRJYsSs/qubxzseNF0EMQ9Ad4OPCwgUSgCaZp36RRd0X9deMQ+yg8GChMV5MPRaNs81p62iqfWZNXrS5D8nuGMOZ6wHyevWWUn68RmKFAE/LFfscCTtqCZKno8moZ7EtKRjpEpZbTE0uQq4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919422; c=relaxed/simple;
	bh=uRwSjE+Q5XR2OJRdIpJVCmNWXsDiCiCMyUxyzclj5I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxB6StlkOQ3AVX4Q83uCezSDUGb8YhFlp6AllOvS7X7zAp7pqspVhUmtbvhLOs3d4yG53vOAnz/4Aa9AxXdsQEiYmvk8d0vTkpO+htudJiJAhkroqJTP424fthx3sc8V3SyNd96hoQsxll9OoQ/Tx34dtx10R8/2AA/61+WzAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=SyVqoOie; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="SyVqoOie"
X-Virus-Scanned: Yes
Message-ID: <c95b3de4-f4f8-4b35-a3e4-a83da98ced0b@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1770919416; bh=uRwSjE+Q5XR2OJRdIpJVCmNWXsDiCiCMyUxyzclj5I4=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=SyVqoOieMSI/HHPCcArV0za5c8GMLhVhz2mpu3Nw5GHfkagpzQK5JooEueMt2kd+k
	 2weRM9uVOcVRp9kcQmU3Gxk1FK+kzaFjWz/80pRN1CeqMyO3IxLg6trQV8nxnF1CvH
	 zlgPfD4HdOHNfRL9FyIIQnjX5Sf/gjVqeDs08CU6+1bGXVTnTu8rfGC9upSUCfi0dA
	 OAakLsJx+GFeouy9HzF3d8AQVrYC16wpn6vMz4SNey9bPEEb6h0fhaESq626Z2D2GJ
	 R/A9hO2UNFPKyW29ILNMSKEUAg9Rigng6lQVaEzGgtEFpBZdhkTu/0iT4Lzef4YW2R
	 QZWwdO4cm++YKpD65NVtAiLZrMH6tP9Xw8XDLhsUZhORQDNlMCkPMU0Vpb4zOnT1r8
	 tdDatd7LOzjCmMu/shpGA1Yb0ri+qEs2F9bjGWitYsZbW9hP/eFNGUomq1qUCo1wTN
	 eTpIAXCgExOoBJIczoA9Q1bKayWftU+9XzpZRM/Gq6gOqVa6DBECDAaVWv3HH9JPdr
	 b5rVscqFnNqNrhqQwiQy52k/RIUhXlb7TNDvZ5aduaw7sBKPo4JUenOLWiAZb5q2nY
	 oSG+WoXE8gZ05RIoOgEhfn1qud6Gcz02YYD22GPfQCKgDsV2ei3UpC6ndxLyQF33Ye
	 ESXlkPTAd8gk7ZXLjKlwoNBc=
Date: Thu, 12 Feb 2026 20:03:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ublk invert part scan bit logic
Content-Language: en-GB
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
 <9e656591-a57c-474c-b3dd-8ee1f75ca9a7@zazolabs.com> <aY3S32Qotb59tAik@fedora>
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aY3S32Qotb59tAik@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.02.26 15:17, Ming Lei wrote:

Cooked up a patch - i think i've hit some of the points in the thread.

https://lore.kernel.org/linux-block/20260212152553.1737373-1-alex@zazolabs.com/T/#u

-- 
have fun,
alex
