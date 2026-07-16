Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6C1414A24;
	Thu, 16 Jul 2026 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201358; cv=none; b=hUVdchzKAJpM5+6iiycg+/pYTMT1WMvF+v4lFw6g4R5knkzJPAahGzNptYz61Yc29zFhwcv3PvRGFSKhXlr+wUpaH2AMzUKHn9dERJZMMwTCJO8HSL/uZF+wurpGQ3N1rb8nAcqNoxxpP1Uv93kMs+DkezPDEbNymcc9/uAOql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201358; c=relaxed/simple;
	bh=0GytaacYlDvdWb2ywGjZKPboTur1UBrCTED13JD4VTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNuc2+VDdiWe+2pVvVNmitssknbTPzRSoOjN8tDuYoX57kFfumS93T1Lr3lhXp+2bo21eeeEtR3Dxoo9ocFInfTZ/I1mzyLa5kB7zzevv2AsmOQaoKKESD7aMzH+XZ8I2R2HJ++CxcqjQk3RgzjjhR+hPG5ZkP9hjowxQuAyIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb65UE3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb65UE3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E56D1F000E9;
	Thu, 16 Jul 2026 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784201357;
	bh=kXn6gKsQ/T+UoTepvhxsMwoxK3YyU4K87HgN4KKxL6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Rb65UE3vyfsoCDnyn9w0Dt/lHkT1IwTr5LtjG2Mmmk2sg4yOzZYusY+0BUZskI0AZ
	 9HZDv44W2Z7o6NEhk2t8AsokgA+cWcxQq43nCm/vFJ5VFhQnkfY+4VFV6t/n0D6BGJ
	 4XA+iu3eubUwGgaR7xGZ1Wx+ehokirTLSfvbR12+2puHP+MvJNK1xmki9h/IOTWn1d
	 nRw9GgPpLVr3ZcP4Jgagyg/OgxJXNDyWptbvpvySVNUncf1D3Bn+A+4yFnB1BYaOuC
	 kLSuSM4i/oSwn2VdGdithHkXr/q0am9HSq1G7ve5gLrVtx53vLU0XVNDns9fnHdXPz
	 +d6WkQXJg/dog==
Message-ID: <cd17977e-11c3-47c9-9837-b97ebe567cd9@kernel.org>
Date: Thu, 16 Jul 2026 20:29:14 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] block: also reject zone open / close on conventional
 zones
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20260716091838.318082-1-hch@lst.de>
 <20260716091838.318082-5-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716091838.318082-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 18:17, Christoph Hellwig wrote:
> Just like zone reset / finish, these only apply to sequential zones.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
