Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99FA1632D7;
	Wed, 11 Jun 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655512; cv=none; b=tl9/qmmYjt7sx2W4JydmwPsWqS/iIkjI7sw/gTgExWvQUCYVYcYVdLv5B4CmNAHjJiQXJbvYdJqNiErveoDTrE5l3fw8fkWzegHhHNBjslQUBEcP8RY0cgg1VA8jox7bdxYfdrhaGfXp++OHebOHi2pPbzwWUP4C4vEe5wFj2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655512; c=relaxed/simple;
	bh=o/kCCEam7x/8zUbez+utqgmB4o0YyAg/VynA3QdbuUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aldk+SaHypSJuBD9gWKhwb9asiAKEI/f/fsAxbDT3sHFFV5LBdjYLnz+t5kaeO8SZf93QagDAZt3NzgZvbOVxE2fmjg6BQNqVYOrd72i2AiY+K/AK796xOYW96vOMNcWFnfnW/fUbAAi6HvyC7D5Eg+UZmFnxPmE+8sQnMrXsbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jLvq96ou; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jLvq96ou"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bHTxD0shbzlgqVW;
	Wed, 11 Jun 2025 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749655500; x=1752247501; bh=o/kCCEam7x/8zUbez+utqgmB
	4o0YyAg/VynA3QdbuUk=; b=jLvq96ouC1EYZUeID7YXt/1M0bRSdf8h86uWKZ15
	XLti0O5Fi53JDfmOUKcG0jpc5nKew3nwtrGwMuQZolHZkXs6c/XuC/8YwyedvObZ
	rKLY/4gXm47PKauc+uXhsGCwOuMNz/170pJ6OM8I84plJujAeYmsjgNcWU0MZc4i
	5zaIuuBTYbmuihbtMv+BA5Hs3TyJ5G1mh3A10pCBeXZ7MFjehJlWKGc0FxCLUK75
	uvEpjEyZeNZPgFLkVHHSbkxFBDHRmubEG+mOYjAeZAS/oP8qfhfE57CMaE/MVxPq
	FOvF86oNvMS03kM3Teuk/6CeJiVNFxN+injUXQAsLedjmw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4NXAhfY5d2U5; Wed, 11 Jun 2025 15:25:00 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bHTwv59NczlgqVK;
	Wed, 11 Jun 2025 15:24:46 +0000 (UTC)
Message-ID: <79d40bb9-ec40-415d-80eb-4ae8ab150737@acm.org>
Date: Wed, 11 Jun 2025 08:24:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/25 5:14 AM, Hazem Mohamed Abuelfotoh wrote:
> Given that moving plug list to a single linked list was mainly for
> performance reason then let's revert commit <e70c301faece> ("block: don't
> reorder requests in blk_add_rq_to_plug") for now to mitigate the
> reported performance regression.

Reverting that commit would break zoned storage support and hence is not
an option.

Bart.
