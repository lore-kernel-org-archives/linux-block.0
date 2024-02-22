Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162A14B824
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629629; cv=none; b=C9UHI3t1w3U0soQDpISFz0wL3hcnGNw9W7pxJYB8JK4/wZLKr+k6h2IZTTyuKJhyyvABz3WtkyKQWRJmlYEfIr2is01nl8utYcAjt9OTbVG4KWwzmZ8i19WK6r914lYIcQEuYBIpWgIwwfINgaWC3QoMMXllHLO/Zk7SkfB8+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629629; c=relaxed/simple;
	bh=6Yimpkcq/UrAUJHls9TM0NjBSOogff/ui2fsRj6F46M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/nM2Y5I6P2AlR7+2Jnnri4gXveyJO4+FjZB1dcIQteg8Lgs5m0smFSpH9fS4v/QU19LML0LiyvG7IvJReQJx5PcehGfMqvgAKvs7KrsBZRUbn63/RuXnfjL3QyBA5uImbIRfu2ViErA+qnK8WbUFZNjaN44mh0s9fr5iQGWAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE6/Q4dc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE6/Q4dc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E49C433C7;
	Thu, 22 Feb 2024 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708629628;
	bh=6Yimpkcq/UrAUJHls9TM0NjBSOogff/ui2fsRj6F46M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lE6/Q4dckKB5nMW/K/yqAh7Xl8tGCR/ptNajHwvF8TYZx3O1LGD28Wk8L8t6RfIpw
	 iEorhULvdxrkV4yv17TZRy9yxgUwa9znmmSluryRyd7gzJGqkIAxN/MPbTHcga70E7
	 cXVO8GshjYkL8HmSRo20u80rlCLtp0364vIDbPO7BcAmUKMwxIYZnmSk3WkBnadHNg
	 dOGaLno1n10U/jHeXoajzqhAogiFeakd4gK2OVR5kWHVwfWQvAbg5dlbnn9lL4fSWK
	 WIjWk1F83fhfnEKMf1JuTzWXhHHf14LPJczXhxNdnESukIXgVj5C/3CsZdzqbmkIuE
	 NfF0USGSEzm4g==
Date: Thu, 22 Feb 2024 12:20:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, ming.lei@redhat.com,
	nilay@linux.ibm.com, chaitanyak@nvidia.com,
	Conrad Meyer <conradmeyer@meta.com>
Subject: Re: [PATCHv2] blk-lib: check for kill signal
Message-ID: <ZdeeeYIH0TtNDmkH@kbusch-mbp>
References: <20240222191802.2125909-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222191802.2125909-1-kbusch@meta.com>

Sorry, please ignore this; I pointed git-send-email to the wrong
directory.
