Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F423BF8F
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748008859; cv=none; b=ImvdnklL3UARfqilDWIvbhoiGetkJJP1iA5667DDcWHZP7aFQMrBL7zbyguWJFNLtjJMRijbhfBIB/DeBFFqYNAxfH3AQ5hlnQU24Q0ztW+xQxScy/38kAiRx12hz17qqBnLGtCP5tZRkVWlA0y4zd9FSUZGyOjgptqm7VOTgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748008859; c=relaxed/simple;
	bh=PWKT9BG+lOtvl4QvvLndlFSfFz2NGYNjS1PlIS8vDlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeDNgiDL7q25ihoG+N6erts6fXmEix8fLkw7k4oaugErOGTnrRzkZmkYY5fIbrZrD6Rg1o55nEnmcd2qWx+h3ufwS2xZ1J3l+ImuKJ1cakH8w3SFA4POKpLAYNsfRyxHxRCQXObsvEMcG3SBlYCI4Z8ahmJ6yzYYTGTA9SNZnxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNEc06yq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNEc06yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A091FC4CEE9;
	Fri, 23 May 2025 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748008859;
	bh=PWKT9BG+lOtvl4QvvLndlFSfFz2NGYNjS1PlIS8vDlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNEc06yqdXJ/vMwreb8d+h1QOcGFlIUxaOGlQl5hkdUWEecTqo07MzRrBl8aTKCyo
	 utGfrhDEQhgsRwtIBSvw3HHp7pgh9ga18X5eGeriHBicjQ3sh4oTWlU0+vY5aCgyKI
	 YWEhv87psap40HIyDQgKIpLWoCcpj6H2jnXvfA2eFyux87nlk+DyYAUvB+kRM9ij7t
	 aSesbKUXoX8rMjik/XKWe8YYQieFJ3INwjUxiSvULGOWObN3M8OtY6LOiFnW6C09fz
	 0meP1qkyHOu2Y+rz7DtxS6TbVMy8nFIan2kBpNPxOF7GqwoZbDJQoQmxmZ+Nt8Pw82
	 mosvpYhoZeXaw==
Date: Fri, 23 May 2025 08:00:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/5] nvmet: implement copy support for bdev backed target
Message-ID: <aDB_mIZ5YUG32sHx@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-6-kbusch@meta.com>
 <aDB1p8XIhsauGFhc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB1p8XIhsauGFhc@infradead.org>

On Fri, May 23, 2025 at 06:18:31AM -0700, Christoph Hellwig wrote:
> I need this additional bit so that the host code actually see the
> copy support:

Thanks! I think it just needs to be constrained to bdev backed targets
since I don't have file support for copy offload here. And less
important, but for spec compliance, I need to update the Command Effects
Log too.
