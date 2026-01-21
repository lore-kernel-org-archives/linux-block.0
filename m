Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA2478E59
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983936; cv=none; b=L447Xl7/YuFJ5iJDPOiSzV62KF4Z7vsLsHpk9HL7G9Ru2E7YNSkeZH0vMzxjqXg04gDFdrcooPHOAz75qB9XPD0UUcSDSt8gS1mo1CC1GumTpnXXWxPvfOUZ8+o6OpC96Nukl7ECF+RnCom7A/mshREPCtS4j8kCb4X9ULpHAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983936; c=relaxed/simple;
	bh=xhhpFCSKViNKZANYHjspLNKZvbDFhd3sog0YaQtISf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWV12fG7U1R90Nz4weQivKPkVJy3kc1AXw1uDqCkUqou1ldDlLZTqiVNEO7g1n1BkQkCljJaxgKaOfKZ7Cph+uuxKGV2GZJL8tFc8j/usJyeAY0quu+g0A7jD90NJyObo4sVIQN5FMEbjHTPk0rkjR1eQBu3A7B5VSREHpeYlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 967AF227AAC; Wed, 21 Jan 2026 09:25:27 +0100 (CET)
Date: Wed, 21 Jan 2026 09:25:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU
 in nvme_tcp_poll() on the latest linux-block/for-next
Message-ID: <20260121082527.GA15293@lst.de>
References: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Any chance you could bisect it to the offending commit?

