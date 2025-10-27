Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1752F5B
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548642; cv=none; b=UbNLOgXuDc4meiUzmeh+kYByShRMbBQ5g/GCGGMhHKM56ob7v8pyEogZ+H4bzTwmMeKmB/ZbO17oPGwpjw0um1AGiU172QFC3Js+fENP4dUIT0cH2bM1dCvF39SLcNUkYUbvYpceMKaqqtLrg3UjU4IZLpmm0Tfn3RiRFVZ+OgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548642; c=relaxed/simple;
	bh=I4BZEVsT4N9ItGNlbKA6PPmEqEhIs8ef+XFaVZsmKAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0+uo/Hw9mLb8NqoEP0OKVWs2ezOw1qdBYuYIQ3gtS/4bL/UI0PHMzhzbMxcldZnNMzrZ7bIqGgFdkVX1s58LR229HWr0Z4dakFLHgJ16i1HoV//jN29GXBbOvwBmlAG7UegHYjKZnnCXiQjxXJaiwz5RuuIg1M0DFAOsEJNOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e8SODV7U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e8SODV7U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KBgS5GQRPhuljz2T9eEAJE1d1SppKX4njzsaNoeJeBk=; b=e8SODV7UWsNmJ6CTLIOGnFSuX3
	Dj9eyh0zI+53N6/zTeCbL2fCEGNuSQEt5lhjRIQaiHyNb0xeDo54tctop4eYudE3+Db1VtTFoFMn1
	eGlgL3Ex/+1awEc5bJL6I6OV+DpwyzI6wmFAVe2rfEnNqjMDMU/VwIme/6BDV+WiK6n2vEjXtSCWX
	shlW5YYTTVUorJGrANPwVSB1isMSA1u4+4PJR+SV8kkXA/3DU4CZ3fi3BFXQD29vc+LE80qL+OH06
	rCfcfMeTFhjCNtBU3eOqZo63ku9ZYOs96/JufJMAbrKCOrJge/RS2Y8lZ60netGjul+ZuWqCpyOwV
	L8zM69iQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHGq-0000000DFTO-0vjp;
	Mon, 27 Oct 2025 07:04:00 +0000
Date: Mon, 27 Oct 2025 00:04:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix op_is_zone_mgmt() to handle
 REQ_OP_ZONE_RESET_ALL
Message-ID: <aP8ZYDaZgAPerY9F@infradead.org>
References: <20251027002733.567121-1-dlemoal@kernel.org>
 <20251027002733.567121-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027002733.567121-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 09:27:32AM +0900, Damien Le Moal wrote:
> REQ_OP_ZONE_RESET_ALL is a zone management request. Fix
> op_is_zone_mgmt() to return true for that operation, like it already
> does for REQ_OP_ZONE_RESET.
> 
> While no problems were reported without this fix, this change allows
> strengthening checks in various block device drivers (scsi sd,
> virtioblk, DM) where op_is_zone_mgmt() is used to verify that a zone
> management command is not being issued to a regular block device.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

