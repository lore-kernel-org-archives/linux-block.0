Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAAC3469F6
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158809; cv=none; b=jGZyM1dTJsttSPPklrj+shqi8/KzUk+5vofQ+Fx0kAdDKD22q25ZGM0bNyfRKI9pSKWqR68+Dzaa3JAj1HrksTkfs6HwMbLnkJnB0haGG+vSwowi0IQKRu3oGcQACCn6GTYG5fQyPume6TK32ugSXZpQD9PuzobcDNrTkfaHXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158809; c=relaxed/simple;
	bh=HVQ2ArHPSv+hA6H75CRJmZhqVP3elDD16Hqnk1c29RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r89EvH/6jg8QnpU/k9cNPAcrYfGXkYW1eHT9IC6jI3/A0AM5yt3eSpP+gXD88qf3/8Uh//Wwplyb4sbr/j/UWVm4+0mSggC/VH83kyOe05jAPOlXGSKb4PgsEBXo8xe1icuYdJqpTyiIFxKJowzqZQk+QPtIwSS1kHfsKgco2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee+xM1jC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee+xM1jC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48499C19425;
	Tue, 14 Apr 2026 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158809;
	bh=HVQ2ArHPSv+hA6H75CRJmZhqVP3elDD16Hqnk1c29RY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ee+xM1jCcsYYwMa/76KHjrN9TfQXYETYervkP5qjQ96emdLyso8ScE+83DyttG6Z3
	 KK/+esi25rKMoD960qF+XMqf1cRQyST4uOZMs0kVU+ZrCx+4YDE7YXZmnLNq0pvv36
	 W5PvllgW1Zp8y1bo1lwWvyzOry6WyelEZ4mZ+U2P0bxKA0C+vE/aaQVdrk037N0mMN
	 aw2855Iwrd/GGUwpFlrf1/ZfE8nw3OqYA+YMOZRA9asFj3rBYekq+xaA7FH7KwemRs
	 3wg4K81jvC7nNJBkBJeoGBs7AKPTfndhePUkWCzg5V093MXXVIgXX6NnPA4mjuGeAY
	 cTCqHjGLnekjg==
Message-ID: <73b2445c-992b-478c-9420-a179d2ae33fe@kernel.org>
Date: Tue, 14 Apr 2026 11:26:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] zloop: use vfs_truncate
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260414081811.549755-1-hch@lst.de>
 <20260414081811.549755-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260414081811.549755-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 10:17, Christoph Hellwig wrote:
> While vfs_truncate does various extra checks that we don't really need,
> it is always better to use a VFS helper rather than open coding the
> logic.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
