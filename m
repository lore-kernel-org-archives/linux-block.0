Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA1318B85
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990118; cv=none; b=u7gsTe9GRGBOybMsQRJngBzBz+BUeCYRHvLFT+E11n+oWUTOFKNb0ipA9PYeHBGtKkVgnOSp2UsLkYnfEELEedhW17Q9H2x+vjsUMHxlTweqphcaKlpGcHxRuYzNmrAW6z4yaUCiJI+uaz4t9zaAWG723XTHzIFWVCkbaQ1dZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990118; c=relaxed/simple;
	bh=1k7KQy8OBzRzVKDO1clnBBQF2t+WItDbjRPPcJo7jFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rED6tirRgjVMbZDQiZtYLE2Pe81uF/iemOHmpdNHVy4YxvniPWBozHzhv7olSmJafQFife+R85245aJvgytU4yjJFFzUA/pZ/fG4FBnSPIz3QmWlT3wb5aGYvrcjfWyVk4X6a1RTjtKW8SoVWWow1MJ2YbVRontCzpMxwQ/FgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fj3rz0z8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fj3rz0z8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GsYD70yDlULNNacQZMULeSKit2kKkOeG2bxsH2JA33s=; b=Fj3rz0z8vRUIINuAVgrep0Zngq
	gDuXLrdoeg3qqCDzjX/AOiVS8Sjymv+yhklZKcMRAKWnB8tS/OunasqODSncPkisaOHAhmnKk4nrs
	yiknhs7XOv0kPWXKnU63Ln1hankeNynkAcZ8SujWHl3sMLj5VQ0VD5VqOtrZ0wHeOLLw05cvFM+p4
	I7Q9IZGdwPS1ehTIEwtWbajr0Ea8oI39eY326H6LuEx9WNsl3MjvRQ9mn1Z01qWSGCReqrjqICLdw
	qF4x8AJpWyc1u+GNTMS2k5COquIDfDahrwlu+rB6o4P8NXT+nRnlRqm80cA/v1jc1jJPh16ThVAVu
	copdZOFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWqst-00000004xsx-3gM8;
	Tue, 09 Jun 2026 07:28:27 +0000
Date: Tue, 9 Jun 2026 00:28:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Message-ID: <aifAm1rRKF75HVeM@infradead.org>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hannes,

can you share your results on the mailing list?

On Thu, Feb 19, 2026 at 10:54:48AM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> I (together with the Czech Technical University) did some experiments trying
> to measure memory fragmentation with large block sizes.
> Testbed used was an nvme setup talking to a nvmet storage over
> the network.
> 
> Doing so raised some challenges:
> 
> - How do you _generate_ memory fragmentation? The MM subsystem is
>   precisely geared up to avoid it, so you would need to come up
>   with some idea how to defeat it. With the help from Willy I managed
>   to come up with something, but I really would like to discuss
>   what would be the best option here.
> - What is acceptable memory fragmentation? Are we good enough if the
>   measured fragmentation does not grow during the test runs?
> - Do we have better visibility into memory fragmentation other than
>   just reading /proc/buddyinfo?
> 
> And, of course, I would like to present (and discuss) the results
> of the testruns done on 4k, 8k, and 16k blocksizes.
> 
> Not sure if this should be a storage or MM topic; I'll let the
> lsf-pc decide.
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 
> 
---end quoted text---
