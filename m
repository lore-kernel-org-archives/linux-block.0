Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF938B
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307374; cv=none; b=erZl5piDR8LFCYcBqhR5vzFXjAy1aHxEtxcTbuWRLSj4RzTJnih+e5d81fnyaXJvqGQ6Llk71miVVc3qj3yze9DSl6Odc5IjEBCY/gAN76sO+z6oLruN6uXeFK9XxcGhUr4C4gOEw19+QZbvmeFX3/5hoyZcjpiz44HZK1d7FM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307374; c=relaxed/simple;
	bh=PY4dBAqRACbZUDh3RikZcK3ilURSYMZtTmO/suYaGwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+aVTO4C6Vh1YN8hLNu++k6aznp9dK8h7JYrkuOqhSZyO1jjeUZnAFm2+gZlFbvSE0jUdSoy3jt52XsCQQByTCJQFA2EHxnB1VhKd1bUbqHnTUxrWrRqWM3Rdg6oANbd13XwHCiIgUXSdJrZE31Li9yeIQ8WALeflavjZFBRszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A76D868C4E; Tue, 22 Apr 2025 09:36:07 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:36:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, hare@suse.de,
	sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250422073607.GA31849@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-2-nilay@linux.ibm.com> <20250407144413.GA12216@lst.de> <5db5ab7b-fdf2-4b40-86fc-3ab4ccff9a41@linux.ibm.com> <20250409104326.GA5359@lst.de> <385cbcd5-fcb1-4f98-bdf7-80b16d4f5f8e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385cbcd5-fcb1-4f98-bdf7-80b16d4f5f8e@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 18, 2025 at 04:15:55PM +0530, Nilay Shroff wrote:
>         }
> +
> +       if (head->delayed_shutdown_sec)
> +               return true;
> +

Please add a comment explaining this check, but otherwise that sounds
fine.  Your text below is a good start for that.

