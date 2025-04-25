Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2443146
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592347; cv=none; b=pz5M+wPVtOlfNoTYNVNNIT4EKiS8X4IRfKD9BSU2Qbipv/ma0JPvtKy74dFzreAq5+OCwcux6joFSjWY7iAluGH07zpfdZYSPNfP8T4b6M1wfAK1n/tQg8Cd9MpEwAyVdW2h/CAHusMNy+GXhMezoF2AeUdQUYVzwciQy3tIfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592347; c=relaxed/simple;
	bh=FryzTOA5OCb4MdZIY5slRRq2TF3oK6Zn8oOBxZvZqBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyXozHnN9XEV8+iJjp3riBLbgL//+Zpj9in7VOO92FC3JM6RymVTLskS+JTpHvl7z03xTOgzw4qxrGakMIXhIJ1+pVn5OPa3KvLVI35Qbwb9E4yUDHgcZ9yEMa+XmdAn4AQIl3BdFyEiVKzkn7TqnV5e+RbwdlMg1/MvmM/HOlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55A3C68B05; Fri, 25 Apr 2025 16:45:40 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:45:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module
 param
Message-ID: <20250425144540.GB12179@lst.de>
References: <20250425103319.1185884-1-nilay@linux.ibm.com> <20250425103319.1185884-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425103319.1185884-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 25, 2025 at 04:03:09PM +0530, Nilay Shroff wrote:
> +static int multipath_param_set(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = param_set_bool(val, kp);
> +	if (ret)
> +		return ret;
> +
> +	if (multipath_head_always && !*(bool *)kp->arg) {
> +		pr_err("Can't disable multipath when multipath_head_always is configured.\n");
> +		*(bool *)kp->arg = true;

This reads much nicer if you add a local bool * variable and avoid
all the casting, i.e.

	bool *arg = kp->arg;

	...

	if (multipath_head_always && !*kp->arg) {
		pr_err("Can't disable multipath when multipath_head_always is configured.\n");
		*arg = true;

> +static int multipath_head_always_set(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = param_set_bool(val, kp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (*(bool *)kp->arg)
> +		multipath = true;

Same here.

