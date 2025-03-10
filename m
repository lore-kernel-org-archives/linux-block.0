Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883F28EA
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603332; cv=none; b=Mgc10nUrl/ScAnqLSFnaLafzBIYXOkK/9cjJ77gy0v0TkZ2DBLfxMe+n408PDReulJD1J/5dKHt94fb8fiGqjGV9LqqAzvUz+dZhuEp/4l6MAXlZfzMmmvGQF44BbXr0iufvA3WWLj6H7tba21t2Em1laRaGiLYApNCC8tpnRJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603332; c=relaxed/simple;
	bh=tGngBk9zhll8GZ9x8Ktwp1qRSKC4uLagcKykGPL8H7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo4IoCMO0IfgupZ+TqagV9M/3sO6+RD42SuXQjT65KL4jMD/tOD9Xv1XZMZbSbd+2Nqv6DG5DxxMt0G8DcqcKs7I5zh3WNhmh1h+7i+5d9nT82VAUx/Iuid5yg3eUtmJE0aZgRy2ySUWF7EVXvL7cJRKxMYdqJDp+Ux6IQVJzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37FF168B05; Mon, 10 Mar 2025 11:42:03 +0100 (CET)
Date: Mon, 10 Mar 2025 11:42:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCH] block: protect hctx attributes/params using
 q->elevator_lock
Message-ID: <20250310104202.GA4542@lst.de>
References: <20250306093956.2818808-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306093956.2818808-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	 * nr_requests and wbt_lat_usec. Additionally the nr_hw_queues update may

This adds an overly long line.

Otherwise the change looks good to me.

