Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9219007D;
	Tue, 11 Mar 2025 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663579; cv=none; b=fQkEdv6L6a4ULM9LotXGfpgfxOIdM4PKw3SzPGpPhJBP++EOU7Uty+Ds8T3x54E0EXYLOdfQ3WeSMHEuI+sMF4LJ0SDqWgiQ1Ij9ys9ibFU94bTLrXskLQMNGerX9m4kvtmgFZOTb/NO5fUkCB3jObQsd40iQESOv5I+kyz7O0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663579; c=relaxed/simple;
	bh=rIMjY2dFt+Lt1PyoYuCijFezfQk+o99NGZVJjN+fDUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBVpjzogjm+Y8m0EQ4T+wzLaHdGZ4YHfsT3r+C+ezvujHouMFIn5gVs4YpsEpZPIWPYa2mKsKzh+7/UaWdHXnq1BW6ocul9RnzfvUvdQM+CBGqLZLAIgGbNL6y29aRqI5f7RIJoVF4irrycAnA0G8A70WETK3TcEf4w4DZ7opho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOHVEl2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOHVEl2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41605C4CEE9;
	Tue, 11 Mar 2025 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741663577;
	bh=rIMjY2dFt+Lt1PyoYuCijFezfQk+o99NGZVJjN+fDUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOHVEl2vHwqln/qBGYJOl9jBduAi4KkQUiisN3H6pmLiP/HxPBqF5+0ZPWtY9w6la
	 mNrfVDfN+G9JANWRA4prIlgJ450bYErvsPrscMYR5ifP9yqx/L6fhEIjYmtwqpaAvW
	 8W1vcmfiW3V9/eN01vw/FCwQUGijwU636aPNqLM9SsrqEcBCXmIwS9V3mAgHOGgV1N
	 nngiJ6c3GaAQPvy3E00+Ck0VJLANGxZZbPq5BYigAHTRGZHw1Tncnw+156tUMo0mRs
	 aBJ869fkzLkGvuQZlhXMdVoKXFl8SOHwvRLhdd9rg7pyaj0MULorc+x44J3fDsBOFY
	 IWLKsapaExR2Q==
Date: Mon, 10 Mar 2025 20:26:15 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Li Wang <liwang@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	LTP List <ltp@lists.linux.it>,
	Christian Brauner <brauner@kernel.org>, 0day robot <lkp@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	oe-lkp@lists.linux.dev
Subject: Re: [LTP] [linux-next:master] [block/bdev] 47dd675323:
 ltp.ioctl_loop06.fail
Message-ID: <Z8-tV0zJKP7wRAxK@bombadil.infradead.org>
References: <202503101538.84c33cd4-lkp@intel.com>
 <CAEemH2egF6ehr7B_5KDLuBQqoUJ5k7bVZkid-ERDBkxkChi7fw@mail.gmail.com>
 <CAB=NE6UWzyq+qXhGmpH2-6bePE+Zi=dJjBH7y3HeJnYyh6xvtw@mail.gmail.com>
 <CAEemH2c21vrSOKdJvHkyH+UOv-aXefXeFVZuv4-DSZ_P4Z3Mxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEemH2c21vrSOKdJvHkyH+UOv-aXefXeFVZuv4-DSZ_P4Z3Mxw@mail.gmail.com>

On Tue, Mar 11, 2025 at 09:43:42AM +0800, Li Wang wrote:
> On Mon, Mar 10, 2025 at 11:15 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > There's a fix for this already in next
> >
> 
> Oh? Which commit?

Oh seems linux-next hasn't been updated in a few days, so you can try
this patch:

https://lore.kernel.org/all/20250307020403.3068567-1-mcgrof@kernel.org/

  Luis
