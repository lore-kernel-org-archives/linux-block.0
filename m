Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E31E04BD;
	Wed, 29 Jan 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175965; cv=none; b=fkmig88hU27jlhBp4jnHk4Xo64MEgaB1nfZffAnTXb8+4Nu+VhLbx83kCi4o+JFcB5JMkbMViEYn6E2A07SWrI3aakjlPKYM5gBvHQdB/sM8pHDnAE+Ve9DhNiyvU2MzOSXu7fJbDpP28CkczU1jUJbf9TSkfG6wtwWP9gPJmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175965; c=relaxed/simple;
	bh=inaXZEkG5qTCLCyeiXKTHQhfKOCqT5k0FMO8Ol4EZ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDMwbuZLXlbQudcCOiBAuSq3O8wWK3Css6ppkS99SM5Ibx38kWmUcpP9QwSjvdMUJbG3UZHMXfNUnPCuvBwtxI/t7Lm2J3nesq8FmhSU/S9gj6Eu4ofbRFTmdW5cCYsZ4tzZu6IIy+eoay+MUCQuCvRq7bbhUWytNfaXmv+XIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIZ+NEVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIZ+NEVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D088C4CED1;
	Wed, 29 Jan 2025 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738175964;
	bh=inaXZEkG5qTCLCyeiXKTHQhfKOCqT5k0FMO8Ol4EZ+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIZ+NEVDyjE1YJe7CwGx1Ygfu6g1cMwv9niAOvE6oZs34VQWisZncgQreB9O/qiKL
	 3AfHkcFPH/efQeNQNajKZsT8t9Ewb20fIzrkANYOrktm2n9mda6+TrdxpVF1oqxcTe
	 BZi8nsTO+TFuqS+VG6QclmoFxJv2JEtb0lgBVaA5Cp+qy8SBZIfYhQvb7g7DB//qOE
	 tvFMA+o60FeCFJNmSLpRKnbG6MIGZ+gX+klNAeRI+voiWIM7jLu28PyMN+r3IC1/Y+
	 7jC8ouR0ZzkOU2bkZTBPFg0WP0v2aKsjugN1ZzDMqBRDlAeN4LH+cLsuSV4hNcuuL8
	 EbMuNi5J6DIIw==
Date: Wed, 29 Jan 2025 11:39:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme-fc: use ctrl state getter
Message-ID: <Z5p12hWxmdIadNIX@kbusch-mbp>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-nvme-misc-fixes-v1-2-40c586581171@kernel.org>

On Tue, Jan 28, 2025 at 05:34:47PM +0100, Daniel Wagner wrote:
> Do not access the state variable directly, instead use proper
> synchronization so not stale data is read.
> 
> Fixes: e6e7f7ac03e4 ("nvme: ensure reset state check ordering")

Thanks, applied to nvme-6.14.
