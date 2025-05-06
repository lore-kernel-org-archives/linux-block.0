Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFA2236F0
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506523; cv=none; b=WsFqCks/37aKflCyEW3jqgl8QMTDPLnym6/fh7qIpfKE8gafI+ebcVmifSR7MkpS+ohJYJXZaJZI4TIHwqG/CzTs5IbfZQYySig9cCtG0icFEtWmr6h8bpwURlMA9mn9nqTHUB+3+PvIjM4uarm4yvODir9oQxNPI13Gs9MEhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506523; c=relaxed/simple;
	bh=gutg1nm9QK6uRgpPsJeFhDMaJ5X4Q44ITlfEPtkdySs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izFvFShdF0exiLPIQHZlS9PjgZhkMRbt2pcc5PCNRuxJopsZeuVx4EjtYrtf5mL+9zx49HC5FvcUHStFSVbDDMo65dpEBPR3uoX0gF8zOj6BdhNwddGEPxasiCsgTAE3yF3VrH7bXEXXpL1jBxenetIK8VHRJ048DyRv83neZmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2875E67373; Tue,  6 May 2025 06:41:58 +0200 (CEST)
Date: Tue, 6 May 2025 06:41:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 12/25] block: move blk_queue_registered() check into
 elv_iosched_store()
Message-ID: <20250506044157.GD27061@lst.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com> <20250505141805.2751237-13-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505141805.2751237-13-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 05, 2025 at 10:17:50PM +0800, Ming Lei wrote:
> Move blk_queue_registered() check into elv_iosched_store() and prepare
> for using elevator_change() for covering any kind of elevator change in
> adding/deleting disk and updating nr_hw_queue.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(although I suspect we don't need the check at all, but that can be
dealt with later)

