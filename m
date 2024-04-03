Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021E1B950
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113678; cv=none; b=jJup04kSOrfyNU94dAlRLPbC7vkkIdKkQFYQiHQyIro15kmn/V5p60p82MsLMFaK+FZQO+xRFvrTZkqtpURICSpl7HCdVoSyb0fOQXRO3WCNemfbuJR/hfIUxYgmVmDb/LFlZ2pUX75aZ7sEg/oLYcwjSHvUCAnu8q4D+W73nf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113678; c=relaxed/simple;
	bh=6KCuRKqfBSyUGD9wEHT51sa9m5PJxRwSYfOSb1tiW3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucQotws0PgYamx2E+kbCV1apOY9zJok8JJLLV7Ku3inUojCrjlxxbPQge5BYwu6vSF0D1Cm7Gb+x/n/l7buyKiKLH8K8OeBnyCZS9UF8n2dd6JO55WEfckqgvit2afR2axWDZdLJW6bt1y5txU1Dw2UN0DGUVxrnSuoVijvUEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb0X0Vj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb0X0Vj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D8FC433C7;
	Wed,  3 Apr 2024 03:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712113678;
	bh=6KCuRKqfBSyUGD9wEHT51sa9m5PJxRwSYfOSb1tiW3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mb0X0Vj+U+f8ypJ33tvkOQomGTgWl9750eufi9XP6zXX6ANDmep652ynV7zUOvqzX
	 5Dsvz3MDFO1PGF1BC+IjpR7DYg5KS14JfpY4K0UIpI793TjOnDCndRnxqgf+rfl4Pa
	 wW3fjxu/mbwis+LqboxFJ1Q8fYaieQMX/dOeY+g89YAiBweyS5/oSue7Ik/YHEaQHw
	 PJih4yS3uTLcLTaoHmgfKoP8vcFh02iEAasgWuz10O1xxDaGpR9uGVyWsklAsZh5c/
	 Buc+py1iOZo0TifIBi67c19X7/OIpH2xZCrcK79mOros6gZyWGfETtYbjZq32L5iFy
	 IDelnkdpztiAQ==
Date: Tue, 2 Apr 2024 21:07:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, Gregory Joyce <gjoyce@ibm.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Message-ID: <ZgzIC-9buT_UKaeW@kbusch-mbp.dhcp.thefacebook.com>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
 <j37ytzci46pqr4n7juugxyykd3w6jlwegwhfduh6jlp3lgmud4@xhlvuquadge4>
 <BYAPR04MB415105995F0F45BFCFE48FEBBC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB415105995F0F45BFCFE48FEBBC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>

On Tue, Apr 02, 2024 at 10:07:25PM +0000, Kamaljit Singh wrote:
> 
> Hi Daniel,
> Your question about the nvme-cli version makes me wonder if there is a
> version compatibility matrix (nvme-cli vs kernel) somewhere you could
> point me to? I didn't see such info in the nvme-cli release notes.

I don't believe there's ever been an intentional incompatibility for
nvme-cli vs. kernel versions. Most of the incompatibility problems come
from sysfs dependencies, but those should not be necessary for the core
passthrough commands on any version pairing.

And yeah, there should be sane fallbacks for older kernels in case a new
feature introduces a regression, but it's not always perfect. We try to
fix them as we learn about them, so bug reports on the github are useful
for tracking that.

> For example, I've seen issues with newer than nvme-cli v1.16 on Ubuntu
> 22.04 (stock & newer kernels). From a compatibility perspective I do
> wonder whether circumventing a distro's package manager and directly
> installing newer nvme-cli versions might be a bad idea. This could
> possibly become dire if there were intentional version dependencies
> across the stack.

The struggle is real, isn't it? New protocol features are added upstream
faster than distro package updates provide their users. On the other
hand, distros may be cautious to potential instability.
