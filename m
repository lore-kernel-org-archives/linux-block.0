Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B696298CB6
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529855; cv=none; b=HJItf4u3c9SbL4YdQ99rXrqilBa3KecOt7fht6/AFoD/glkuMf2PBX7mY9K2I7/qPPPK03L7dD+O6vP3hUinnCsMBDQ/sjA6xRdNIrGmPTmaYbLPG1lEMTPUq30o32vvXd2mkQ8tTS5tsXmaETyR2BG4Vci0vQMwDmt0sNa6iZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529855; c=relaxed/simple;
	bh=bFMLsYx9yg/hn/nQJiMEvuhnsiGy591NtU5BpNmy/po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWC36TjiZnB6CZKbQbude2HV9WBDCtWeggGFlGbyTg+QYCc1GKM++t1SKaKsUThwUBYUo+EUfr6WJnfoW3WFaR0ZmNTXrhviSq0XYY4CZZ6nJR1LUkmK+GfVV66K3VeqN33BMEm0UTfDWWarJTsTvYQ1P+4NmyoKvkjmPmppfSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E7D168B05; Thu,  3 Jul 2025 10:04:00 +0200 (CEST)
Date: Thu, 3 Jul 2025 10:03:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [bug report] nvme4: inconsistent AWUPF, controller not added
 (0/7).
Message-ID: <20250703080359.GA365@lst.de>
References: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com> <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 02, 2025 at 09:33:32AM -0700, alan.adamson@oracle.com wrote:
> Looks like the device isn't reporting AWUPF after the format/reset.

The other option would be that the format changed the value.

The mess NVMe creasted with the totally un-thought out atomics is
beyond belive :(

I wonder if we should just back out the whole thing and wait for the
working group to come up with something that can actually safely work.

