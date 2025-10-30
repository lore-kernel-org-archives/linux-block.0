Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F536CE06;
	Thu, 30 Oct 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846996; cv=none; b=QQq+IORM3vXtbrKECaMERYdFRPOrtt/9sh3dBhoDFKgabIUfSP3C6Ip4cLLW1Xu13nnvvbAyAwG+HVUvZ9JU0iIG6ENttH8dFKP48qbPd/HMUH9YYbOhm++S6rHk7CQSXHUBeAUNefomGuZ2HZXgCXUC3e95uLypjyHtVUKBmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846996; c=relaxed/simple;
	bh=mwm5eTSkEuWGrdyR9+atXifBE3uTQt90HxWeDV+iaAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKXEAQ0K9FIOZGGk1hcPPTbo+pIvwucMohPxGMt3IWz8iLIi+I8v2ftt4lD8kLaLzGXLmI5xWbRkKICt4AdTITCAiymP7zGjWj/eDbFbpnDNbel3iRbAp7iRAZutNJgVSLMpS730M8nr+hUhTVxvagVOxf4eTyWhBr6xeCV9MXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxx1MJ1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxx1MJ1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBC4C4CEFB;
	Thu, 30 Oct 2025 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761846996;
	bh=mwm5eTSkEuWGrdyR9+atXifBE3uTQt90HxWeDV+iaAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxx1MJ1Q8q1gc0kqTfMR64liwkhDa+LJepcgefKlU8Q5/UUZvGWlVRupsSObx+/qF
	 d9oqPIA/FSl+ljENqFIWjb9xExEM/2E1Xh8KCUjPcjcYRKQ1QQoUR3nULI5B86kj4r
	 wVTmNiMZrUVpaw/UwjDYuSet3EQZyfRp6oP3NHoh19EoQphq9KzwbAwzCib1Pu6ZfW
	 J/FxyIVeACkN5m+gfSNB7/ABRC4+X/nqcSqqlr3Unl0hLwg/pGwoXZILma9lGHQPAG
	 2Z2n12HMwyUM2SEkAFxNCqEyj4m7HWBzOePt7e6G/cCcBiSVbW2lImAr4gYufXTxI0
	 1CNBfT4f7JwrQ==
Date: Thu, 30 Oct 2025 10:56:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: kernel test robot <lkp@intel.com>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Uday Shankar <ushankar@purestorage.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocation
Message-ID: <20251030175631.GB417112@ax162>
References: <20251029031035.258766-3-ming.lei@redhat.com>
 <202510301522.i47z9R95-lkp@intel.com>
 <CADUfDZonryeHe1MGTfnUa16VbvEt5C+yu11yh3ZRDbwFqJ_L9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZonryeHe1MGTfnUa16VbvEt5C+yu11yh3ZRDbwFqJ_L9w@mail.gmail.com>

On Thu, Oct 30, 2025 at 07:07:25AM -0700, Caleb Sander Mateos wrote:
> On Thu, Oct 30, 2025 at 1:01 AM kernel test robot <lkp@intel.com> wrote:
...
> > patch link:    https://lore.kernel.org/r/20251029031035.258766-3-ming.lei%40redhat.com
> > patch subject: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocation
> > config: x86_64-randconfig-074-20251030 (https://download.01.org/0day-ci/archive/20251030/202510301522.i47z9R95-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301522.i47z9R95-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202510301522.i47z9R95-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/block/ublk_drv.c:240:49: error: 'counted_by' argument must be a simple declaration reference
> >      240 |         struct ublk_queue       *queues[] __counted_by(dev_info.nr_hw_queues);
> >          |                                                        ^~~~~~~~~~~~~~~~~~~~~
> 
> Hmm, guess it doesn't support nested fields?

Correct. I think this is something that we want to support at some point
if I remember correctly but I think there was a lot of discussion
between GCC and clang on how to actually do it but Kees is free to
correct me if that is wrong.

Cheers,
Nathan
