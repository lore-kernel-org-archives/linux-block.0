Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947928F4
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751595478; cv=none; b=KW3h8E2SS3AIkxtxB9l2jBtoYpqilfSx4uVswHwAWaXTiqexed256DF0Ifx7aRMF7u1JnpBf7g5dYu/VSOw7vw6hzRMhiadg6zIGSbyPodg2VuYMNMrwonR1F2OniqI3uFn/d4/pVcKaS7GxnMKKjOeZYHRL5mzLfsf6Ce4W7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751595478; c=relaxed/simple;
	bh=/IIxLfZ3T743hpVN6Uh9l3DlI2QbpXHCdpPvm/WE84U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozNJONQaEGWXbpBVL6qt0V/g34avQkrfpiUiYwNpSpemOolB0moAT6vyjWTed8lv1cGtcTXWbM74asS8uz9ct2fBf8xu3VnGJWMUcsshxJwkYHVOPYoPk548QC2RCFOlwyoi3QH4WUNMS6haO5SStLy/W9n+R0qC0lEMmDa6ypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmL1lOyc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmL1lOyc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751595475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FarKJlvmIvSzBW3L7HpMcZlXycBw+0IDuOFJCXeI2rw=;
	b=YmL1lOycJsJAWbr1nQWKgmzoY/WJzjnHCJn2SAe8GIi7nqwT3g6bNfFmTj2Rj/3Mb0AVHE
	8D1avTSuzU/xF0vepi6vzgT7f9we6H7uGwvtOkjHT1Y3BEJ1dwNBLNIGuN4v5mcQj2IZNp
	cGXyYxY7yFdz61ZwcYkNGXhOsAG8KUM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-c3dXgwzkOUW8Je8pZzNKMA-1; Thu,
 03 Jul 2025 22:17:52 -0400
X-MC-Unique: c3dXgwzkOUW8Je8pZzNKMA-1
X-Mimecast-MFC-AGG-ID: c3dXgwzkOUW8Je8pZzNKMA_1751595471
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4851219560BE;
	Fri,  4 Jul 2025 02:17:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B37851956087;
	Fri,  4 Jul 2025 02:17:44 +0000 (UTC)
Date: Fri, 4 Jul 2025 10:17:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, alan.adamson@oracle.com,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [bug report] nvme4: inconsistent AWUPF, controller not added
 (0/7).
Message-ID: <aGc5wlj0Vgk6Mf6d@fedora>
References: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com>
 <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com>
 <20250703080359.GA365@lst.de>
 <CAHj4cs_pJDR-VH7-RzGwt9KmNCdTnQ38bejeB72280e9ke8ebg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHj4cs_pJDR-VH7-RzGwt9KmNCdTnQ38bejeB72280e9ke8ebg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jul 04, 2025 at 01:47:50AM +0800, Yi Zhang wrote:
> On Thu, Jul 3, 2025 at 4:04 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jul 02, 2025 at 09:33:32AM -0700, alan.adamson@oracle.com wrote:
> > > Looks like the device isn't reporting AWUPF after the format/reset.
> >
> > The other option would be that the format changed the value.
> >
> > The mess NVMe creasted with the totally un-thought out atomics is
> > beyond belive :(
> >
> > I wonder if we should just back out the whole thing and wait for the
> > working group to come up with something that can actually safely work.
> >
> 
> Yeah, the format operation will change the awupf value.
> Here is the reset operation pass[1] and fail[2] log
> [1]
> + nvme format -l0 -f /dev/nvme3n1
> Success formatting namespace:1
> + nvme id-ctrl /dev/nvme3
> + grep awupf
> awupf     : 7
> + grep nawupf
> + nvme id-ns /dev/nvme3n1
> nawupf  : 7
> + nvme format -l1 -f /dev/nvme3n1
> Success formatting namespace:1
> + nvme id-ctrl /dev/nvme3
> + grep awupf
> awupf     : 0
> + nvme id-ns /dev/nvme3n1
> + grep nawupf
> nawupf  : 0
> + nvme reset /dev/nvme3
> + nvme id-ctrl /dev/nvme3
> + grep awupf
> awupf     : 0
> 
> [2]
> + nvme format -l0 -f /dev/nvme5n1
> Success formatting namespace:1
> + nvme id-ctrl /dev/nvme5
> + grep awupf
> awupf     : 7
> + nvme id-ns /dev/nvme5n1
> + grep nawupf
> nawupf  : 7
> + nvme format -l1 -f /dev/nvme5n1
> Success formatting namespace:1
> + nvme id-ctrl /dev/nvme5
> + grep awupf
> awupf     : 0

Per NVMe spec, AWUPF unit is 'logical blocks', and logical block size is changed
by 'nvme format', so AWUPF value retuned from `Identify command` can be changed
because the controller implements fixed-length atomic write size(512*8, 4096 * 1)?


Thanks,
Ming

