Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217833D6E4
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513255; cv=none; b=NWijuzCEkdjAcXOJ/4SqaE2IhMGUnWwkvPBniqgRFW3KclEHsCzQVcgZkOMLpJUyDk5r8zhbvPa9PRCo7TqOgNvIh8JyKwn1M8h2qoNP+abGSS355Yq345vgvlP/u8pOJbAbr9xjjAUHihzqdydgrfokwEtLBtM12ITjl62/I7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513255; c=relaxed/simple;
	bh=mP4ZC0TEh8C+GrS8QKMlO+6aITosKr4Nbnd175LCzeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/aAqrc8IC6jYN6EFf7HUTxalg0xAirS9uBfKzARSe6S4iIj7X5uyfECm3KlHBY0ZPr3503XVuv6hwAbamUcAA2ZYFPzPGYTj4jIVaRVrdAY/1uxltOXjlICv5cMIi5/sfP/NIfdKtAk3TDGVBEPgejt8LD7t+0sXgbr4NDiHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sZCLI2iw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sZCLI2iw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mP4ZC0TEh8C+GrS8QKMlO+6aITosKr4Nbnd175LCzeQ=; b=sZCLI2iwwtDfv00ulHbwZN08JS
	TG+1RH2RthzkUqgNN3LdKJHRV3O9/7TFc3cpinGW4bWdeq7CYbRKtkueZoVdj+Up7Rs38+ep+1i+Z
	5hIeas+id064CMRlUo7sS6M36RAekYqpHKTzCZhGm7hNJBWOzbvMfV7uXHHpewouWOGE6pC2YEF1n
	JfdVeuc+Tc+On2OpMsWmvb6GiQpa07Q/Blyb2FrKdWGSW45CIaCKszXUX5wKIkXwvoBX3WrIVy7Tc
	QYGRXMmIa97PF2633C1GJfvVDb3SJaPZUSb67gYcj0N86jsPD/BkaK8MqgdkHJFobr7stM+99RX7T
	Gq97demg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt5WL-00000007lC1-3YKs;
	Thu, 19 Feb 2026 15:00:49 +0000
Date: Thu, 19 Feb 2026 15:00:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Message-ID: <aZclobp0vgE2YKRK@casper.infradead.org>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
 <e2733d9f-823d-433b-9bfd-24df20b98b7d@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2733d9f-823d-433b-9bfd-24df20b98b7d@acm.org>

On Thu, Feb 19, 2026 at 06:53:28AM -0800, Bart Van Assche wrote:
> Additionally, why is contiguous memory required for block sizes
> larger than the page size? Does this perhaps come from the VFS layer?
> If so, is this something that can be fixed?

No.
