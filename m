Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF219E992
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866685; cv=none; b=O1QeQm4XFnKwpN1I+LE4iqFqHJJV8PwtnKmLNBYxT7mVmeRyqNKYoN7gZtKSorzj9Jxf2ngNyY/fLZlbwK8KWexWUomNjHXbMy+vPK4L17ORNWVMolkcJdhhPXvSqpQYHxZncfxvr2svutIllMA6NxPLRb7FFO6cXeEMW13Z1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866685; c=relaxed/simple;
	bh=jVEiXunR0VAzgKxfNgeDcji4ziXL3DwYZyufzngcaLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVSZ/X8MT6MbSN93XhOokZ0sSt+k/lusqGbDqG45apz7CLw6ICW/Ri/38DPn6lMGWK6dPEwGUiGeWhKM7mGm6aNWibvOCgbIkDCyqk0jXFl8dJtymYhgFNbjKN4S4+NWxBBBNMOOpP8i3JerUkMhR7hBlJVkMSuNyJBOmnjhfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E406227A87; Mon,  7 Jul 2025 07:37:50 +0200 (CEST)
Date: Mon, 7 Jul 2025 07:37:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	alan.adamson@oracle.com, linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [bug report] nvme4: inconsistent AWUPF, controller not added
 (0/7).
Message-ID: <20250707053749.GA28625@lst.de>
References: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com> <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com> <20250703080359.GA365@lst.de> <CAHj4cs_pJDR-VH7-RzGwt9KmNCdTnQ38bejeB72280e9ke8ebg@mail.gmail.com> <aGc5wlj0Vgk6Mf6d@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGc5wlj0Vgk6Mf6d@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 04, 2025 at 10:17:38AM +0800, Ming Lei wrote:
> Per NVMe spec, AWUPF unit is 'logical blocks', and logical block size is changed
> by 'nvme format', so AWUPF value retuned from `Identify command` can be changed
> because the controller implements fixed-length atomic write size(512*8, 4096 * 1)?
> 

Yes.  And that's an issue because NVMe doesn't have a controller-level
concept of a logical bloc ksize, the logical block size is per-namespace.

Or in other words, AWUPF is a mess.

