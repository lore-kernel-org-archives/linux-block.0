Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB72139F;
	Tue,  9 Jul 2024 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503557; cv=none; b=A7tDbB9w2AbBBTdpL7b/sxZevjL70rJygAvkAtU7OrzuYgWR1VwPEvfevPgQALxRkCJAH6MNAAhB4nRZCNPNFmQFnHt2Qtqlgv7bwqmDDvfi6XT+ZYZ59jO2tVykYEA93nF8k1JJuHRFRRkWsIfvlyynVOwqteOL0t0DJYGpo6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503557; c=relaxed/simple;
	bh=9qdcXd0ZPCG0kPhlwtvxEoLSxaEjVaBTdCTP6/3uKdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuTHGTMnbGpCgdqOG/oaaZyV3/pH+pKDjMNyECFE3EkAgeA2GMc++CZuUhRgPdHWJqKfE7tBnjZjrKoQtFOW9c6Ej4BUlDW7QcXBvhAd14ETWSEXt1Eif/nr4bmm3dn+rUS4/TBv70ju3TyVbB6PpdqvC/6PeMmR0fumfaywTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDEplAfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDEplAfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69477C32782;
	Tue,  9 Jul 2024 05:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720503557;
	bh=9qdcXd0ZPCG0kPhlwtvxEoLSxaEjVaBTdCTP6/3uKdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NDEplAfZS9I9EjAbXnMbcbKXNn42b4R+pcOA1SQ9sV1kcAN63F65J++w4qWS1HXml
	 capltOqGP5Q0ds3gUuq7cxwJq1j77wB3IS8PLiLJbp2hJw77B+EPrScfcN4Hf+zRas
	 p+ixaYkO+wRCzIC8KsUVmmai3oPLNRalLqQzVNZBiKR9gOpWAoIDeVBYKvGN+1aIPa
	 WD9Oo48jfdWWtZyz378UL4EHMlBf2LsXWixXQWE43f/JXjNdvm4mr3jd9ftTSnGKek
	 qPtSRlznSQzHAtFrqLp5QxBh3ipowqdb883ysUEENXRoP2zA4d8M00JhKF7MfSKz/E
	 XrnPbknE6bxYA==
Message-ID: <46209467-cb51-4c0f-83f6-137d445caca9@kernel.org>
Date: Tue, 9 Jul 2024 14:39:14 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] null_blk: Don't bother validating blocksize
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de, kbusch@kernel.org,
 hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240708091651.177447-1-john.g.garry@oracle.com>
 <20240708091651.177447-4-john.g.garry@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240708091651.177447-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/24 18:16, John Garry wrote:
> The block queue limits validation does this for us now.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

