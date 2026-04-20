Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0107633E373;
	Mon, 20 Apr 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702227; cv=none; b=aO6RAk7ZwKHIqE5GbcgGoAccqruwncBHo+P2Cn7l6xcF+bGvxsFkHpjg9l5rChb8A2IFgH6nn9i+aAmItLeLrETBy5d1Vn4OrbF63Xj60R2leqigjbb7P2Jey+5ZVpInLD944wkLGd5UoLWjk1LK+b3T4L+A5qoV/oPQTiTZc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702227; c=relaxed/simple;
	bh=NYpK3CouJHTPSPnW9Gh1DVfkxNtG87b+vm5qv2RXJDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYeEnKPHa4gy61wSAAvgydSYYb/P7ZHDG1ufh92Vr/ECuHYeRqaM+pQkYF0SiSw+FdKjZDTZ4K4YHn2y7DSBPlmwq3wd4M4ql9X4M5zWZByLS5uSwyAj2ANup/jmaKGq8zKg4N4H5CtdIZN4KMbhSdruJnpUDBqY1QFTKrArl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSC//jY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSC//jY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DB4C19425;
	Mon, 20 Apr 2026 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702226;
	bh=NYpK3CouJHTPSPnW9Gh1DVfkxNtG87b+vm5qv2RXJDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSC//jY7mGMBjwY7optqRVj88BXjb7Jh2Jll/0zFdpjftbBmgP22DdXUp6lFMPS1L
	 s17hiWgLHrsoHjy64bNu3Sa8Qvs6oLzEExK92AIs47goMR+GxS2281H7MhIGLt5yZZ
	 Z4YljSeMwLe/TUwwKc1G0xhLG7ImQlJ1q/vy8QPx66I2nm+CLQeZ8+3lSga68vbVTD
	 tLUNnyk/rNeak7LtCnMI/B3hSR8UfZuv/TSfgKZV1JOphVoy6tNTccaPy9A8boZQdU
	 jfR8Y+djgDA5MwFJOiwAsuA7w2mCFrRrlPUFebhip/ZKpAY7E+K3K5vBbzKGYPw/Sa
	 Upyn9BMg5E+zQ==
Date: Mon, 20 Apr 2026 10:23:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: alistair23@gmail.com
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com, mlombard@arkamax.eu,
	linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 1/2] Revert "nvmet-tcp: Don't free SQ on authentication
 success"
Message-ID: <aeZTEAYE6uryLbuf@kbusch-mbp>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417004809.2894745-1-alistair.francis@wdc.com>

On Fri, Apr 17, 2026 at 10:48:08AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In an attempt to fix REPLACETLSPSK we stopped freeing the secrets on
> successful connections. This resulted in memory leaks in the kernel, so
> let's revert the commit. A improved fix is being developed to just avoid
> clearing the tls_key variable.
> 
> This reverts commit 2e6eb6b277f593b98f151ea8eff1beb558bbea3b.

Thanks, patches 1 and 2 applied to nvme-7.1.
