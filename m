Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360FC2040A7;
	Tue,  3 Jun 2025 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976304; cv=none; b=RRh5NV8mJKuJa4u8lZ7fGI1jUGdszfju6/7lsldOaArgdSZeIm5r3dAeIaYUzBgHjT2s8IUVMdQ1w28KZN7QyMFs3nLQSfIeZwGb06XGKwQ09tJ7EDCRs4KZlVUCuQarNCuNLPuZ/szVaNNZFpUCA3d+n1CwreMYsno+VgclNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976304; c=relaxed/simple;
	bh=UicNXi5nItlGrkvevweK+v0Y7CDB5UMnlhQDiN+JelY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To+rsDEZ8OzhBzqTbajmCKqJoOFyqEnExDTraAqGfspJC0ZVG1dr4XzkAdKvAbvsFeTZWpWCAAICJTB/ihFhy4fo0njsrBxNGzLdIp0Fnj2BZmk1JN19iXxmlkLLrSWEBNphmphVUryNUsrYzx/A1LHHkY64rd6d/bX9XsgQSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/x961iv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/x961iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A29C4CEED;
	Tue,  3 Jun 2025 18:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748976303;
	bh=UicNXi5nItlGrkvevweK+v0Y7CDB5UMnlhQDiN+JelY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/x961ivtJw1jpzZCopNVw0QSUc7oCsHnWGdlecxMQcUb8v1xmtUOlcNtDt2VAlZ6
	 +nPIgr4dDGzr9CJqvlK3IIk4RdabsufIbeTeey/FO28eimiSMKNrPLSQLlBh/9y7BN
	 q2TWZBWaDy2veaRGi5aPbt+dHYHK29qDVauRmrK309INcP+Ycz8O+Da6IlaX5JL7py
	 uep/lfpJg9vQulHOhlfvQ/5akFjZtnKGcxSTKQkgIplKvBp2wX0q6LMBFCmY0HICe3
	 4Z9JL87XRfcy/6tK1327XIP9qrgCgPaaK3iufuyNdyyHM6Xy50MsI4wj2w1cQBtbmc
	 Xmj/Do1dgSxEQ==
Date: Tue, 3 Jun 2025 12:45:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: drop direction param from
 bio_integrity_copy_user()
Message-ID: <aD9CrGs5cBTKs2Xg@kbusch-mbp>
References: <20250603183133.1178062-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603183133.1178062-1-csander@purestorage.com>

On Tue, Jun 03, 2025 at 12:31:32PM -0600, Caleb Sander Mateos wrote:
> direction is determined from bio, which is already passed in. Compute
> op_is_write(bio_op(bio)) directly instead of converting it to an iter
> direction and back to a bool.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
